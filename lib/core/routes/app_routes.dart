import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/views/calendar/calendar_view.dart';
import 'package:legaltech_temis/views/clientes/clientes_view.dart';
import 'package:legaltech_temis/views/home/home_view.dart';
// import 'package:legaltech_temis/views/main_view.dart';
import 'package:legaltech_temis/views/login/login_view.dart';
import 'package:legaltech_temis/views/notificaciones/notificaciones_view.dart';
import 'package:legaltech_temis/views/procesos/proceso_view.dart';
import 'package:legaltech_temis/views/verify_auth_view.dart';

T getArguments<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.verifyAuth: (context) => const VerifyAuthView(),
    Routes.login: (context) => const LoginView(),
    Routes.home: (context) => const HomeView(),
    // Routes.settings: (context) => const SettingsView(),
    Routes.calendar: (context) => const CalendarView(),
    Routes.notificaciones: (context) => const NotificacionesView(),
    Routes.clientes: (context) => const ClientesView(),
    Routes.procesos: (context) {
      final idClient = getArguments<int>(context);
      return ProcesoView(
        idClient: idClient,
      );
    },
  };
}
