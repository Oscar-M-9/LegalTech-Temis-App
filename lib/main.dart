import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/core/routes/app_routes.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:legaltech_temis/core/providers/password_visibility_provider.dart';
import 'package:intl/date_symbol_data_local.dart';

// import 'package:legaltech_temis/core/services/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: "assets/.env");
  await initializeDateFormatting('es_ES', null);
  await Preferences.init();
  // Configuración de flutter_local_notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Reemplaza 'app_icon' con el nombre de tu icono de la aplicación
  const DarwinInitializationSettings iosInitializationSettings =
      DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iosInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannelGroup(
        const AndroidNotificationChannelGroup(
          'com.temisperu.legaltech_temis', // Id del grupo
          'Temis-LegalTech', // Nombre del grupo
        ),
      );

//   // Escuchar el stream de notificaciones
//   flutterLocalNotificationsPlugin.onNotification
//       .listen((NotificationDetails notification) async {
//     // Manejar la notificación cuando la aplicación está en primer plano (foreground)
//     print('Notificación recibida en primer plano');
//   });

// // Escuchar el stream de selección de notificaciones
//   flutterLocalNotificationsPlugin.onSelectNotification
//       .listen((String? payload) async {
//     // Manejar la selección de notificación aquí
//     if (payload != null) {
//       print('Notificación seleccionada con payload: $payload');
//       // Puedes realizar acciones específicas basadas en el payload
//     }
//   });

//
  runApp(MultiProvider(
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
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: Routes.verifyAuth,
      routes: appRoutes,
    );
  }
}
