import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/models/proceso_task_model.dart';
import 'package:legaltech_temis/core/services/proceso_task_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TaskProcesoPage extends StatelessWidget {
  final String entidad;
  final Future<Map<String, dynamic>> future;
  final int exp;
  const TaskProcesoPage({
    super.key,
    required this.entidad,
    required this.exp,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    final procesoTaskService = context.read<ProcesoTaskService>();
    Brightness currentBrightness = Theme.of(context).brightness;

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingView(); // Vista de carga
        } else if (snapshot.hasError) {
          return _buildErrorView(); // Vista de error
        } else if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!;
          if (data["statusCode"] == 200) {
            final TaskProceso taskModel = TaskProceso.fromJson(data["data"]);
            return _buildDataView(
              taskModel,
              currentBrightness,
            ); // Vista con datos
          } else {
            return _buildNoConnectionView(
                context, data, procesoTaskService); // Vista sin conexión
          }
        } else {
          return const Text("nodata"); // Sin datos
        }
      },
    );
  }
}

Widget _buildNoConnectionView(BuildContext context, Map<String, dynamic> data,
    ProcesoTaskService procesoTaskService) {
  // Brightness currentBrightness = Theme.of(context).brightness;
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
      ],
    ),
  );
}

Widget _buildLoadingView() {
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
      ),
    ),
  );
}

Widget _buildErrorView() {
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
}

Widget _buildDataView(TaskProceso taskModel, Brightness currentBrightness) {
  List<Widget> taskWidgets = [];

  if (taskModel.groupStages!.isNotEmpty) {
    taskWidgets.addAll([
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          taskModel.groupStages![0].nombreFlujo.toString().toUpperCase(),
          style: TextStyle(
            color: currentBrightness == Brightness.light
                ? Colors.grey.shade900
                : Colors.grey.shade400,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ...taskModel.workFlowTaskExpediente!.map(
        (item) => CardTask(
          name: item.nombre,
          description: item.descripcion,
          estado: item.estado,
          fecha: item.fechaFinalizada,
        ),
      ),
    ]);
  } else if (taskModel.taskExpediente!.isNotEmpty) {
    taskWidgets.addAll([
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          "Otras tareas".toUpperCase(),
          style: TextStyle(
            color: currentBrightness == Brightness.light
                ? Colors.grey.shade900
                : Colors.grey.shade400,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ...taskModel.taskExpediente!.map(
        (item) => CardTask(
          name: item.nombre,
          description: item.descripcion,
          estado: item.estado,
          fecha: item.fechaFinalizada,
        ),
      ),
    ]);
  } else {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Text(
          "No se ha encontrado ninguna tarea en curso",
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 15),
    child: ListView(
      children: taskWidgets,
    ),
  );
}

class CardTask extends StatelessWidget {
  final String? name;
  final dynamic fecha;
  final String? description;
  final String? estado;
  const CardTask({
    super.key,
    this.name,
    this.fecha,
    this.description,
    this.estado,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ).copyWith(
            top: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: currentBrightness == Brightness.light
                ? Colors.white
                : Colors.black,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      fecha != null
                          ? Text(
                              fecha,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                AutoSizeText(
                  description ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 2,
          child: Container(
            decoration: BoxDecoration(
              color: currentBrightness == Brightness.light
                  ? estado == "Aprobada"
                      ? const Color.fromARGB(255, 68, 210, 156)
                      : estado == "Rechazada"
                          ? const Color.fromARGB(255, 244, 90, 78)
                          : const Color.fromARGB(255, 52, 188, 238)
                  : estado == "Aprobada"
                      ? const Color.fromARGB(255, 99, 187, 153)
                      : estado == "Rechazada"
                          ? const Color.fromARGB(255, 197, 100, 93)
                          : const Color.fromARGB(255, 113, 186, 213),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                estado ?? "",
                style: TextStyle(
                  color: currentBrightness == Brightness.light
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
