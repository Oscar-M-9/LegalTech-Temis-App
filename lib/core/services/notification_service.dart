import 'dart:convert';
import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';
import 'package:http/http.dart' as http;

class NotificationService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  // int getUpdateCount() {
  //   notifyListeners();
  //   return Preferences.countNoti;
  // }

  // actualizamos el estado de la notificacion
  Future<Map<String, dynamic>> notificationUpdate(int id) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/update-estado-history-movements/$id')
        : Uri.http(_baseUrl, '/api/update-estado-history-movements/$id');

    try {
      // Obtiene el token almacenado
      final String? token = await storage.read(key: 'token');
      final response = await http.put(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "id": id,
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        // return decodeResponse;
        int length = Preferences.countNoti;
        Preferences.countNoti = length - 1;
        return {
          "status": true,
          "message": decodeResponse["message"],
          "id": decodeResponse["id"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      // print('Error en la solicitud: $e');
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "id": id,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "id": id,
      "statusCode": 404,
    };
  }

// traemos todas las notificaciones globales
  Future<Map<String, dynamic>> notification() async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/notificacion-reportes')
        : Uri.http(_baseUrl, '/api/notificacion-reportes');

    try {
      // Obtiene el token almacenado
      final String? token = await storage.read(key: 'token');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": null,
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        // return decodeResponse;
        List<dynamic> dataList = decodeResponse['data'];
        int length = dataList.length;
        Preferences.countNoti = length;
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": decodeResponse["data"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      // print('Error en la solicitud: $e');
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": null,
      "statusCode": 404,
    };
  }

  Future<Map<String, dynamic>> refreshNotification() async {
    final data = await notification();
    // HomeData.fromJson(data);
    notifyListeners();
    return {
      "status": true,
      "message": data["message"],
      "data": data["data"],
      "statusCode": data["statusCode"],
    };
  }

  //
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> onMessageApi() async {
    _updateBadgeCount();
    final resNoti = await notification();

    if (resNoti['data'] is List) {
      for (var notificacion in resNoti['data']) {
        final String title = notificacion['exp_n_exp'];
        final String body = notificacion['movi_accion_realizada'];
        final int id = notificacion[
            'id_history']; // Puedes usar un ID único para cada notificación

        if (id > Preferences.idUltNoti) {
          Preferences.idUltNoti = id;
          _showNotificationApi(title, body, id, notificacion);
        }
      }
    } else {
      // Manejar el caso en que notificaciones['data'] sea nulo o no sea una lista
      print('No se encontraron notificaciones válidas');
    }
    if (resNoti["status"] == true) {}
  }

  void _updateBadgeCount() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  Future<void> _showNotificationApi(title, body, id, notificacion) async {
    NotificationDetails? platformChannelSpecifics;
    if (Platform.isAndroid) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'com.legaltech.temis',
        'noti-ingytal',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        sound: UriAndroidNotificationSound(
          'asset://assets/sounds/mixkit-confirmation-tone-2867.wav',
        ),
      );
      platformChannelSpecifics =
          const NotificationDetails(android: androidPlatformChannelSpecifics);
    } else if (Platform.isIOS) {
      const DarwinNotificationDetails iosPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );
      platformChannelSpecifics =
          const NotificationDetails(iOS: iosPlatformChannelSpecifics);
    }
    final String entidad = notificacion["entidad2"];
    final int exp = notificacion["id_exp"];
    final String nExp = notificacion["exp_n_exp"];

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: '$id;$entidad;$exp;$nExp',
    );
  }
}
