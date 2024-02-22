import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:legaltech_temis/core/models/calendar_model.dart';
import 'package:legaltech_temis/core/models/evento_model.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/core/utils/calendar_util.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';

class ProcesoCalendarService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  CalendarAll? _calendarAll = CalendarAll();

  CalendarAll? get calendarAll => _calendarAll;

  // set calendarAll(CalendarAll all){
  //   _calendarAll = all;
  //   notifyListeners();
  // }

  void setCalendarAll(CalendarAll calendarAll) {
    _calendarAll = calendarAll;
    notifyListeners();
  }

// ? Obtener el calendario por entidad /api/calendar-proceso/{entidad}/{id}
  Future<Map<String, dynamic>> calendar(String entidad, int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/calendar-proceso/$entidad/$exp')
        : Uri.http(_baseUrl, '/api/calendar-proceso/$entidad/$exp');

    try {
      // Obtiene el token almacenado
      final String? token = await storage.read(key: 'token');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": null,
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        // Supongamos que tu clase CalendarAll tiene un constructor fromJson
        CalendarAll calendarAll = CalendarAll.fromJson(decodeResponse);
        setCalendarAll(calendarAll);

        return decodeResponse;
        // return {
        //   "status": true,
        //   "message": decodeResponse["message"],
        //   "data": decodeResponse["data"],
        //   "statusCode": response.statusCode,
        // };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": null,
      "statusCode": 404,
    };
  }

  //
  //
  //
  //
  //

  // late final ValueNotifier<List<Evento>> _selectedEvents =
  //     ValueNotifier<List<Evento>>(getEventsForDay(DateTime.now()));
  ValueNotifier<List<Evento>> _selectedEvents = ValueNotifier<List<Evento>>([]);
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime firstDay = DateTime.utc(2022, 10, 16);
  DateTime lastDay = DateTime.utc(2040, 10, 16);

  DateTime? get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;
  DateTime? get rangeStart => _rangeStart;
  DateTime? get rangeEnd => _rangeEnd;
  CalendarFormat get calendarFormat => _calendarFormat;
  RangeSelectionMode get rangeSelectionMode => _rangeSelectionMode;
  ValueNotifier<List<Evento>> get selectedEvents => _selectedEvents;

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    notifyListeners();
  }

  void setCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  void setSelectedEvents(ValueNotifier<List<Evento>> event) {
    _selectedEvents = event;
    notifyListeners();
  }

//
//

