import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';
import 'package:http/http.dart' as http;

class NotificationService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

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
}
