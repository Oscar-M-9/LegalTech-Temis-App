// To parse this JSON data, do
//
//     final procesos = procesosFromJson(jsonString);

import 'dart:convert';

Procesos procesosFromJson(String str) => Procesos.fromJson(json.decode(str));

String procesosToJson(Procesos data) => json.encode(data.toJson());

class Procesos {
  final bool? status;
  final String? message;
  final List<Expediente>? expedientes;
  final int? totalExpedientes;
  final dynamic limitExpedientes;

  Procesos({
    this.status,
    this.message,
    this.expedientes,
    this.totalExpedientes,
    this.limitExpedientes,
  });

  Procesos copyWith({
    bool? status,
    String? message,
    List<Expediente>? expedientes,
    int? totalExpedientes,
    dynamic limitExpedientes,
  }) =>
      Procesos(
        status: status ?? this.status,
        message: message ?? this.message,
        expedientes: expedientes ?? this.expedientes,
        totalExpedientes: totalExpedientes ?? this.totalExpedientes,
        limitExpedientes: limitExpedientes ?? this.limitExpedientes,
      );

  factory Procesos.fromJson(Map<String, dynamic> json) => Procesos(
        status: json["status"],
        message: json["message"],
        expedientes: json["expedientes"] == null
            ? []
            : List<Expediente>.from(
                json["expedientes"]!.map((x) => Expediente.fromJson(x))),
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

class Expediente {
  final int? id;
  final String? nExpediente;
  final String? materia;
  final String? proceso;
  final String? lawyerResponsible;
  final String? estado;
  final String? sumilla;
  final DateTime? dateInitial;
  final dynamic updateDate;
  final dynamic name;
  final dynamic lastName;
  final String? nameCompany;
  final String? typeContact;
  final String? ruc;
  final String? email;
  final String? phone;
  final dynamic fechaIngreso;
  final dynamic fechaResolucion;
  final DateTime? uDate;

  Expediente({
    this.id,
    this.nExpediente,
    this.materia,
    this.proceso,
    this.lawyerResponsible,
    this.estado,
    this.sumilla,
    this.dateInitial,
    this.updateDate,
    this.name,
    this.lastName,
    this.nameCompany,
    this.typeContact,
    this.ruc,
    this.email,
    this.phone,
    this.fechaIngreso,
    this.fechaResolucion,
    this.uDate,
  });

  Expediente copyWith({
    int? id,
    String? nExpediente,
    String? materia,
    String? proceso,
    String? lawyerResponsible,
    String? estado,
    String? sumilla,
    DateTime? dateInitial,
    dynamic updateDate,
    dynamic name,
    dynamic lastName,
    String? nameCompany,
    String? typeContact,
    String? ruc,
    String? email,
    String? phone,
    dynamic fechaIngreso,
    dynamic fechaResolucion,
    DateTime? uDate,
  }) =>
      Expediente(
        id: id ?? this.id,
        nExpediente: nExpediente ?? this.nExpediente,
        materia: materia ?? this.materia,
        proceso: proceso ?? this.proceso,
        lawyerResponsible: lawyerResponsible ?? this.lawyerResponsible,
        estado: estado ?? this.estado,
        sumilla: sumilla ?? this.sumilla,
        dateInitial: dateInitial ?? this.dateInitial,
        updateDate: updateDate ?? this.updateDate,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        nameCompany: nameCompany ?? this.nameCompany,
        typeContact: typeContact ?? this.typeContact,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        fechaResolucion: fechaResolucion ?? this.fechaResolucion,
        uDate: uDate ?? this.uDate,
      );

  factory Expediente.fromJson(Map<String, dynamic> json) => Expediente(
        id: json["id"],
        nExpediente: json["n_expediente"],
        materia: json["materia"],
        proceso: json["proceso"],
        lawyerResponsible: json["lawyer_responsible"],
        estado: json["estado"],
        sumilla: json["sumilla"],
        dateInitial: json["date_initial"] == null
            ? null
            : DateTime.parse(json["date_initial"]),
        updateDate: json["update_date"],
        name: json["name"],
        lastName: json["last_name"],
        nameCompany: json["name_company"],
        typeContact: json["type_contact"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
        fechaIngreso: json["fecha_ingreso"],
        fechaResolucion: json["fecha_resolucion"],
        uDate: json["u_date"] == null ? null : DateTime.parse(json["u_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "n_expediente": nExpediente,
        "materia": materia,
        "proceso": proceso,
        "lawyer_responsible": lawyerResponsible,
        "estado": estado,
        "sumilla": sumilla,
        "date_initial":
            "${dateInitial!.year.toString().padLeft(4, '0')}-${dateInitial!.month.toString().padLeft(2, '0')}-${dateInitial!.day.toString().padLeft(2, '0')}",
        "update_date": updateDate,
        "name": name,
        "last_name": lastName,
        "name_company": nameCompany,
        "type_contact": typeContact,
        "ruc": ruc,
        "email": email,
        "phone": phone,
        "fecha_ingreso": fechaIngreso,
        "fecha_resolucion": fechaResolucion,
        "u_date":
            "${uDate!.year.toString().padLeft(4, '0')}-${uDate!.month.toString().padLeft(2, '0')}-${uDate!.day.toString().padLeft(2, '0')}",
      };

  static List<Expediente> fromJsonList(List<dynamic> jsonList) {
    List<Expediente> expediente = [];
    for (var expedienteJson in jsonList) {
      expediente.add(Expediente.fromJson(expedienteJson));
    }
    return expediente;
  }
}
