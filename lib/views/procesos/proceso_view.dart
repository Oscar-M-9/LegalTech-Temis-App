import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:legaltech_temis/core/models/combined_procesos_model.dart';
import 'package:legaltech_temis/core/models/proceso_indecopi_model.dart';
import 'package:legaltech_temis/core/models/proceso_judicial_model.dart';
import 'package:legaltech_temis/core/models/proceso_sinoe_model.dart';
import 'package:legaltech_temis/core/models/proceso_suprema_model.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/procesos_detalle_service.dart';
import 'package:legaltech_temis/core/services/proceso_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/views/clientes/widgets/search_input_widget.dart';
import 'package:legaltech_temis/widgets/appbar_actions_widget.dart';
import 'package:legaltech_temis/widgets/no_data_view_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class ProcesoView extends StatelessWidget {
  final int idClient;
  const ProcesoView({
    super.key,
    required this.idClient,
  });

  @override
  Widget build(BuildContext context) {
    final procesoService = context.watch<ProcesoService>();
    Brightness currentBrightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Procesos",
        ),
        actions: const [
          AppBarActionsWidget(),
        ],
      ),
      // drawer: const DrawerWidget(),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
          /*  */
        },
        child: Column(
          children: [
            SearchInput(
              hinText: 'Buscar Proceso',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                if (procesoService.query != value) {
                  procesoService.query = value;
                  procesoService.getFilteredItems(value);
                }
              },
            ),
            // Divider(
            //   color: currentBrightness == Brightness.light
            //       ? Colors.black26
            //       : Colors.grey[600],
            // ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<CombinedDataProcesos>(
              // future: procesoService.procesoLoaded
              //     ? null
              //     : procesoService.procesos(idClient),
              future: procesoService.procesoLoaded
                  ? null
                  : procesoService.fetchCombinedData(idClient),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
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
                  // CombinedDataProcesos data = snapshot.data!;
                  // Implementa tu lógica para mostrar los datos aquí
                  return /* data["message"] == "No hay conexión a Internet"
                      ? Expanded(
                          child: NoConnectionView(
                            message: data["message"],
                            onPressed: () async {
                              procesoService.procesoLoaded = false;
                              print("🤣 ${procesoService.procesoLoaded}");
                            },
                          ),
                        )
                      : */
                      Expanded(
                    child: _buildDataView(
                      // procesoService.query.isEmpty
                      //     ? procesoService.expedienteModel
                      //     : procesoService
                      //         .getFilteredItems(procesoService.query),
                      procesoService.query.isEmpty
                          ? procesoService.combinedDataProcesos
                          : procesoService
                              .getFilteredItems(procesoService.query),
                      context,
                      procesoService.query,
                      currentBrightness,
                    ),
                  );
                } else {
                  return const NoDataViewWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataView(CombinedDataProcesos data, BuildContext context,
      String query, Brightness currentBrightness) {
    return data.expedienteJudicial.isNotEmpty ||
            data.expedienteSuprema.isNotEmpty ||
            data.expedienteIndecopi.isNotEmpty ||
            data.expedienteSinoe.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
                top: 10,
              ),
              child: Wrap(spacing: 8.0, runSpacing: 8.0, children: [
                ...List.generate(
                  data.expedienteJudicial.length,
                  (index) {
                    return CardExpediente(
                      data: data,
                      index: index,
                      entidadProceso: "judicial",
                    );
                  },
                ),
                ...List.generate(
                  data.expedienteSuprema.length,
                  (index) {
                    return CardExpediente(
                      data: data,
                      index: index,
                      entidadProceso: "suprema",
                    );
                  },
                ),
                ...List.generate(
                  data.expedienteIndecopi.length,
                  (index) {
                    return CardExpediente(
                      data: data,
                      index: index,
                      entidadProceso: "indecopi",
                    );
                  },
                ),
                ...List.generate(
                  data.expedienteSinoe.length,
                  (index) {
                    return CardExpediente(
                      data: data,
                      index: index,
                      entidadProceso: "sinoe",
                    );
                  },
                ),
              ]),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    "¡Lo siento, no se encontraron resultados!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class CardExpediente extends StatelessWidget {
  final CombinedDataProcesos data;
  final int index;
  final String entidadProceso;
  const CardExpediente({
    super.key,
    required this.data,
    required this.index,
    required this.entidadProceso,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return Container(
      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? MediaQuery.of(context).size.width * 0.46
          : MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: currentBrightness == Brightness.light
            ? Colors.grey.shade50
            : Colors.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        style: ListTileStyle.list,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
        splashColor: currentBrightness == Brightness.light
            ? AppColors.secondary200
            : AppColors.primary200,
        onTap: () {
          final procesoJudicialService = context.read<ProcesoDetalleService>();
          procesoJudicialService.data.clear();
          procesoJudicialService.indexTab = 0;
          // procesoJudicialService.isLastPage = false;
          // procesoJudicialService.isLoading = false;
          // procesoJudicialService.page = 1;
          Navigator.pushNamed(
            context,
            Routes.detalleProceso,
            arguments: {
              "entidad": entidadProceso,
              "exp": entidadProceso == "judicial"
                  ? data.expedienteJudicial[index].id
                  : entidadProceso == "suprema"
                      ? data.expedienteSuprema[index].id
                      : entidadProceso == "indecopi"
                          ? data.expedienteIndecopi[index].id
                          : entidadProceso == "sinoe"
                              ? data.expedienteSinoe[index].id
                              : "",
              "nExp": entidadProceso == "judicial"
                  ? data.expedienteJudicial[index].nExpediente
                  : entidadProceso == "suprema"
                      ? data.expedienteSuprema[index].nExpediente
                      : entidadProceso == "indecopi"
                          ? data.expedienteIndecopi[index].numero
                          : entidadProceso == "sinoe"
                              ? data.expedienteSinoe[index].nExpediente
                              : "",
            },
          );
        },
        leading: CircleAvatar(
          // radius: 20,
          backgroundColor: currentBrightness == Brightness.light
              ? AppColors.secondary600.withOpacity(.4)
              : AppColors.secondary400.withOpacity(.5),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: _getImageForEntity(entidadProceso),
              width: 100,
              height: 100,
            ),
          ),
        ),
        title: AutoSizeText(
          entidadProceso == "judicial"
              ? "${data.expedienteJudicial[index].nExpediente}".toUpperCase()
              : entidadProceso == "suprema"
                  ? "${data.expedienteSuprema[index].nExpediente}".toUpperCase()
                  : entidadProceso == "indecopi"
                      ? "${data.expedienteIndecopi[index].numero}".toUpperCase()
                      : entidadProceso == "sinoe"
                          ? "${data.expedienteSinoe[index].nExpediente}"
                              .toUpperCase()
                          : "",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: entidadProceso == "judicial"
                    ? "Sumilla: "
                    : entidadProceso == "suprema"
                        ? "Delito: "
                        : entidadProceso == "indecopi"
                            ? "Estado: "
                            : entidadProceso == "sinoe"
                                ? "Sumilla: "
                                : "",
                style: TextStyle(
                  color: currentBrightness == Brightness.light
                      ? Colors.black54
                      : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: entidadProceso == "judicial"
                        ? data.expedienteJudicial[index].sumilla
                        : entidadProceso == "suprema"
                            ? data.expedienteSuprema[index].delito
                            : entidadProceso == "indecopi"
                                ? data.expedienteIndecopi[index].estado
                                : entidadProceso == "sinoe"
                                    ? data.expedienteSinoe[index].sumilla
                                    : "",
                    style: TextStyle(
                      color: currentBrightness == Brightness.light
                          ? Colors.black54
                          : Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: AutoSizeText(
                  entidadProceso == "judicial"
                      ? _getJudicialDate(data.expedienteJudicial[index])
                      : entidadProceso == "suprema"
                          ? _getSupremaDate(data.expedienteSuprema[index])
                          : entidadProceso == "indecopi"
                              ? _getIndecopiDate(data.expedienteIndecopi[index])
                              : entidadProceso == "sinoe"
                                  ? _getSinoeDate(data.expedienteSinoe[index])
                                  : "",
                  style: TextStyle(
                    color: currentBrightness == Brightness.light
                        ? Colors.black54
                        : Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getJudicialDate(Expediente expediente) {
  if (expediente.fechaIngreso == null && expediente.fechaResolucion == null) {
    return DateFormat.yMEd('es_ES').format(expediente.uDate ?? DateTime.now());
  } else {
    return expediente.fechaIngreso ?? expediente.fechaResolucion ?? "";
  }
}

String _getSupremaDate(ExpedienteSuprema expediente) {
  return expediente.fecha != null
      ? DateFormat.yMEd('es_ES').format(expediente.fecha ?? DateTime.now())
      : expediente.uDate ?? "";
}

String _getIndecopiDate(ExpedienteIndecopi expediente) {
  return expediente.fecha != null
      ? DateFormat.yMEd('es_ES').format(expediente.fecha ?? DateTime.now())
      : "";
}

String _getSinoeDate(ExpedienteSinoe expediente) {
  return expediente.fecha != null
      ? DateFormat.yMEd('es_ES').format(expediente.fecha ?? DateTime.now())
      : expediente.uDate ?? "";
}

AssetImage _getImageForEntity(String entity) {
  switch (entity) {
    case "judicial":
      return const AssetImage("assets/images/attorney.png");
    case "suprema":
      return const AssetImage("assets/images/attorney.png");
    case "indecopi":
      return const AssetImage("assets/images/logo-indecopi.png");
    case "sinoe":
      return const AssetImage("assets/images/sinoe-logo.png");
    default:
      return const AssetImage("assets/images/attorney.png");
  }
}
