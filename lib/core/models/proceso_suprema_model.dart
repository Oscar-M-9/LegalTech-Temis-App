// To parse this JSON data, do
//
//     final procesosSuprema = procesosSupremaFromJson(jsonString);

import 'dart:convert';

ProcesosSuprema procesosSupremaFromJson(String str) =>
    ProcesosSuprema.fromJson(json.decode(str));

String procesosSupremaToJson(ProcesosSuprema data) =>
    json.encode(data.toJson());

class ProcesosSuprema {
  final bool? status;
  final String? message;
  final List<ExpedienteSuprema>? expedientes;
  final int? totalExpedientes;
  final dynamic limitExpedientes;

  ProcesosSuprema({
    this.status,
    this.message,
    this.expedientes,
    this.totalExpedientes,
    this.limitExpedientes,
  });

  ProcesosSuprema copyWith({
    bool? status,
    String? message,
    List<ExpedienteSuprema>? expedientes,
    int? totalExpedientes,
    dynamic limitExpedientes,
  }) =>
      ProcesosSuprema(
        status: status ?? this.status,
        message: message ?? this.message,
        expedientes: expedientes ?? this.expedientes,
        totalExpedientes: totalExpedientes ?? this.totalExpedientes,
        limitExpedientes: limitExpedientes ?? this.limitExpedientes,
      );

  factory ProcesosSuprema.fromJson(Map<String, dynamic> json) =>
      ProcesosSuprema(
        status: json["status"],
        message: json["message"],
        expedientes: json["expedientes"] == null
            ? []
            : List<ExpedienteSuprema>.from(
                json["expedientes"]!.map((x) => ExpedienteSuprema.fromJson(x))),
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

class ExpedienteSuprema {
  final int? id;
  final String? nExpediente;
  final String? instancia;
  final String? recursoSala;
  final DateTime? fechaIngreso;
  final String? organoProcedencia;
  final String? relator;
  final String? distritoJudicial;
  final String? numeroProcedencia;
  final String? secretario;
  final String? delito;
  final String? ubicacion;
  final String? estado;
  final String? entidad;
  final String? urlSuprema;
  final String? partesProcesales;
  final DateTime? dateState;
  final String? state;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? ruc;
  final String? email;
  final String? phone;
  final DateTime? fecha;
  final dynamic uDate;

  ExpedienteSuprema({
    this.id,
    this.nExpediente,
    this.instancia,
    this.recursoSala,
    this.fechaIngreso,
    this.organoProcedencia,
    this.relator,
    this.distritoJudicial,
    this.numeroProcedencia,
    this.secretario,
    this.delito,
    this.ubicacion,
    this.estado,
    this.entidad,
    this.urlSuprema,
    this.partesProcesales,
    this.dateState,
    this.state,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.ruc,
    this.email,
    this.phone,
    this.fecha,
    this.uDate,
  });

  ExpedienteSuprema copyWith({
    int? id,
    String? nExpediente,
    String? instancia,
    String? recursoSala,
    DateTime? fechaIngreso,
    String? organoProcedencia,
    String? relator,
    String? distritoJudicial,
    String? numeroProcedencia,
    String? secretario,
    String? delito,
    String? ubicacion,
    String? estado,
    String? entidad,
    String? urlSuprema,
    String? partesProcesales,
    DateTime? dateState,
    String? state,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? ruc,
    String? email,
    String? phone,
    DateTime? fecha,
    dynamic uDate,
  }) =>
      ExpedienteSuprema(
        id: id ?? this.id,
        nExpediente: nExpediente ?? this.nExpediente,
        instancia: instancia ?? this.instancia,
        recursoSala: recursoSala ?? this.recursoSala,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        organoProcedencia: organoProcedencia ?? this.organoProcedencia,
        relator: relator ?? this.relator,
        distritoJudicial: distritoJudicial ?? this.distritoJudicial,
        numeroProcedencia: numeroProcedencia ?? this.numeroProcedencia,
        secretario: secretario ?? this.secretario,
        delito: delito ?? this.delito,
        ubicacion: ubicacion ?? this.ubicacion,
        estado: estado ?? this.estado,
        entidad: entidad ?? this.entidad,
        urlSuprema: urlSuprema ?? this.urlSuprema,
        partesProcesales: partesProcesales ?? this.partesProcesales,
        dateState: dateState ?? this.dateState,
        state: state ?? this.state,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fecha: fecha ?? this.fecha,
        uDate: uDate ?? this.uDate,
      );

  factory ExpedienteSuprema.fromJson(Map<String, dynamic> json) =>
      ExpedienteSuprema(
        id: json["id"],
        nExpediente: json["n_expediente"],
        instancia: json["instancia"],
        recursoSala: json["recurso_sala"],
        fechaIngreso: json["fecha_ingreso"] == null
            ? null
            : DateTime.parse(json["fecha_ingreso"]),
        organoProcedencia: json["organo_procedencia"],
        relator: json["relator"],
        distritoJudicial: json["distrito_judicial"],
        numeroProcedencia: json["numero_procedencia"],
        secretario: json["secretario"],
        delito: json["delito"],
        ubicacion: json["ubicacion"],
        estado: json["estado"],
        entidad: json["entidad"],
        urlSuprema: json["url_suprema"],
        partesProcesales: json["partes_procesales"],
        dateState: json["date_state"] == null
            ? null
            : DateTime.parse(json["date_state"]),
        state: json["state"],
        name: json["name"],
        lastName: json["last_name"],
        nameCompany: json["name_company"],
        typeContact: json["type_contact"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        uDate: json["u_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "n_expediente": nExpediente,
        "instancia": instancia,
        "recurso_sala": recursoSala,
        "fecha_ingreso": fechaIngreso?.toIso8601String(),
        "organo_procedencia": organoProcedencia,
        "relator": relator,
        "distrito_judicial": distritoJudicial,
        "numero_procedencia": numeroProcedencia,
        "secretario": secretario,
        "delito": delito,
        "ubicacion": ubicacion,
        "estado": estado,
        "entidad": entidad,
        "url_suprema": urlSuprema,
        "partes_procesales": partesProcesales,
        "date_state":
            "${dateState!.year.toString().padLeft(4, '0')}-${dateState!.month.toString().padLeft(2, '0')}-${dateState!.day.toString().padLeft(2, '0')}",
        "state": state,
        "name": name,
        "last_name": lastName,
        "name_company": nameCompany,
        "type_contact": typeContact,
        "ruc": ruc,
        "email": email,
        "phone": phone,
        "fecha":
            "${fecha!.year.toString().padLeft(4, '0')}-${fecha!.month.toString().padLeft(2, '0')}-${fecha!.day.toString().padLeft(2, '0')}",
        "u_date": uDate,
      };

  static List<ExpedienteSuprema> fromJsonList(List<dynamic> jsonList) {
    List<ExpedienteSuprema> expediente = [];
    for (var expedienteJson in jsonList) {
      expediente.add(ExpedienteSuprema.fromJson(expedienteJson));
    }
    return expediente;
  }
}
