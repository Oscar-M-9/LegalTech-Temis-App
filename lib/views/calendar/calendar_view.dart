// import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:legaltech_temis/core/models/evento_model.dart';
// import 'package:legaltech_temis/core/models/company_model.dart';
// import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/services/calendar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey containerKey = GlobalKey();
    final GlobalKey calendarKey = GlobalKey();
    final calendarService = context.watch<CalendarService>();
    Brightness currentBrightness = Theme.of(context).brightness;
    // final jsonCompany = jsonDecode(Preferences.dataCompany);
    // final Company company = Company.fromJson(jsonCompany);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calendario",
        ),
      ),
      body: Wrap(
        children: [
          SizedBox(
            key: containerKey,
            width: MediaQuery.of(context).orientation == Orientation.landscape
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
                bottom: 10,
                top: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: currentBrightness == Brightness.light
                      ? AppColors.white
                      : Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TableCalendar<Evento>(
                  key: calendarKey,
                  firstDay: calendarService.firstDay,
                  lastDay: calendarService.lastDay,
                  focusedDay: calendarService.focusedDay,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Mes',
                    CalendarFormat.twoWeeks: "2 Semanas",
                    CalendarFormat.week: "Semana",
                  },
                  selectedDayPredicate: (day) =>
                      isSameDay(calendarService.selectedDay, day),
                  rangeStartDay: calendarService.rangeStart,
                  rangeEndDay: calendarService.rangeEnd,
                  calendarFormat: calendarService.calendarFormat,
                  rangeSelectionMode: calendarService.rangeSelectionMode,
                  eventLoader: calendarService.getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: currentBrightness == Brightness.light
                          ? AppColors.secondary600
                          : AppColors.primary600,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    todayDecoration: BoxDecoration(
                      color: currentBrightness == Brightness.light
                          ? AppColors.secondary500
                          : AppColors.primary500,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: currentBrightness == Brightness.light
                          ? AppColors.secondary700
                          : AppColors.primary800,
                      shape: BoxShape.rectangle,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    rangeStartTextStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    rangeStartDecoration: const BoxDecoration(
                      color: AppColors.primary600,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    rangeEndTextStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    rangeEndDecoration: const BoxDecoration(
                      color: AppColors.primary600,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    withinRangeTextStyle: const TextStyle(),
                    withinRangeDecoration:
                        const BoxDecoration(shape: BoxShape.rectangle),
                    outsideTextStyle: const TextStyle(color: Color(0xFFAEAEAE)),
                    outsideDecoration:
                        const BoxDecoration(shape: BoxShape.rectangle),
                    disabledTextStyle:
                        const TextStyle(color: Color(0xFFBFBFBF)),
                    disabledDecoration:
                        const BoxDecoration(shape: BoxShape.rectangle),
                    holidayTextStyle: const TextStyle(color: Color(0xFF5C6BC0)),
                    holidayDecoration: const BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                        color: Color(0xFF9FA8DA),
                        width: 1.4,
                      )),
                      shape: BoxShape.rectangle,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Color(0xFF5A5A5A),
                    ),
                    weekendDecoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    weekNumberTextStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFBFBFBF),
                    ),
                    defaultTextStyle: const TextStyle(),
                    defaultDecoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: calendarService.onDaySelected,
                  onRangeSelected: calendarService.onRangeSelected,
                  onFormatChanged: (format) {
                    if (calendarService.calendarFormat != format) {
                      // setState(() {
                      calendarService.setCalendarFormat(format);
                      // });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    calendarService.setFocusedDay(focusedDay);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = MediaQuery.of(context).size.height;
              final renderBox =
                  containerKey.currentContext?.findRenderObject() as RenderBox;
              final remainingHeight = screenHeight -
                  renderBox.size.height -
                  8; // 8 es el espacio entre los widgets
              final remainingHeightContainer = renderBox.size.height > 300.0
                  ? remainingHeight * 0.72
                  : remainingHeight * 0.8;
              return SizedBox(
                width:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? MediaQuery.of(context).size.width * 0.5
                        : MediaQuery.of(context).size.width,
                child: ValueListenableBuilder<List<Evento>>(
                  valueListenable: calendarService.selectedEvents,
                  builder: (context, value, _) {
                    return value.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? MediaQuery.of(context).size.height * 0.74
                                : remainingHeightContainer,
                            margin: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentBrightness == Brightness.light
                                  ? Colors.grey.shade200
                                  : Colors.grey.shade900,
                            ),
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              // physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return value.isNotEmpty
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 4.0,
                                        ),
                                        decoration: BoxDecoration(
                                          // color: currentBrightness ==
                                          //         Brightness.light
                                          //     ? Colors.white
                                          //     : Colors.black26,
                                          color: currentBrightness ==
                                                  Brightness.light
                                              ? AppColors.secondary600
                                              : AppColors.primary600,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 7,
                                              // height: renderBox.size.height,
                                              // constraints: const BoxConstraints(
                                              //     minHeight: 100,
                                              //     ),
                                              decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5),
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: currentBrightness ==
                                                          Brightness.light
                                                      ? Colors.white
                                                      : Colors.black,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 5,
                                                    top: 5,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AutoSizeText(
                                                        value[index].title ??
                                                            "",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      AutoSizeText(
                                                        DateFormat.yMEd('es_ES')
                                                            .add_jms()
                                                            .format(value[index]
                                                                    .fecha ??
                                                                DateTime.now())
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: currentBrightness ==
                                                                    Brightness
                                                                        .light
                                                                ? Colors
                                                                    .grey[400]
                                                                : Colors
                                                                    .grey[300]),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      AutoSizeText(
                                                        value[index]
                                                                .description ??
                                                            "",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox();
                              },
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? MediaQuery.of(context).size.height * 0.58
                                : remainingHeightContainer,
                            margin: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "No se encontraron eventos",
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
