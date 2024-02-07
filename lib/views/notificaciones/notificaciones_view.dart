import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/models/notification_model.dart';
import 'package:legaltech_temis/core/services/notification_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/core/utils/funtions_util.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class NotificacionesView extends StatelessWidget {
  const NotificacionesView({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    final notificationService = context.watch<NotificationService>();
    // final res = await notificationService.notification;
    // final notifi = NotificationAll.fromJson(res);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notificaciones",
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: notificationService.notification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
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
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data!;
            // Implementa tu lógica para mostrar los datos aquí
            return data["message"] == "No hay conexión a Internet"
                ? _buildNoConnectionView(context, data, notificationService)
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 15,
                    ),
                    child: YesNotification(
                      currentBrightness: currentBrightness,
                      data: data,
                    ),
                  );
          } else {
            return NoNotification(currentBrightness: currentBrightness);
          }
        },
      ),
    );
  }

  Widget _buildNoConnectionView(BuildContext context, Map<String, dynamic> data,
      NotificationService notificationService) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return Padding(
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
              data["message"],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              notificationService.refreshNotification();
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
                ? Colors.grey[300]
                : Colors.grey[800],
            splashColor: AppColors.primary900.withOpacity(.1),
            child: const Text(
              "Reintentar",
            ),
          )
        ],
      ),
    );
  }
}
// *  Widget que se muestra cuando si hay notificaciones

class YesNotification extends StatelessWidget {
  const YesNotification({
    super.key,
    required this.currentBrightness,
    required this.data,
  });

  final Brightness currentBrightness;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final notifi = NotificationAll.fromJson(data);
    return ListView.builder(
      itemCount: notifi.data?.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: 10,
            right: 10,
            left: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: currentBrightness == Brightness.light
                ? Colors.grey[100]
                : Colors.grey[800],
          ),
          child: ListTile(
            style: ListTileStyle.list,
            contentPadding: const EdgeInsets.only(
              top: 5,
              right: 16,
              left: 16,
              bottom: 10,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: CircleAvatar(
              // radius: 20,
              backgroundColor: currentBrightness == Brightness.light
                  ? AppColors.secondary600.withOpacity(.4)
                  : AppColors.secondary400.withOpacity(.5),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: getImageForEntity(notifi.data?[index].entidad ?? ""),
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            title: Text(
              notifi.data?[index].expNExp ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: currentBrightness == Brightness.light
                    ? Colors.black
                    : Colors.grey[300],
              ),
            ),
            subtitle: Text(
              capitalize(notifi.data?[index].moviAccionRealizada ?? ""),
              style: TextStyle(
                color: currentBrightness == Brightness.light
                    ? Colors.black54
                    : Colors.grey[400],
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}

// *  Widget que se muestra cuando no hay ninguna notificación

class NoNotification extends StatelessWidget {
  const NoNotification({
    super.key,
    required this.currentBrightness,
  });

  final Brightness currentBrightness;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
            ),
            child: AutoSizeText(
              "Todo bien por aquí, no tienes ninguna notificación :)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentBrightness == Brightness.light
                    ? Colors.grey[800]
                    : Colors.grey[600],
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

AssetImage getImageForEntity(String entity) {
  switch (entity) {
    case "CEJ Judicial":
    case "CEJ Suprema":
      return const AssetImage("assets/images/attorney.png");
    case "Indecopi":
      return const AssetImage("assets/images/logo-indecopi.png");
    case "Sinoe":
      return const AssetImage("assets/images/sinoe-logo.png");
    default:
      return const AssetImage("assets/images/attorney.png");
  }
}
