// import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width > 400
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 10,
                ),
                child: TableCalendar<Evento>(
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
                  calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                      color: AppColors.secondary600,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primary300,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    selectedTextStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primary900,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    rangeStartTextStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    rangeStartDecoration: BoxDecoration(
                      color: AppColors.primary600,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    rangeEndTextStyle: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16.0,
                    ),
                    rangeEndDecoration: BoxDecoration(
                      color: AppColors.primary600,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    withinRangeTextStyle: TextStyle(),
                    withinRangeDecoration:
                        BoxDecoration(shape: BoxShape.rectangle),
                    outsideTextStyle: TextStyle(color: Color(0xFFAEAEAE)),
                    outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
                    disabledTextStyle: TextStyle(color: Color(0xFFBFBFBF)),
                    disabledDecoration:
                        BoxDecoration(shape: BoxShape.rectangle),
                    holidayTextStyle: TextStyle(color: Color(0xFF5C6BC0)),
                    holidayDecoration: BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(
                        color: Color(0xFF9FA8DA),
                        width: 1.4,
                      )),
                      shape: BoxShape.rectangle,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Color(0xFF5A5A5A),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    weekNumberTextStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFBFBFBF),
                    ),
                    defaultTextStyle: TextStyle(),
                    defaultDecoration: BoxDecoration(
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
            const SizedBox(
              height: 8.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width > 400
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width,
              child: ValueListenableBuilder<List<Evento>>(
                valueListenable: calendarService.selectedEvents,
                builder: (context, value, _) {
                  return value.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentBrightness == Brightness.light
                                ? Colors.grey[300]
                                : Colors.grey[800],
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
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
                                        color: currentBrightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.grey[700],
                                        // border: Border.all(
                                        //   color: (currentBrightness == Brightness.light
                                        //           ? Colors.grey[600]
                                        //           : Colors.grey[400]) ??
                                        //       AppColors.primary500,
                                        // ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 7,
                                            // height: 100,
                                            constraints: const BoxConstraints(
                                              minHeight: 100,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: AppColors.secondary600,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(3),
                                                bottomLeft: Radius.circular(3),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 5,
                                                top: 5,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    value[index].title ?? "",
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
                                                        color:
                                                            currentBrightness ==
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
                                                    value[index].description ??
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
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
