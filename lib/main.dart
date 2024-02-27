// import 'dart:io';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/providers/connectivity_provider.dart';
import 'package:legaltech_temis/core/providers/login_provider.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
import 'package:legaltech_temis/core/services/calendar_service.dart';
import 'package:legaltech_temis/core/services/clientes_service.dart';
import 'package:legaltech_temis/core/services/home_service.dart';
import 'package:legaltech_temis/core/services/notification_service.dart';
import 'package:legaltech_temis/core/services/proceso_calendar_service.dart';
import 'package:legaltech_temis/core/services/procesos_detalle_service.dart';
import 'package:legaltech_temis/core/services/proceso_service.dart';
import 'package:legaltech_temis/core/services/push_notification_service.dart';
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/core/routes/app_routes.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:legaltech_temis/core/providers/password_visibility_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:legaltech_temis/firebase_options.dart';

import 'package:provider/provider.dart';

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

/// IMPORTANT: running the following code on its own won't work as there is
/// setup required for each platform head project.
///
/// Please download the complete example app from the GitHub repository where
/// all the setup has been done

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "assets/.env");
  await initializeDateFormatting('es_ES', null);
  await Preferences.init();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  String initialRoute = Routes.verifyAuth;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload =
        notificationAppLaunchDetails!.notificationResponse?.payload;
    initialRoute = Routes.home;
  }

  // Configuración de flutter_local_notifications
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Reemplaza 'app_icon' con el nombre de tu icono de la aplicación

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  final DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        ),
      );
    },
    notificationCategories: darwinNotificationCategories,
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationStream.add(notificationResponse.payload);
          break;
        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationStream.add(notificationResponse.payload);
          }
          break;
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

//
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PasswordVisibilityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeService(),
        ),
        ChangeNotifierProvider(
          create: (_) => CalendarService(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ClienteService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProcesoService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProcesoDetalleService(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProcesoCalendarService(),
        ),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) =>
            MyApp(notificationAppLaunchDetails, initialRoute: initialRoute),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp(
    this.notificationAppLaunchDetails, {
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  final String initialRoute;
  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  bool notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      if (mounted) {
        setState(() {
          notificationsEnabled = granted;
        });
      }
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      if (mounted) {
        setState(() {
          notificationsEnabled = grantedNotificationPermission ?? false;
        });
      }
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                // Navigator.of(context, rootNavigator: true).pop();
                await navigatorKey.currentState!.pushNamed(Routes.clientes);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      if (payload != null) {
        List<String> parts = payload.split(';');
        int id = int.parse(parts[0]);
        String entidad = parts[1];
        int exp = int.parse(parts[2]);
        String nExp = parts[3];

        final notiService = context.read<NotificationService>();
        await notiService.notificationUpdate(id);
        await navigatorKey.currentState!.pushNamed(
          Routes.detalleProceso,
          arguments: {
            "entidad": entidad,
            "exp": exp,
            "nExp": nExp,
          },
        );
      }
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationStream.close();
    selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PushNotificationService();
    final notificationService = context.read<NotificationService>();
    notificationService.onMessageApi();

    return MaterialApp(
      /*  */
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      /*  */
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Temis',
      scaffoldMessengerKey: SnackbarCustomService.msgkey,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: AppColors.baseColor,
        cardColor: CupertinoColors.systemGrey6,
        colorScheme: const ColorScheme.light(),
        // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: Typography.material2018().black,
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            color: AppColors.primary,
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
        primaryColor: AppColors.primary,
        primarySwatch: AppColors.primeColor,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          backgroundColor: AppColors.white,
          foregroundColor: CupertinoColors.darkBackgroundGray,
          titleTextStyle: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            color: CupertinoColors.darkBackgroundGray,
            fontSize: 18,
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary800, // Color del cursor
          selectionColor: AppColors.primary400, // Color del texto seleccionado
          selectionHandleColor:
              AppColors.primary700, // Color de las asas de selección
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
        ),
        // bottomAppBarTheme: BottomAppBarTheme(
        //   color: AppColors.primary200,
        // ),
      ).copyWith(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        colorScheme: const ColorScheme.dark(),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          // backgroundColor: AppColors.primary950,
          foregroundColor: Colors.grey[200],
          titleTextStyle: const TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
          ),
        ),
        cardColor: CupertinoColors.systemGrey,
        textTheme: const TextTheme(
          labelMedium: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary800, // Color del cursor
          selectionColor: AppColors.primary400, // Color del texto seleccionado
          selectionHandleColor:
              AppColors.primary700, // Color de las asas de selección
        ),
        // bottomAppBarTheme: BottomAppBarTheme(
        //   color: AppColors.black,
        // ),
      ).copyWith(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system, // La aplicación seguirá el tema del sistema
      // themeMode: themeProvider.themeMode,
      // home: MainView(),
      // initialRoute: Routes.verifyAuth,
      initialRoute: widget.initialRoute,
      routes: appRoutes,
    );
  }
}
