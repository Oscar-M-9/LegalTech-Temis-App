import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:legaltech_temis/core/services/procesos_detalle_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/widgets/no_data_view_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';
// import 'package:provider/provider.dart';

int totalPagadoSol = 0;
int totalPagadoDolar = 0;
int totalNoPagadoSol = 0;
int totalNoPagadoDolar = 0;

class EconomicJudicialPage extends StatelessWidget {
  final int exp;
  final Future<List<Map<String, dynamic>>> future;
  const EconomicJudicialPage({
    super.key,
    required this.exp,
    required this.future,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: currentBrightness == Brightness.light
              ? AppColors.white
              : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: currentBrightness == Brightness.light
                    ? AppColors.secondary300
                    : AppColors.primary900,
                // border: Border(
                //   bottom: BorderSide(
                //     color: AppColors.primary.withOpacity(.3),
                //     width: 1,
                //   ),
                // ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Datos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Monto",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: future,
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // totalPagadoSol = 0;
                  // totalPagadoDolar = 0;
                  // totalNoPagadoSol = 0;
                  // totalNoPagadoDolar = 0;
                  return const Expanded(
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
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
                  List<Map<String, dynamic>> data = snapshot.data!;
                  // Implementa tu lógica para mostrar los datos aquí
                  if (data.isEmpty) {
                    totalPagadoSol = 0;
                    totalPagadoDolar = 0;
                    totalNoPagadoSol = 0;
                    totalNoPagadoDolar = 0;
                  }
                  for (int index = 0; index < data.length; index++) {
                    if (index == 0) {
                      totalPagadoSol = 0;
                      totalPagadoDolar = 0;
                      totalNoPagadoSol = 0;
                      totalNoPagadoDolar = 0;
                    }
                    if (data[index]["moneda"] == "Sol" &&
                        data[index]["status"] == "Si") {
                      totalPagadoSol += data[index]["mount"] as int;
                    }
                    if (data[index]["moneda"] == "Dólar" &&
                        data[index]["status"] == "Si") {
                      totalPagadoDolar += data[index]["mount"] as int;
                    }
                    if (data[index]["moneda"] == "Sol" &&
                        data[index]["status"] == "No") {
                      totalNoPagadoSol += data[index]["mount"] as int;
                    }
                    if (data[index]["moneda"] == "Dólar" &&
                        data[index]["status"] == "No") {
                      totalNoPagadoDolar += data[index]["mount"] as int;
                    }
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        _buildDataView(data, context),
                        Container(
                          decoration: BoxDecoration(
                            // color: AppColors.primary900.withOpacity(.3),
                            border: Border(
                              top: BorderSide(
                                color: currentBrightness == Brightness.light
                                    ? Colors.grey.shade400
                                    : AppColors.primary200.withOpacity(.3),
                                width: 1,
                              ),
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Total (Pagado)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      // color: Colors.black,
                                      fontSize: 15,
                                      // fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        formatAmountWithCurrencySymbol(
                                          totalPagadoSol,
                                          "Sol",
                                        ),
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          // color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        formatAmountWithCurrencySymbol(
                                          totalPagadoDolar,
                                          "Dólar",
                                        ),
                                        textAlign: TextAlign.end,
                                        style: const TextStyle(
                                          // color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Total (No Pagado)",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    // color: Colors.black,
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      formatAmountWithCurrencySymbol(
                                        totalNoPagadoSol,
                                        "Sol",
                                      ),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        // color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      formatAmountWithCurrencySymbol(
                                        totalNoPagadoDolar,
                                        "Dólar",
                                      ),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        // color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
    List<Map<String, dynamic>> data,
    BuildContext context,
  ) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: currentBrightness == Brightness.light
                      ? Colors.grey.shade200
                      : AppColors.primary200.withOpacity(.3),
                  width: index == data.length - 1 ? 0 : 1,
                  style: index == data.length - 1
                      ? BorderStyle.none
                      : BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 20,
                        top: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          "${data[index]["type"]}: ${data[index]["titulo"]}",
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 20,
                      top: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        formatAmountWithCurrencySymbol(
                          data[index]["mount"] as int,
                          data[index]["moneda"],
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String formatAmountWithCurrencySymbol(int amount, String currency) {
  String currencySymbol = currency == "Sol" ? "S/." : "\$";
  String formattedAmount = NumberFormat.currency(
    locale: 'es_PE',
    symbol: '',
  ).format(amount);
  return currencySymbol + formattedAmount;
}
