import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:legaltech_temis/core/models/company_model.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
import 'package:legaltech_temis/core/services/home_service.dart';
// import 'package:legaltech_temis/core/services/notification_service.dart';
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/core/utils/funtions_util.dart';
import 'package:legaltech_temis/widgets/appbar_actions_widget.dart';
// import 'package:legaltech_temis/core/utils/modalsheet_calendar_utils.dart';
import 'package:legaltech_temis/widgets/drawer_widget.dart';
import 'package:legaltech_temis/widgets/no_connection_view_widget.dart';
import 'package:legaltech_temis/widgets/no_data_view_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // Future<void> showNotification(
  //     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //     NotificationService notifiService) async {
  //   final Map<String, dynamic> notificaciones =
  //       await notifiService.notification();

  //   // ignore: unnecessary_null_comparison
  //   if (notificaciones != null && notificaciones['data'] is List) {
  //     for (var notificacion in notificaciones['data']) {
  //       final String title = notificacion['exp_n_exp'];
  //       final String body = notificacion['movi_accion_realizada'];
  //       final int id = notificacion[
  //           'id_history']; // Puedes usar un ID único para cada notificación

  //       // Muestra la notificación
  //       await _showNotification(
  //         flutterLocalNotificationsPlugin,
  //         id,
  //         title,
  //         body,
  //         "$id-Temis",
  //       );
  //     }
  //   } else {
  //     // Manejar el caso en que notificaciones['data'] sea nulo o no sea una lista
  //     print('No se encontraron notificaciones válidas');
  //   }
  // }

  // Future<void> _showNotification(
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  //   int id,
  //   String title,
  //   String body,
  //   String? payload,
  // ) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'com.temisperu.legaltech_temis',
  //     'Temis-LegalTech',
  //     channelDescription: 'Notificaciones',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     groupKey: 'com.temisperu.legaltech_temis',
  //     playSound: true,
  //     tag: "Temis-LegalTech",
  //   );

  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(
  //     id,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //     payload: 'custom_payload_$id',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final jsonCompany = jsonDecode(Preferences.dataCompany);
    final Company company = Company.fromJson(jsonCompany);
    final homeService = context.watch<HomeService>();

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();
    // final notifiService = context.watch<NotificationService>();
    // showNotification(flutterLocalNotificationsPlugin, notifiService);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize(company.name),
        ),
        actions: const [
          AppBarActionsWidget(),
        ],
      ),
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: homeService.home,
        color: AppColors.primary400,
        child: FutureBuilder<Map<String, dynamic>>(
          future: homeService.home(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [
                      AppColors.primary200,
                      AppColors.primary300,
                      AppColors.primary500,
                      AppColors.primary800,
                      AppColors.primary900,
                    ],
                    strokeWidth: 2,
                    // backgroundColor: Colors.black,
                    // pathBackgroundColor: Colors.black,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Expanded(
                child: Center(
                  child: Text(
                    "Ocurrió un error inesperado",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data!;
              // Implementa tu lógica para mostrar los datos aquí
              return data["message"] == "No hay conexión a Internet"
                  ? NoConnectionView(
                      message: data["message"],
                      onPressed: () async {
                        homeService.refreshHome();
                      },
                    )
                  : _buildDataView(data, context);
            } else {
              return const NoDataViewWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDataView(Map<String, dynamic> data, BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return data["status"] == true
        ? SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 20,
                  top: 10,
                ),
                child: Wrap(
                  spacing: 14.0,
                  runSpacing: 15.0,
                  children: List.generate(
                    data["data"]["namesProcesos"].length,
                    (index) {
                      return Container(
                        constraints: const BoxConstraints(
                            minWidth: 350.0, maxWidth: 450.0),
                        width: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? MediaQuery.of(context).size.width * 0.4
                            : MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: currentBrightness == Brightness.light
                              ? Colors.white
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.folder,
                                        color: currentBrightness ==
                                                Brightness.light
                                            ? AppColors.primary
                                            : Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        data["data"]["namesProcesos"][index],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    data["data"]["listExpedientes"][index] >
                                            9999
                                        ? "9999+"
                                        : "${data["data"]["listExpedientes"][index]}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        // height: 110,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: currentBrightness ==
                                                  Brightness.light
                                              ? Colors.grey.shade100
                                              : Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.attach_money,
                                                color: currentBrightness ==
                                                        Brightness.light
                                                    ? Colors.greenAccent
                                                    : Colors.green,
                                                size: 30,
                                              ),
                                              AutoSizeText(
                                                "Ingresos",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: currentBrightness ==
                                                          Brightness.light
                                                      ? Colors.greenAccent
                                                      : Colors.green,
                                                ),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaRecaudacionMountSol"]
                                                        [index],
                                                    "Sol"),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaRecaudacionMountDolar"]
                                                        [index],
                                                    "Dólar"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        // height: 110,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: currentBrightness ==
                                                  Brightness.light
                                              ? Colors.grey.shade100
                                              : Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.leaderboard,
                                                color: currentBrightness ==
                                                        Brightness.light
                                                    ? Colors.yellow[400]
                                                    : Colors.yellow,
                                                size: 30,
                                              ),
                                              AutoSizeText(
                                                "Comisiones",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: currentBrightness ==
                                                          Brightness.light
                                                      ? Colors.yellow[400]
                                                      : Colors.yellow,
                                                ),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaComisionesMountSol"]
                                                        [index],
                                                    "Sol"),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaComisionesMountDolar"]
                                                        [index],
                                                    "Dólar"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        // height: 110,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: currentBrightness ==
                                                  Brightness.light
                                              ? Colors.grey.shade100
                                              : Colors.black26,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.money_off,
                                                color: currentBrightness ==
                                                        Brightness.light
                                                    ? Colors.redAccent
                                                    : Colors.red,
                                                size: 30,
                                              ),
                                              AutoSizeText(
                                                "Gastos",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: currentBrightness ==
                                                          Brightness.light
                                                      ? Colors.redAccent
                                                      : Colors.red,
                                                ),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaGastosMountSol"]
                                                        [index],
                                                    "Sol"),
                                              ),
                                              AutoSizeText(
                                                formatearMoneda(
                                                    data["data"][
                                                            "listSumaGastosMountDolar"]
                                                        [index],
                                                    "Dólar"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    data["message"] +
                        " \n Si el error persiste, cierre sesión y vuelva a iniciarla",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async {
                    final authService = context.read<AuthService>();
                    final String? message = await authService.logout();
                    if (message == null) {
                      SnackbarCustomService.showSnackbar(
                        'Error en la solicitud',
                        backgroundColor: Colors.red.shade700,
                      );
                    } else if (message == "No hay conexión a Internet") {
                      Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade600,
                        textColor: Colors.white,
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.login,
                        (route) => false, // Elimina todas las rutas anteriores
                      );
                      SnackbarCustomService.showSnackbar(
                        message,
                        backgroundColor: Colors.green,
                      );
                    }
                  },
                  elevation: 2,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: currentBrightness == Brightness.light
                      ? Colors.red[400]
                      : Colors.red[500],
                  splashColor: AppColors.primary900.withOpacity(.1),
                  child: Text(
                    "Cerrar sesión",
                    style: TextStyle(
                      color: currentBrightness == Brightness.light
                          ? Colors.white
                          : Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

String formatearMoneda(int valor, String moneda) {
  String separadorMillar = '.'; // Separador de miles
  String simboloMoneda;

  if (moneda == "Sol") {
    simboloMoneda = "S/.";
  } else if (moneda == "Dólar") {
    simboloMoneda = "\$";
  } else {
    simboloMoneda = "";
  }

  return simboloMoneda +
      valor.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}$separadorMillar');
}
