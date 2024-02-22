import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:legaltech_temis/core/models/company_model.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:loading_indicator/loading_indicator.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:fluttertest/item.dart';

typedef FetchDataFunction = Future<List<dynamic>> Function(
    int currentPage, int pageSize);

class SeguimientoSupremaInfiniteScrollPagination extends StatefulWidget {
  final ScrollController scrollController;
  final FetchDataFunction fetchDataFunction;
  final int exp;
  const SeguimientoSupremaInfiniteScrollPagination({
    Key? key,
    required this.scrollController,
    required this.fetchDataFunction,
    required this.exp,
  }) : super(key: key);

  @override
  State<SeguimientoSupremaInfiniteScrollPagination> createState() =>
      _InfiniteScrollPaginationState();
}

class _InfiniteScrollPaginationState
    extends State<SeguimientoSupremaInfiniteScrollPagination> {
  final StreamController<List<dynamic>> _dataStreamController =
      StreamController<List<dynamic>>();
  Stream<List<dynamic>> get dataStream => _dataStreamController.stream;
  final List<dynamic> _currentItems = [];
  int _currentPage = 1;
  // final int _pageSize = widget.exp;
  late final ScrollController _scrollController;
  bool _isFetchingData = false;

  Future<void> _fetchPaginatedData() async {
    if (_isFetchingData) {
      // Avoid fetching new data while already fetching
      return;
    }
    try {
      _isFetchingData = true;
      if (mounted) {
        setState(() {});
      }

      final startTime = DateTime.now();

      final items = await widget.fetchDataFunction(
        _currentPage,
        widget.exp,
      );

      _currentItems.addAll(items);

      // Add the updated list to the stream without overwriting the previous data
      final endTime = DateTime.now();
      final timeDifference =
          endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch;

      if (timeDifference < 2000) {
        // Delay for 2 seconds if the time taken by the API request is less then 2 seconds
        await Future.delayed(const Duration(milliseconds: 2000));
      }

      // _dataStreamController.add(_currentItems);
      if (mounted) {
        _dataStreamController.add(_currentItems);
      }
      _currentPage++;
    } catch (e) {
      _dataStreamController.addError(e);
    } finally {
      // Set to false when data fetching is complete
      _isFetchingData = false;
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = widget.scrollController;
    _dataStreamController.stream;
    _fetchPaginatedData();
    _scrollController.addListener(() {
      _scrollController.addListener(() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll == maxScroll) {
          // When the last item is fully visible, load the next page.
          _fetchPaginatedData();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return StreamBuilder<List<dynamic>>(
      stream: dataStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator
          return const Center(
            child: SizedBox(
              height: 50,
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
          );
        } else if (snapshot.hasError) {
          // Handle errors
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
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Display a message when there is no data
          return const Center(child: Text('No data available.'));
        } else {
          // Display the paginated data
          final items = snapshot.data;
          return ListView(
            controller: _scrollController,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  // dynamic file = items[index]['file'];
                  if (items[index]["abog_virtual"] == "si") {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      width: double.infinity,
                      // height: 100,
                      decoration: BoxDecoration(
                        color: currentBrightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade900,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: AppColors.primary800.withOpacity(.1),
                        //     blurRadius: 10.0,
                        //     offset: const Offset(1, 1),
                        //   )
                        // ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                              left: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "CEJ SUPREMA",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: currentBrightness == Brightness.light
                                        ? AppColors.secondary100
                                        : AppColors.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      items[index]['n_seguimiento'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: currentBrightness ==
                                                Brightness.light
                                            ? AppColors.primary
                                            : AppColors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: currentBrightness == Brightness.light
                                ? Colors.grey.shade200
                                : AppColors.secondary.withOpacity(.3),
                          ),
                          _buildDataMovements(
                            "Fecha: ",
                            items[index]["fecha"],
                          ),
                          _buildDataMovements(
                            "Acto: ",
                            items[index]["acto"],
                          ),
                          _buildDataMovements(
                            "Resolución: ",
                            items[index]["resolucion"],
                          ),
                          _buildDataMovements(
                            "Fojas: ",
                            items[index]["fojas"],
                          ),
                          _buildDataMovements(
                            "Sumilla: ",
                            items[index]["obs_sumilla"],
                          ),
                          _buildDataMovements(
                            "Presentante: ",
                            items[index]["presentante"],
                          ),
                          _buildDataMovements(
                            "",
                            items[index]["desc_usuario"],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 10)
                          //       .copyWith(
                          //     bottom: 15,
                          //   ),
                          //   child: file.startsWith('../storage/')
                          //       ? Column(
                          //           children: [
                          //             InkWell(
                          //               onTap: () async {
                          //                 final jsonCompany = jsonDecode(
                          //                     Preferences.dataCompany);
                          //                 final Company company =
                          //                     Company.fromJson(jsonCompany);
                          //                 final isProduction =
                          //                     ConfigApp.isProduction;
                          //                 final Uri filePdf = isProduction
                          //                     ? Uri.https(
                          //                         "${company.name}.temisperu.com",
                          //                         file)
                          //                     : Uri.http(
                          //                         ConfigApp.apiBaseUrl, file);
                          //                 if (await canLaunchUrl(filePdf)) {
                          //                   await launchUrl(filePdf);
                          //                 } else {
                          //                   throw 'Could not launch $file';
                          //                 }
                          //               },
                          //               child: Row(
                          //                 children: [
                          //                   const Icon(
                          //                     Icons.attach_file,
                          //                     color: AppColors.primary500,
                          //                   ),
                          //                   const SizedBox(width: 5),
                          //                   AutoSizeText(
                          //                     file
                          //                         .split('/')
                          //                         .last
                          //                         .replaceAll('.pdf', ''),
                          //                     style: const TextStyle(
                          //                       color: AppColors.primary500,
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //             const SizedBox(height: 5),
                          //           ],
                          //         )
                          //       : Container(
                          //           // margin: EdgeInsets.all(10),
                          //           width: double.infinity,
                          //           decoration: BoxDecoration(
                          //             color: Colors.grey.shade100,
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(10),
                          //             child: AutoSizeText(
                          //               file,
                          //               style: TextStyle(
                          //                 color:
                          //                     AppColors.primary.withOpacity(.5),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          // ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ),
                      width: double.infinity,
                      // height: 100,
                      decoration: BoxDecoration(
                        color: currentBrightness == Brightness.light
                            ? Colors.white
                            : Colors.grey.shade900,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: AppColors.primary800.withOpacity(.12),
                        //     blurRadius: 12.0,
                        //     offset: const Offset(1, 1),
                        //   )
                        // ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                              left: 10,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${items[index]['name']}, ${items[index]['lastname']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: currentBrightness == Brightness.light
                                        ? AppColors.secondary100
                                        : AppColors.primary,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Text(
                                      items[index]['n_seguimiento'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: currentBrightness ==
                                                Brightness.light
                                            ? AppColors.primary
                                            : AppColors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: currentBrightness == Brightness.light
                                ? Colors.grey.shade200
                                : AppColors.secondary.withOpacity(.3),
                          ),
                          _buildDataMovements(
                            "Titulo: ",
                            items[index]["u_title"],
                          ),
                          _buildDataMovements(
                            "Descripción: ",
                            items[index]["u_descripcion"],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10)
                                .copyWith(
                              bottom: 15,
                            ),
                            child: items[index]['metadata'] != null &&
                                    items[index]['metadata']
                                        .startsWith('/storage/')
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final jsonCompany = jsonDecode(
                                              Preferences.dataCompany);
                                          final Company company =
                                              Company.fromJson(jsonCompany);
                                          final isProduction =
                                              ConfigApp.isProduction;
                                          final Uri filePdf = isProduction
                                              ? Uri.https(
                                                  "${company.name}.temisperu.com",
                                                  items[index]['metadata'])
                                              : Uri.http(ConfigApp.apiBaseUrl,
                                                  items[index]['metadata']);
                                          // if (await canLaunchUrl(filePdf)) {
                                          //   await launchUrl(filePdf);
                                          // } else {
                                          //   throw 'Could not launch ${items[index]['metadata']}';
                                          // }
                                          await Navigator.pushNamed(
                                            context,
                                            Routes.pdfView,
                                            arguments: {
                                              "url": filePdf.toString(),
                                              "name": items[index]['metadata']
                                                  .split('/')
                                                  .last
                                                  .replaceAll('.pdf', ''),
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.attach_file,
                                              color: AppColors.primary500,
                                            ),
                                            const SizedBox(width: 5),
                                            AutoSizeText(
                                              items[index]['metadata']
                                                  .split('/')
                                                  .last
                                                  .replaceAll('.pdf', ''),
                                              style: const TextStyle(
                                                color: AppColors.primary500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10)
                                .copyWith(
                              bottom: 15,
                            ),
                            child: items[index]['video'] != null &&
                                    items[index]['video']
                                        .startsWith('/storage/')
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final jsonCompany = jsonDecode(
                                              Preferences.dataCompany);
                                          final Company company =
                                              Company.fromJson(jsonCompany);
                                          final isProduction =
                                              ConfigApp.isProduction;
                                          final Uri filePdf = isProduction
                                              ? Uri.https(
                                                  "${company.name}.temisperu.com",
                                                  items[index]['video'])
                                              : Uri.http(ConfigApp.apiBaseUrl,
                                                  items[index]['video']);
                                          // if (await canLaunchUrl(filePdf)) {
                                          //   await launchUrl(filePdf);
                                          // } else {
                                          //   throw 'Could not launch ${items[index]['video']}';
                                          // }
                                          Navigator.pushNamed(
                                            context,
                                            Routes.videoView,
                                            arguments: {
                                              "url": filePdf.toString(),
                                              "name": items[index]['video']
                                                  .split('/')
                                                  .last
                                                  .replaceAll('.webm', ''),
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.video_file_outlined,
                                              color: currentBrightness ==
                                                      Brightness.light
                                                  ? AppColors.secondary800
                                                  : AppColors.secondary200,
                                            ),
                                            const SizedBox(width: 5),
                                            AutoSizeText(
                                              items[index]['video']
                                                  .split('/')
                                                  .last
                                                  .replaceAll('.webm', ''),
                                              style: TextStyle(
                                                color: currentBrightness ==
                                                        Brightness.light
                                                    ? AppColors.secondary800
                                                    : AppColors.secondary200,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    );
                  }
                },
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 1,
                // ),
              ),
              if (_isFetchingData)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
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
                ),
            ],
          );
        }
      },
    );
  }

  Widget _buildDataMovements(String label, dynamic data) {
    return data != null && data != ""
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AutoSizeText(
                    // wrapWords: true,
                    // overflow: TextOverflow.ellipsis,
                    data.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _dataStreamController.close();
    //we do not have control cover the _scrollController so it should not be disposed here
    // _scrollController.dispose();
    super.dispose();
  }
}
