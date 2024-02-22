// import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:legaltech_temis/core/models/company_model.dart';
// import 'package:legaltech_temis/core/preferences/preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  /// A notification action which triggers a App navigation event
  final String navigationActionId = 'id_3';

  PushNotificationService() {
    // _initNotifications();
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     _updateBadgeCount();
    //     _showNotification(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     _updateBadgeCount();
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     _updateBadgeCount();
    //   },
    // );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // final data = message.data;
      // final jsonCompany = jsonDecode(Preferences.dataCompany);
      // final Company company = Company.fromJson(jsonCompany);
      // if (data.containsKey('companyCode') &&
      //     data['companyCode'] == company.name) {
      //   _updateBadgeCount();
      //   _showNotification(message);
      // }
      _updateBadgeCount();
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
    });
  }

  // void notificationTapBackground(NotificationResponse notificationResponse) {
  //   // ignore: avoid_print
  //   print('notification(${notificationResponse.id}) action tapped: '
  //       '${notificationResponse.actionId} with'
  //       ' payload: ${notificationResponse.payload}');
  //   if (notificationResponse.input?.isNotEmpty ?? false) {
  //     // ignore: avoid_print
  //     print(
  //         'notification action tapped with input: ${notificationResponse.input}');
  //   }
  // }

  // Future<void> _initNotifications() async {
  //   // Configuración de flutter_local_notifications
  //   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //       FlutterLocalNotificationsPlugin();
  //   const AndroidInitializationSettings androidInitializationSettings =
  //       AndroidInitializationSettings(
  //           '@mipmap/ic_launcher'); // Reemplaza 'app_icon' con el nombre de tu icono de la aplicación
  //   const DarwinInitializationSettings iosInitializationSettings =
  //       DarwinInitializationSettings();
  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(
  //     android: androidInitializationSettings,
  //     iOS: iosInitializationSettings,
  //   );

  //   await flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onDidReceiveNotificationResponse:
  //         (NotificationResponse notificationResponse) {
  //       switch (notificationResponse.notificationResponseType) {
  //         case NotificationResponseType.selectedNotification:
  //           selectNotificationStream.add(notificationResponse.payload);
  //           break;
  //         case NotificationResponseType.selectedNotificationAction:
  //           if (notificationResponse.actionId == navigationActionId) {
  //             selectNotificationStream.add(notificationResponse.payload);
  //           }
  //           break;
  //       }
  //     },
  //     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  //   );
  // }

  // void notificationTapBackground(NotificationResponse notificationResponse) {
  //   switch (notificationResponse.notificationResponseType) {
  //     case NotificationResponseType.selectedNotification:
  //       selectNotificationStream.add(notificationResponse.payload);
  //       break;
  //     case NotificationResponseType.selectedNotificationAction:
  //       if (notificationResponse.actionId == navigationActionId) {
  //         selectNotificationStream.add(notificationResponse.payload);
  //       }
  //       break;
  //   }
  // }

  void _updateBadgeCount() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  Future<void> _showNotification(RemoteMessage message) async {
    NotificationDetails? platformChannelSpecifics;
    if (Platform.isAndroid) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'com.legaltech.temis',
        'noti-ingytal',
        importance: Importance.max,
        priority: Priority.high,
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

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platformChannelSpecifics,
      payload: 'home',
    );
  }
}
