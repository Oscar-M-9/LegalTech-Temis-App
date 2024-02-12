// To parse this JSON data, do
//
//     final procesosIndecopi = procesosIndecopiFromJson(jsonString);

import 'dart:convert';

ProcesosIndecopi procesosIndecopiFromJson(String str) =>
    ProcesosIndecopi.fromJson(json.decode(str));

String procesosIndecopiToJson(ProcesosIndecopi data) =>
    json.encode(data.toJson());

class ProcesosIndecopi {
  final bool? status;
  final String? message;
  final List<ExpedienteIndecopi>? expedientes;
  final int? totalExpedientes;
  final dynamic limitExpedientes;

  ProcesosIndecopi({
    this.status,
    this.message,
    this.expedientes,
    this.totalExpedientes,
    this.limitExpedientes,
  });

  ProcesosIndecopi copyWith({
    bool? status,
    String? message,
    List<ExpedienteIndecopi>? expedientes,
    int? totalExpedientes,
    dynamic limitExpedientes,
  }) =>
      ProcesosIndecopi(
        status: status ?? this.status,
        message: message ?? this.message,
        expedientes: expedientes ?? this.expedientes,
        totalExpedientes: totalExpedientes ?? this.totalExpedientes,
        limitExpedientes: limitExpedientes ?? this.limitExpedientes,
      );

  factory ProcesosIndecopi.fromJson(Map<String, dynamic> json) =>
      ProcesosIndecopi(
        status: json["status"],
        message: json["message"],
        expedientes: json["expedientes"] == null
            ? []
            : List<ExpedienteIndecopi>.from(json["expedientes"]!
                .map((x) => ExpedienteIndecopi.fromJson(x))),
        totalExpedientes: json["totalExpedientes"],
        limitExpedientes: json["limitExpedientes"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "expedientes": expedientes == null
            ? []
            : List<dynamic>.from(expedientes!.map((x) => x.toJson())),
        "totalExpedientes": totalExpedientes,
        "limitExpedientes": limitExpedientes,
      };
}

class ExpedienteIndecopi {
  final int? id;
  final String? tipo;
  final String? numero;
  final String? oficina;
  final String? responsable;
  final String? viaPresentacion;
  final String? fechaInicio;
  final String? estado;
  final DateTime? fecha;
  final dynamic formaConclusion;
  final String? partesProcesales1;
  final String? partesProcesales2;
  final dynamic accionesRealizadas;
  final String? entidad;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? ruc;
  final String? email;
  final String? phone;

  ExpedienteIndecopi({
    this.id,
    this.tipo,
    this.numero,
    this.oficina,
    this.responsable,
    this.viaPresentacion,
    this.fechaInicio,
    this.estado,
    this.fecha,
    this.formaConclusion,
    this.partesProcesales1,
    this.partesProcesales2,
    this.accionesRealizadas,
    this.entidad,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.ruc,
    this.email,
    this.phone,
  });

  ExpedienteIndecopi copyWith({
    int? id,
    String? tipo,
    String? numero,
    String? oficina,
    String? responsable,
    String? viaPresentacion,
    String? fechaInicio,
    String? estado,
    DateTime? fecha,
    dynamic formaConclusion,
    String? partesProcesales1,
    String? partesProcesales2,
    dynamic accionesRealizadas,
    String? entidad,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? ruc,
    String? email,
    String? phone,
  }) =>
      ExpedienteIndecopi(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        numero: numero ?? this.numero,
        oficina: oficina ?? this.oficina,
        responsable: responsable ?? this.responsable,
        viaPresentacion: viaPresentacion ?? this.viaPresentacion,
        fechaInicio: fechaInicio ?? this.fechaInicio,
        estado: estado ?? this.estado,
        fecha: fecha ?? this.fecha,
        formaConclusion: formaConclusion ?? this.formaConclusion,
        partesProcesales1: partesProcesales1 ?? this.partesProcesales1,
        partesProcesales2: partesProcesales2 ?? this.partesProcesales2,
        accionesRealizadas: accionesRealizadas ?? this.accionesRealizadas,
        entidad: entidad ?? this.entidad,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  factory ExpedienteIndecopi.fromJson(Map<String, dynamic> json) =>
      ExpedienteIndecopi(
        id: json["id"],
        tipo: json["tipo"],
        numero: json["numero"],
        oficina: json["oficina"],
        responsable: json["responsable"],
        viaPresentacion: json["via_presentacion"],
        fechaInicio: json["fecha_inicio"],
        estado: json["estado"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        formaConclusion: json["forma_conclusion"],
        partesProcesales1: json["partes_procesales1"],
        partesProcesales2: json["partes_procesales2"],
        accionesRealizadas: json["acciones_realizadas"],
        entidad: json["entidad"],
        name: json["name"],
        lastName: json["last_name"],
        nameCompany: json["name_company"],
        typeContact: json["type_contact"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "numero": numero,
        "oficina": oficina,
        "responsable": responsable,
        "via_presentacion": viaPresentacion,
        "fecha_inicio": fechaInicio,
        "estado": estado,
        "fecha":
            "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "forma_conclusion": formaConclusion,
        "partes_procesales1": partesProcesales1,
        "partes_procesales2": partesProcesales2,
        "acciones_realizadas": accionesRealizadas,
        "entidad": entidad,
        "name": name,
        "last_name": lastName,
        "name_company": nameCompany,
        "type_contact": typeContact,
        "ruc": ruc,
        "email": email,
        "phone": phone,
      };

  static List<ExpedienteIndecopi> fromJsonList(List<dynamic> jsonList) {
    List<ExpedienteIndecopi> expediente = [];
    for (var expedienteJson in jsonList) {
      expediente.add(ExpedienteIndecopi.fromJson(expedienteJson));
    }
    return expediente;
  }
}
