import 'package:flutter/cupertino.dart';
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
              TabButtonWidget(
                text: "Seguimientos",
                index: 0,
                procesoDetalleService: procesoDetalleService,
                currentBrightness: currentBrightness,
                icon: CupertinoIcons.eye,
              ),
              const SizedBox(width: 10),
              TabButtonWidget(
                text: "Datos económicos",
                index: 1,
                procesoDetalleService: procesoDetalleService,
                currentBrightness: currentBrightness,
                icon: CupertinoIcons.money_dollar,
              ),
              const SizedBox(width: 10),
              TabButtonWidget(
                text: "Calendario",
                index: 2,
                procesoDetalleService: procesoDetalleService,
                currentBrightness: currentBrightness,
                icon: CupertinoIcons.calendar,
              ),
              const SizedBox(width: 10),
              TabButtonWidget(
                text: "Tareas",
                index: 3,
                procesoDetalleService: procesoDetalleService,
                currentBrightness: currentBrightness,
                icon: CupertinoIcons.check_mark_circled,
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

class TabButtonWidget extends StatelessWidget {
  final String text;
  final int index;
  final ProcesoDetalleService procesoDetalleService;
  final Brightness currentBrightness;
  final IconData? icon;

  const TabButtonWidget({
    super.key,
    required this.text,
    required this.index,
    required this.procesoDetalleService,
    required this.currentBrightness,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = procesoDetalleService.indexTab == index;
    // final color = isSelected
    //     ? currentBrightness == Brightness.light
    //         ? AppColors.secondary400
    //         : AppColors.primary950
    //     : currentBrightness == Brightness.light
    //         ? AppColors.secondary50
    //         : Colors.grey.shade800;
    final textColor = isSelected
        ? currentBrightness == Brightness.light
            ? Colors.white
            : AppColors.primary100
        : currentBrightness == Brightness.light
            ? AppColors.secondary900
            : AppColors.white;
    final borderColor = isSelected
        ? Colors.transparent
        : currentBrightness == Brightness.light
            ? Colors.grey.shade300
            : Colors.grey.shade800;

    final buttonColor = isSelected
        ? currentBrightness == Brightness.light
            ? AppColors.secondary400
            : AppColors.primary950
        : currentBrightness == Brightness.light
            ? AppColors.white
            : Colors.grey.shade900;

    return MaterialButton(
      onPressed: () {
        procesoDetalleService.indexTab = index;
      },
      color: buttonColor,
      height: 45,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isSelected ? 5 : 10),
        side: BorderSide(
          style: isSelected ? BorderStyle.none : BorderStyle.solid,
          width: 1.0,
          color: borderColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: textColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
