// To parse this JSON data, do
//
//     final calendarAll = calendarAllFromJson(jsonString);

import 'dart:convert';

CalendarAll calendarAllFromJson(String str) =>
    CalendarAll.fromJson(json.decode(str));

String calendarAllToJson(CalendarAll data) => json.encode(data.toJson());

class CalendarAll {
  final bool? status;
  final String? message;
  final List<EventSuggestion>? eventSuggestion;
  final List<EventsExpediente>? eventsExpedientes;
  final List<WorkFlowTask>? workFlowTaskExpedientes;
  final List<WorkFlowTask>? workFlowTaskSuprema;
  final List<WorkFlowTask>? workFlowTaskIndecopi;
  final List<WorkFlowTask>? workFlowTaskSinoe;

  CalendarAll({
    this.status,
    this.message,
    this.eventSuggestion,
    this.eventsExpedientes,
    this.workFlowTaskExpedientes,
    this.workFlowTaskSuprema,
    this.workFlowTaskIndecopi,
    this.workFlowTaskSinoe,
  });

  CalendarAll copyWith({
    bool? status,
    String? message,
    List<EventSuggestion>? eventSuggestion,
    List<EventsExpediente>? eventsExpedientes,
    List<WorkFlowTask>? workFlowTaskExpedientes,
    List<WorkFlowTask>? workFlowTaskSuprema,
    List<WorkFlowTask>? workFlowTaskIndecopi,
    List<WorkFlowTask>? workFlowTaskSinoe,
  }) =>
      CalendarAll(
        status: status ?? this.status,
        message: message ?? this.message,
        eventSuggestion: eventSuggestion ?? this.eventSuggestion,
        eventsExpedientes: eventsExpedientes ?? this.eventsExpedientes,
        workFlowTaskExpedientes:
            workFlowTaskExpedientes ?? this.workFlowTaskExpedientes,
        workFlowTaskSuprema: workFlowTaskSuprema ?? this.workFlowTaskSuprema,
        workFlowTaskIndecopi: workFlowTaskIndecopi ?? this.workFlowTaskIndecopi,
        workFlowTaskSinoe: workFlowTaskSinoe ?? this.workFlowTaskSinoe,
      );

