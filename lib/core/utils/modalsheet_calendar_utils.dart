// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

// //  late final ValueNotifier<List<Event>> _selectedEvents;
// CalendarFormat _calendarFormat = CalendarFormat.month;
// RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
//     .toggledOff; // Can be toggled on/off by longpressing a date
// DateTime _focusedDay = DateTime.now();
// DateTime? _selectedDay;
// DateTime? _rangeStart;
// DateTime? _rangeEnd;
// final pageIndexNotifier = ValueNotifier(0);
// SliverWoltModalSheetPage page1(
//     BuildContext modalSheetContext, TextTheme textTheme) {
//   return WoltModalSheetPage(
//     hasSabGradient: false,
//     stickyActionBar: Padding(
//       padding: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () => Navigator.of(modalSheetContext).pop(),
//             child: const SizedBox(
//               height: 20,
//               width: double.infinity,
//               child: Center(child: Text('Cancel')),
//             ),
//           ),
//           const SizedBox(height: 8),
//           ElevatedButton(
//             onPressed: () {
//               pageIndexNotifier.value = pageIndexNotifier.value + 1;
//             },
//             child: const SizedBox(
//               height: 20,
//               width: double.infinity,
//               child: Center(child: Text('Next page')),
//             ),
//           ),
//         ],
//       ),
//     ),
//     topBarTitle: Text('Calendario', style: textTheme.titleSmall),
//     isTopBarLayerAlwaysVisible: true,
//     trailingNavBarWidget: IconButton(
//       padding: const EdgeInsets.all(8),
//       icon: const Icon(Icons.close),
//       onPressed: Navigator.of(modalSheetContext).pop,
//     ),
//     child: Padding(
//       padding: const EdgeInsets.fromLTRB(
//         8,
//         8,
//         8,
//         120,
//       ),
//       child: TableCalendar(
//         firstDay: DateTime.utc(2022, 10, 16),
//         lastDay: DateTime.utc(2040, 3, 14),
//         focusedDay: _focusedDay,
//         selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//         rangeStartDay: _rangeStart,
//         rangeEndDay: _rangeEnd,
//         calendarFormat: _calendarFormat,
//         rangeSelectionMode: _rangeSelectionMode,
//         // eventLoader: _getEventsForDay,
//         startingDayOfWeek: StartingDayOfWeek.monday,
//         calendarStyle: CalendarStyle(
//           // Use `CalendarStyle` to customize the UI
//           outsideDaysVisible: false,
//         ),
//         onDaySelected: (selectedDay, focusedDay) {
//           _selectedDay = selectedDay;
//           _focusedDay = focusedDay; // update `_focusedDay` here as well
//           print("${_selectedDay} -- ${_focusedDay}");
//         },
//       ),
//     ),
//   );
// }

// SliverWoltModalSheetPage page2(
//     BuildContext modalSheetContext, TextTheme textTheme) {
//   return SliverWoltModalSheetPage(
//     pageTitle: Padding(
//       padding: const EdgeInsets.all(8),
//       child: Text(
//         'Material Colors',
//         style: textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
//       ),
//     ),
//     heroImage: const Image(
//       image: AssetImage(
//         'assets/images/sinoe-logo.png',
//       ),
//     ),
//     leadingNavBarWidget: IconButton(
//         padding: const EdgeInsets.all(8),
//         icon: const Icon(Icons.arrow_back_rounded),
//         onPressed: () {
//           pageIndexNotifier.value = pageIndexNotifier.value - 1;
//         }),
//     trailingNavBarWidget: IconButton(
//       padding: const EdgeInsets.all(8),
//       icon: const Icon(Icons.close),
//       onPressed: () {
//         Navigator.of(modalSheetContext).pop();
//         pageIndexNotifier.value = 0;
//       },
//     ),
//     mainContentSlivers: [
//       SliverGrid(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10.0,
//           crossAxisSpacing: 10.0,
//           childAspectRatio: 2.0,
//         ),
//         delegate: SliverChildBuilderDelegate(
//           (_, index) => Container(
//             color: Colors.red,
//             width: 200,
//             height: 200,
//           ),
//           childCount: 20,
//         ),
//       ),
//       SliverList(
//         delegate: SliverChildBuilderDelegate(
//           (_, index) => Container(
//             color: Colors.blue,
//             width: 200,
//             height: 200,
//           ),
//           childCount: 10,
//         ),
//       ),
//       SliverPadding(
//         padding: const EdgeInsets.all(8),
//         sliver: SliverToBoxAdapter(
//           child: TextButton(
//             onPressed: Navigator.of(modalSheetContext).pop,
//             child: const Text('Close'),
//           ),
//         ),
//       ),
//     ],
//   );
// }