//
//
  // List<EventSuggestion> eventSuggestions = calendarAll?.eventSuggestion ;
  List<Evento> getEventsForDay(DateTime day) {
    // Implementation example
    final eventSuggestions = calendarAll?.eventSuggestion ?? [];
    final eventsExpedientes = calendarAll?.eventsExpedientes ?? [];
    final workFlowTaskExpedientes = calendarAll?.workFlowTaskExpedientes ?? [];
    final workFlowTaskSuprema = calendarAll?.workFlowTaskSuprema ?? [];
    final workFlowTaskIndecopi = calendarAll?.workFlowTaskIndecopi ?? [];
    final workFlowTaskSinoe = calendarAll?.workFlowTaskSinoe ?? [];

    final kEventSource = <DateTime, List<Evento>>{};

    void addEventToMap(DateTime date, Evento event) {
      kEventSource[date] = [...(kEventSource[date] ?? []), event];
    }

    // Agregar eventos de eventSuggestions al mapa
    for (var event in eventSuggestions) {
      final eventDate = DateTime.parse(event.fecha.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.titulo ?? "Sin evento",
          fecha: eventDate,
          description: event.descripcion,
          backgroundColor: AppColors.secondary600,
          borderColor: AppColors.secondary800,
          entidad: event.entidad,
        ),
      );
    }
    //
    for (var event in eventsExpedientes) {
      final eventDate = DateTime.parse(event.fecha.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.title ?? "Sin evento",
          fecha: event.fecha,
          description: event.description,
          backgroundColor: AppColors.secondary500,
          borderColor: AppColors.secondary700,
          entidad: event.entidad,
          estado: event.estado,
          prioridad: event.prioridad,
          typeContact: event.typeContact,
          name: event.name,
          lastName: event.lastName,
          nameCompany: event.nameCompany,
          nExpediente: event.nExpediente,
        ),
      );
    }
    //
    for (var event in workFlowTaskExpedientes) {
      final eventDate = DateTime.parse(event.fechaLimite.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.nombre ?? "Sin evento",
          fecha: event.fechaLimite,
          description: event.descripcion,
          backgroundColor: AppColors.secondary400,
          borderColor: AppColors.secondary600,
          entidad: "workflow-judicial",
          estado: event.estado,
          prioridad: event.prioridad,
          typeContact: event.typeContact,
          name: event.name,
          lastName: event.lastName,
          nameCompany: event.nameCompany,
          nExpediente: event.nExpediente,
        ),
      );
    }
    //
    for (var event in workFlowTaskSuprema) {
      final eventDate = DateTime.parse(event.fechaLimite.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.nombre ?? "Sin evento",
          fecha: event.fechaLimite,
          description: event.descripcion,
          backgroundColor: AppColors.secondary400,
          borderColor: AppColors.secondary600,
          entidad: "workflow-judicial",
          estado: event.estado,
          prioridad: event.prioridad,
          typeContact: event.typeContact,
          name: event.name,
          lastName: event.lastName,
          nameCompany: event.nameCompany,
          nExpediente: event.nExpediente,
        ),
      );
    }
    //
    for (var event in workFlowTaskIndecopi) {
      final eventDate = DateTime.parse(event.fechaLimite.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.nombre ?? "Sin evento",
          fecha: event.fechaLimite,
          description: event.descripcion,
          backgroundColor: AppColors.secondary400,
          borderColor: AppColors.secondary600,
          entidad: "workflow-judicial",
          estado: event.estado,
          prioridad: event.prioridad,
          typeContact: event.typeContact,
          name: event.name,
          lastName: event.lastName,
          nameCompany: event.nameCompany,
          nExpediente: event.nExpediente,
        ),
      );
    }
    //
    for (var event in workFlowTaskSinoe) {
      final eventDate = DateTime.parse(event.fechaLimite.toString());
      addEventToMap(
        eventDate,
        Evento(
          title: event.nombre ?? "Sin evento",
          fecha: event.fechaLimite,
          description: event.descripcion,
          backgroundColor: AppColors.secondary400,
          borderColor: AppColors.secondary600,
          entidad: "workflow-judicial",
          estado: event.estado,
          prioridad: event.prioridad,
          typeContact: event.typeContact,
          name: event.name,
          lastName: event.lastName,
          nameCompany: event.nameCompany,
          nExpediente: event.nExpediente,
        ),
      );
    }

    // final kEvents = LinkedHashMap<DateTime, List<Evento>>(
    //   equals: isSameDay,
    //   hashCode: getHashCode,
    // )..addAll(kEventSource);

    // Buscar eventos asociados a la fecha específica
    List<Evento> eventosParaFecha = [];
    kEventSource.forEach((fecha, eventos) {
      if (isSameDay(fecha, day)) {
        eventosParaFecha.addAll(eventos);
      }
    });

    return eventosParaFecha;
  }

  List<Evento> getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _rangeStart = null; // Important to clean those
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;

      _selectedEvents.value = getEventsForDay(selectedDay);
      notifyListeners();
    }
  }

  void onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    _selectedDay = null;
    _focusedDay = focusedDay;
    _rangeStart = start;
    _rangeEnd = end;
    _rangeSelectionMode = RangeSelectionMode.toggledOn;

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = getEventsForDay(end);
    }
    notifyListeners();
  }
}

final calendarService = ProcesoCalendarService();
