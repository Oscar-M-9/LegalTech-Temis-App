import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/services/procesos_detalle_service.dart';
import 'package:legaltech_temis/views/procesos/pages/calendar_proceso_page.dart';
import 'package:legaltech_temis/views/procesos/pages/economic_judicial_page.dart';
import 'package:legaltech_temis/views/procesos/pages/seguimientos_indecopi_page.dart';
import 'package:legaltech_temis/views/procesos/pages/seguimientos_judicial_page.dart';
import 'package:legaltech_temis/views/procesos/pages/seguimientos_sinoe_page.dart';
import 'package:legaltech_temis/views/procesos/pages/seguimientos_suprema_page.dart';
import 'package:legaltech_temis/views/procesos/widget/item_tabs_widget.dart';
// import 'package:legaltech_temis/widgets/appbar_actions_widget.dart';
import 'package:provider/provider.dart';

class DetalleProcesoView extends StatelessWidget {
  final String entidad;
  final int exp;
  final String nExp;
  const DetalleProcesoView({
    super.key,
    required this.entidad,
    required this.exp,
    required this.nExp,
  });

  @override
  Widget build(BuildContext context) {
    final procesoDetalleService = context.watch<ProcesoDetalleService>();
    final ScrollController scrollController = ScrollController();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            nExp,
          ),
          // actions: const [
          //   AppBarActionsWidget(),
          // ],
        ),
        // drawer: const DrawerWidget(),
        body: Column(
          children: [
            ItemsTabsWidget(
              procesoDetalleService: procesoDetalleService,
              entidad: entidad,
              exp: exp,
            ),
            Expanded(
              child: IndexedStack(
                index: procesoDetalleService.indexTab,
                children: [
                  buildSeguimientoWidget(
                    entidad,
                    scrollController,
                    procesoDetalleService,
                  ),
                  buildEconomicWidget(
                    entidad,
                    procesoDetalleService,
                  ),
                  CalendarProcesoPage(
                    entidad: entidad,
                    exp: exp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSeguimientoWidget(
    String entidad,
    ScrollController scrollController,
    ProcesoDetalleService procesoDetalleService,
  ) {
    final Map<String, Widget> seguimientoWidgets = {
      "judicial": SeguimientoJudicialInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataJudicial,
        exp: exp,
      ),
      "CEJ Judicial": SeguimientoJudicialInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataJudicial,
        exp: exp,
      ),
      "suprema": SeguimientoSupremaInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataSuprema,
        exp: exp,
      ),
      "CEJ Suprema": SeguimientoSupremaInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataSuprema,
        exp: exp,
      ),
      "indecopi": SeguimientoIndecopiInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataIndecopi,
        exp: exp,
      ),
      "Indecopi": SeguimientoIndecopiInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataIndecopi,
        exp: exp,
      ),
      "sinoe": SeguimientoSinoeInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataSinoe,
        exp: exp,
      ),
      "Sinoe": SeguimientoSinoeInfiniteScrollPagination(
        scrollController: scrollController,
        fetchDataFunction: procesoDetalleService.fetchDataSinoe,
        exp: exp,
      ),
    };

    return seguimientoWidgets[entidad] ?? Container();
  }

  Widget buildEconomicWidget(
    String entidad,
    ProcesoDetalleService procesoDetalleService,
  ) {
    final Map<String, Widget> seguimientoWidgets = {
      "judicial": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicJudicial(exp),
        exp: exp,
      ),
      "CEJ Judicial": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicJudicial(exp),
        exp: exp,
      ),
      "suprema": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicSuprema(exp),
        exp: exp,
      ),
      "CEJ Suprema": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicSuprema(exp),
        exp: exp,
      ),
      "indecopi": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicIndecopi(exp),
        exp: exp,
      ),
      "Indecopi": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicIndecopi(exp),
        exp: exp,
      ),
      "sinoe": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicSinoe(exp),
        exp: exp,
      ),
      "Sinoe": EconomicJudicialPage(
        future: procesoDetalleService.fetchDataEconomicSinoe(exp),
        exp: exp,
      ),
    };

    return seguimientoWidgets[entidad] ?? Container();
  }
}
