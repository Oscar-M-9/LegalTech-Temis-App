import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/calendar_service.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class AppBarActionsWidget extends StatelessWidget {
  const AppBarActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final calendarService = context.read<CalendarService>();
            await calendarService.calendar();
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, Routes.calendar);
          },
          icon: const Icon(
            CupertinoIcons.calendar,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.notificaciones);
          },
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: -12),
            showBadge: true,
            ignorePointer: false,
            // onTap: () {
            //   print("Notificaciones");
            //   Navigator.pushNamed(context, Routes.notificaciones);
            // },
            badgeContent: const Text(
              "1",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            badgeAnimation: const badges.BadgeAnimation.scale(),
            badgeStyle: badges.BadgeStyle(
              badgeColor: CupertinoColors.destructiveRed,
              padding: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
              elevation: 0,
            ),
            child: const Icon(CupertinoIcons.bell_solid),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
