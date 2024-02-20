import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/services/procesos_detalle_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';

class ItemsTabsWidget extends StatelessWidget {
  final String entidad;
  final int exp;
  const ItemsTabsWidget({
    super.key,
    required this.procesoDetalleService,
    required this.entidad,
    required this.exp,
  });

  final ProcesoDetalleService procesoDetalleService;

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: currentBrightness == Brightness.light
            ? Colors.white
            : Colors.black12,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () {
                  procesoDetalleService.indexTab = 0;
                },
                color: currentBrightness == Brightness.light
                    ? procesoDetalleService.indexTab == 0
                        ? AppColors.secondary400
                        : AppColors.secondary100
                    : procesoDetalleService.indexTab == 0
                        ? AppColors.primary950
                        : Colors.grey.shade800,
                height: 45,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Seguimientos",
                  style: TextStyle(
                    color: currentBrightness == Brightness.light
                        ? procesoDetalleService.indexTab == 0
                            ? Colors.white
                            : AppColors.secondary900
                        : procesoDetalleService.indexTab == 0
                            ? AppColors.primary100
                            : AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () {
                  procesoDetalleService.indexTab = 1;
                },
                color: currentBrightness == Brightness.light
                    ? procesoDetalleService.indexTab == 1
                        ? AppColors.secondary400
                        : AppColors.secondary100
                    : procesoDetalleService.indexTab == 1
                        ? AppColors.primary950
                        : Colors.grey.shade800,
                height: 45,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Datos económicos",
                  style: TextStyle(
                    color: currentBrightness == Brightness.light
                        ? procesoDetalleService.indexTab == 1
                            ? Colors.white
                            : AppColors.secondary900
                        : procesoDetalleService.indexTab == 1
                            ? AppColors.primary100
                            : AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                onPressed: () async {
                  procesoDetalleService.indexTab = 2;
                  // final calendarService = context.read<ProcesoCalendarService>();
                  // await calendarService.calendar(entidad, exp);
                  // calendarService.setFocusedDay(DateTime.now());
                  // calendarService.setSelectedDay(DateTime.now());
                  // ignore: use_build_context_synchronously
                  // Navigator.pushNamed(context, Routes.calendar);
                },
                color: currentBrightness == Brightness.light
                    ? procesoDetalleService.indexTab == 2
                        ? AppColors.secondary400
                        : AppColors.secondary100
                    : procesoDetalleService.indexTab == 2
                        ? AppColors.primary950
                        : Colors.grey.shade800,
                height: 45,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Calendario",
                  style: TextStyle(
                    color: currentBrightness == Brightness.light
                        ? procesoDetalleService.indexTab == 2
                            ? Colors.white
                            : AppColors.secondary900
                        : procesoDetalleService.indexTab == 2
                            ? AppColors.primary100
                            : AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
