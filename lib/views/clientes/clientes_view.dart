import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/models/clientes_model.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/clientes_service.dart';
import 'package:legaltech_temis/core/services/proceso_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/views/clientes/widgets/search_input_widget.dart';
import 'package:legaltech_temis/widgets/appbar_actions_widget.dart';
import 'package:legaltech_temis/widgets/drawer_widget.dart';
import 'package:legaltech_temis/widgets/no_connection_view_widget.dart';
import 'package:legaltech_temis/widgets/no_data_view_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class ClientesView extends StatelessWidget {
  const ClientesView({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteService = context.watch<ClienteService>();
    Brightness currentBrightness = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clientes",
        ),
        actions: const [
          AppBarActionsWidget(),
        ],
      ),
      drawer: const DrawerWidget(),
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
              hinText: 'Buscar cliente',
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                if (clienteService.query != value) {
                  clienteService.query = value;
                  clienteService.getFilteredItems(value);
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
            FutureBuilder<Map<String, dynamic>>(
              future: clienteService.clientesLoaded
                  ? null
                  : clienteService.clientes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
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
                      ? Expanded(
                          child: NoConnectionView(
                            message: data["message"],
                            onPressed: () async {
                              clienteService.clientesLoaded = false;
                              print("🤣 ${clienteService.clientesLoaded}");
                            },
                          ),
                        )
                      : Expanded(
                          child: _buildDataView(
                            clienteService.query.isEmpty
                                ? clienteService.clienteModel
                                : clienteService
                                    .getFilteredItems(clienteService.query),
                            context,
                            clienteService.query,
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

  Widget _buildDataView(
    List<Cliente>? data,
    BuildContext context,
    String query,
    Brightness currentBrightness,
  ) {
    return data!.isNotEmpty
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 20,
                top: 10,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 5.0,
                children: List.generate(
                  data.length,
                  (index) {
                    final isEmpresa =
                        data[index].typeContact == "Empresa" ? true : false;
                    final email = jsonDecode(data[index].email ?? "");
                    return Container(
                      width: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? MediaQuery.of(context).size.width * 0.46
                          : MediaQuery.of(context).size.width * 0.92,
                      decoration: BoxDecoration(
                        color: currentBrightness == Brightness.light
                            ? Colors.grey.withOpacity(.1)
                            : Colors.grey.withOpacity(.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        style: ListTileStyle.list,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                              style: BorderStyle.none,
                            )),
                        splashColor: currentBrightness == Brightness.light
                            ? AppColors.secondary200
                            : AppColors.primary200,
                        onTap: () {
                          print(data[index].id);
                          final pService = context.read<ProcesoService>();
                          pService.query = "";
                          pService.procesoLoaded = false;

                          Navigator.pushNamed(
                            context,
                            Routes.procesos,
                            arguments: data[index].id,
                          );
                        },
                        leading: Icon(
                          isEmpresa
                              ? CupertinoIcons.building_2_fill
                              : CupertinoIcons.person_fill,
                          color: currentBrightness == Brightness.light
                              ? AppColors.primary
                              : Colors.white,
                        ),
                        title: AutoSizeText(
                          isEmpresa
                              ? "${data[index].nameCompany}".toUpperCase()
                              : "${data[index].name}, ${data[index].lastName}"
                                  .toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // RichText(
                            //   text: TextSpan(
                            //     text: isEmpresa ? "RUC: " : "DNI: ",
                            //     style: const TextStyle(
                            //       color: Colors.black87,
                            //       fontWeight: FontWeight.w500,
                            //     ),
                            //     children: [
                            //       TextSpan(
                            //         text: isEmpresa
                            //             ? data["data"][index]["ruc"]
                            //             : data["data"][index]["dni"],
                            //         style: const TextStyle(
                            //           color: Colors.black54,
                            //           fontWeight: FontWeight.w400,
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            AutoSizeText(
                              isEmpresa ? email["email"] : email["email"],
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
                    );
                  },
                ),
              ),
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
