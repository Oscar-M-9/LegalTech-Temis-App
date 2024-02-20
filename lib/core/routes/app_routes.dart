import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/views/calendar/calendar_view.dart';
import 'package:legaltech_temis/views/clientes/clientes_view.dart';
import 'package:legaltech_temis/views/home/home_view.dart';
// import 'package:legaltech_temis/views/main_view.dart';
import 'package:legaltech_temis/views/login/login_view.dart';
import 'package:legaltech_temis/views/notificaciones/notificaciones_view.dart';
import 'package:legaltech_temis/views/procesos/detalle_procesos_view.dart';
import 'package:legaltech_temis/views/procesos/pages/pdf_view_page.dart';
import 'package:legaltech_temis/views/procesos/pages/video_player_page.dart';
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
    Routes.detalleProceso: (context) {
      final detalle = getArguments<Map<String, dynamic>>(context);
      final exp = detalle["exp"];
      final nExp = detalle["nExp"];
      final entidad = detalle["entidad"];
      return DetalleProcesoView(
        entidad: entidad,
        exp: exp,
        nExp: nExp,
      );
    },
    Routes.pdfView: (context) {
      final pdfViewer = getArguments<Map<String, dynamic>>(context);
      final url = pdfViewer["url"];
      final name = pdfViewer["name"];
      return PdfViewerPage(
        pdfUrl: url,
        name: name,
      );
    },
    Routes.videoView: (context) {
      final pdfViewer = getArguments<Map<String, dynamic>>(context);
      final url = pdfViewer["url"];
      final name = pdfViewer["name"];
      return VideoPlayerPage(
        videoUrl: url,
        name: name,
      );
    },
  };
}