  factory CalendarAll.fromJson(Map<String, dynamic> json) => CalendarAll(
        status: json["status"],
        message: json["message"],
        eventSuggestion: json["eventSuggestion"] == null
            ? []
            : List<EventSuggestion>.from(json["eventSuggestion"]!
                .map((x) => EventSuggestion.fromJson(x))),
        eventsExpedientes: json["eventsExpedientes"] == null
            ? []
            : List<EventsExpediente>.from(json["eventsExpedientes"]!
                .map((x) => EventsExpediente.fromJson(x))),
        workFlowTaskExpedientes: json["workFlowTaskExpedientes"] == null
            ? []
            : List<WorkFlowTask>.from(json["workFlowTaskExpedientes"]!
                .map((x) => WorkFlowTask.fromJson(x))),
        workFlowTaskSuprema: json["workFlowTaskSuprema"] == null
            ? []
            : List<WorkFlowTask>.from(json["workFlowTaskSuprema"]!
                .map((x) => WorkFlowTask.fromJson(x))),
        workFlowTaskIndecopi: json["workFlowTaskIndecopi"] == null
            ? []
            : List<WorkFlowTask>.from(json["workFlowTaskIndecopi"]!
                .map((x) => WorkFlowTask.fromJson(x))),
        workFlowTaskSinoe: json["workFlowTaskSinoe"] == null
            ? []
            : List<WorkFlowTask>.from(json["workFlowTaskSinoe"]!
                .map((x) => WorkFlowTask.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "eventSuggestion": eventSuggestion == null
            ? []
            : List<dynamic>.from(eventSuggestion!.map((x) => x.toJson())),
        "eventsExpedientes": eventsExpedientes == null
            ? []
            : List<dynamic>.from(eventsExpedientes!.map((x) => x.toJson())),
        "workFlowTaskExpedientes": workFlowTaskExpedientes == null
            ? []
            : List<dynamic>.from(
                workFlowTaskExpedientes!.map((x) => x.toJson())),
        "workFlowTaskSuprema": workFlowTaskSuprema == null
            ? []
            : List<dynamic>.from(workFlowTaskSuprema!.map((x) => x.toJson())),
        "workFlowTaskIndecopi": workFlowTaskIndecopi == null
            ? []
            : List<dynamic>.from(workFlowTaskIndecopi!.map((x) => x.toJson())),
        "workFlowTaskSinoe": workFlowTaskSinoe == null
            ? []
            : List<dynamic>.from(workFlowTaskSinoe!.map((x) => x.toJson())),
      };
}

class EventSuggestion {
  final DateTime? fecha;
  final String? titulo;
  final String? descripcion;
  final String? entidad;
  final DateTime? createdAt;

  EventSuggestion({
    this.fecha,
    this.titulo,
    this.descripcion,
    this.entidad,
    this.createdAt,
  });

  EventSuggestion copyWith({
    DateTime? fecha,
    String? titulo,
    String? descripcion,
    String? entidad,
    DateTime? createdAt,
  }) =>
      EventSuggestion(
        fecha: fecha ?? this.fecha,
        titulo: titulo ?? this.titulo,
        descripcion: descripcion ?? this.descripcion,
        entidad: entidad ?? this.entidad,
        createdAt: createdAt ?? this.createdAt,
      );

  factory EventSuggestion.fromJson(Map<String, dynamic> json) =>
      EventSuggestion(
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        titulo: json["titulo"],
        descripcion: json["descripcion"],
        entidad: json["entidad"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "fecha": fecha?.toIso8601String(),
        "titulo": titulo,
        "descripcion": descripcion,
        "entidad": entidad,
        "created_at": createdAt?.toIso8601String(),
      };
}

// enum Entidad { CALENDAR, CALENDARIO, JUDICIAL }

// final entidadValues = EnumValues({
//   "calendar": Entidad.CALENDAR,
//   "calendario": Entidad.CALENDARIO,
//   "judicial": Entidad.JUDICIAL
// });

class EventsExpediente {
  final String? title;
  final DateTime? start;
  final DateTime? fecha;
  final String? prioridad;
  final String? entidad;
  final String? estado;
  final String? description;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? nExpediente;
  final String? backgroundColor;
  final String? textColor;
  final String? borderColor;
  final bool? editable;

  EventsExpediente({
    this.title,
    this.start,
    this.fecha,
    this.prioridad,
    this.entidad,
    this.estado,
    this.description,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.nExpediente,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.editable,
  });

  EventsExpediente copyWith({
    String? title,
    DateTime? start,
    DateTime? fecha,
    String? prioridad,
    String? entidad,
    String? estado,
    String? description,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? nExpediente,
    String? backgroundColor,
    String? textColor,
    String? borderColor,
    bool? editable,
  }) =>
      EventsExpediente(
        title: title ?? this.title,
        start: start ?? this.start,
        fecha: fecha ?? this.fecha,
        prioridad: prioridad ?? this.prioridad,
        entidad: entidad ?? this.entidad,
        estado: estado ?? this.estado,
        description: description ?? this.description,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        nExpediente: nExpediente ?? this.nExpediente,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
        borderColor: borderColor ?? this.borderColor,
        editable: editable ?? this.editable,
      );

  factory EventsExpediente.fromJson(Map<String, dynamic> json) =>
      EventsExpediente(
        title: json["title"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        prioridad: json["prioridad"],
        entidad: json["entidad"],
        estado: json["estado"],
        description: json["description"],
        name: json["name"],
        lastName: json["lastName"],
        nameCompany: json["nameCompany"],
        typeContact: json["typeContact"],
        nExpediente: json["nExpediente"],
        backgroundColor: json["backgroundColor"],
        textColor: json["textColor"],
        borderColor: json["borderColor"],
        editable: json["editable"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start":
            "${start!.year.toString().padLeft(4, '0')}-${start!.month.toString().padLeft(2, '0')}-${start!.day.toString().padLeft(2, '0')}",
        "fecha":
            "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "prioridad": prioridad,
        "entidad": entidad,
        "estado": estado,
        "description": description,
        "name": name,
        "lastName": lastName,
        "nameCompany": nameCompany,
        "typeContact": typeContact,
        "nExpediente": nExpediente,
        "backgroundColor": backgroundColor,
        "textColor": textColor,
        "borderColor": borderColor,
        "editable": editable,
      };
}

class WorkFlowTask {
  final int? id;
  final int? idWorkflow;
  final int? idWorkflowStage;
  final int? idWorkflowTask;
  final int? idExp;
  final String? nombreEtapa;
  final String? nombreFlujo;
  final String? nombre;
  final String? descripcion;
  final int? diasDuracion;
  final int? diasAntesVenc;
  final DateTime? fechaLimite;
  final DateTime? fechaAlerta;
  final DateTime? fechaFinalizada;
  final dynamic attachedFiles;
  final String? estado;
  final String? prioridad;
  final String? codeUser;
  final String? codeCompany;
  final String? metadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nExpediente;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? numero;

  WorkFlowTask({
    this.id,
    this.idWorkflow,
    this.idWorkflowStage,
    this.idWorkflowTask,
    this.idExp,
    this.nombreEtapa,
    this.nombreFlujo,
    this.nombre,
    this.descripcion,
    this.diasDuracion,
    this.diasAntesVenc,
    this.fechaLimite,
    this.fechaAlerta,
    this.fechaFinalizada,
    this.attachedFiles,
    this.estado,
    this.prioridad,
    this.codeUser,
    this.codeCompany,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.nExpediente,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.numero,
  });

  WorkFlowTask copyWith({
    int? id,
    int? idWorkflow,
    int? idWorkflowStage,
    int? idWorkflowTask,
    int? idExp,
    String? nombreEtapa,
    String? nombreFlujo,
    String? nombre,
    String? descripcion,
    int? diasDuracion,
    int? diasAntesVenc,
    DateTime? fechaLimite,
    DateTime? fechaAlerta,
    DateTime? fechaFinalizada,
    dynamic attachedFiles,
    String? estado,
    String? prioridad,
    String? codeUser,
    String? codeCompany,
    String? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nExpediente,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? numero,
  }) =>
      WorkFlowTask(
        id: id ?? this.id,
        idWorkflow: idWorkflow ?? this.idWorkflow,
        idWorkflowStage: idWorkflowStage ?? this.idWorkflowStage,
        idWorkflowTask: idWorkflowTask ?? this.idWorkflowTask,
        idExp: idExp ?? this.idExp,
        nombreEtapa: nombreEtapa ?? this.nombreEtapa,
        nombreFlujo: nombreFlujo ?? this.nombreFlujo,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion ?? this.descripcion,
        diasDuracion: diasDuracion ?? this.diasDuracion,
        diasAntesVenc: diasAntesVenc ?? this.diasAntesVenc,
        fechaLimite: fechaLimite ?? this.fechaLimite,
        fechaAlerta: fechaAlerta ?? this.fechaAlerta,
        fechaFinalizada: fechaFinalizada ?? this.fechaFinalizada,
        attachedFiles: attachedFiles ?? this.attachedFiles,
        estado: estado ?? this.estado,
        prioridad: prioridad ?? this.prioridad,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nExpediente: nExpediente ?? this.nExpediente,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        numero: numero ?? this.numero,
      );

  factory WorkFlowTask.fromJson(Map<String, dynamic> json) => WorkFlowTask(
        id: json["id"],
        idWorkflow: json["id_workflow"],
        idWorkflowStage: json["id_workflow_stage"],
        idWorkflowTask: json["id_workflow_task"],
        idExp: json["id_exp"],
        nombreEtapa: json["nombre_etapa"],
        nombreFlujo: json["nombre_flujo"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        diasDuracion: json["dias_duracion"],
        diasAntesVenc: json["dias_antes_venc"],
        fechaLimite: json["fecha_limite"] == null
            ? null
            : DateTime.parse(json["fecha_limite"]),
        fechaAlerta: json["fecha_alerta"] == null
            ? null
            : DateTime.parse(json["fecha_alerta"]),
        fechaFinalizada: json["fecha_finalizada"] == null
            ? null
            : DateTime.parse(json["fecha_finalizada"]),
        attachedFiles: json["attached_files"],
        estado: json["estado"],
        prioridad: json["prioridad"],
        codeUser: json["code_user"],
        codeCompany: json["code_company"],
        metadata: json["metadata"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        nExpediente: json["n_expediente"],
        name: json["name"],
        lastName: json["last_name"],
        nameCompany: json["name_company"],
        typeContact: json["type_contact"],
        numero: json["numero"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_workflow": idWorkflow,
        "id_workflow_stage": idWorkflowStage,
        "id_workflow_task": idWorkflowTask,
        "id_exp": idExp,
        "nombre_etapa": nombreEtapa,
        "nombre_flujo": nombreFlujo,
        "nombre": nombre,
        "descripcion": descripcion,
        "dias_duracion": diasDuracion,
        "dias_antes_venc": diasAntesVenc,
        "fecha_limite":
            "${fechaLimite!.year.toString().padLeft(4, '0')}-${fechaLimite!.month.toString().padLeft(2, '0')}-${fechaLimite!.day.toString().padLeft(2, '0')}",
        "fecha_alerta":
            "${fechaAlerta!.year.toString().padLeft(4, '0')}-${fechaAlerta!.month.toString().padLeft(2, '0')}-${fechaAlerta!.day.toString().padLeft(2, '0')}",
        "fecha_finalizada": fechaFinalizada?.toIso8601String(),
        "attached_files": attachedFiles,
        "estado": estado,
        "prioridad": prioridad,
        "code_user": codeUser,
        "code_company": codeCompany,
        "metadata": metadata,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "n_expediente": nExpediente,
        "name": name,
        "last_name": lastName,
        "name_company": nameCompany,
        "type_contact": typeContact,
        "numero": numero,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
