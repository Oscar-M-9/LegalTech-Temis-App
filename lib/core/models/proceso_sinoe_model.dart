// To parse this JSON data, do
//
//     final procesosSinoe = procesosSinoeFromJson(jsonString);

import 'dart:convert';

ProcesosSinoe procesosSinoeFromJson(String str) =>
    ProcesosSinoe.fromJson(json.decode(str));

String procesosSinoeToJson(ProcesosSinoe data) => json.encode(data.toJson());

class ProcesosSinoe {
  final bool? status;
  final String? message;
  final List<ExpedienteSinoe>? expedientes;
  final int? totalExpedientes;
  final dynamic limitExpedientes;

  ProcesosSinoe({
    this.status,
    this.message,
    this.expedientes,
    this.totalExpedientes,
    this.limitExpedientes,
  });

  ProcesosSinoe copyWith({
    bool? status,
    String? message,
    List<ExpedienteSinoe>? expedientes,
    int? totalExpedientes,
    dynamic limitExpedientes,
  }) =>
      ProcesosSinoe(
        status: status ?? this.status,
        message: message ?? this.message,
        expedientes: expedientes ?? this.expedientes,
        totalExpedientes: totalExpedientes ?? this.totalExpedientes,
        limitExpedientes: limitExpedientes ?? this.limitExpedientes,
      );

  factory ProcesosSinoe.fromJson(Map<String, dynamic> json) => ProcesosSinoe(
        status: json["status"],
        message: json["message"],
        expedientes: json["expedientes"] == null
            ? []
            : List<ExpedienteSinoe>.from(
                json["expedientes"]!.map((x) => ExpedienteSinoe.fromJson(x))),
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

class ExpedienteSinoe {
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
  final DateTime? fecha;
  final dynamic uDate;

  ExpedienteSinoe({
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
    this.fecha,
    this.uDate,
  });

  ExpedienteSinoe copyWith({
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
    DateTime? fecha,
    dynamic uDate,
  }) =>
      ExpedienteSinoe(
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
        fecha: fecha ?? this.fecha,
        uDate: uDate ?? this.uDate,
      );

  factory ExpedienteSinoe.fromJson(Map<String, dynamic> json) =>
      ExpedienteSinoe(
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
        fecha: json["fecha"] == null ? null : DateTime.parse(json["fecha"]),
        uDate: json["u_date"],
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
        "fecha": fecha?.toIso8601String(),
        "u_date": uDate,
      };

  static List<ExpedienteSinoe> fromJsonList(List<dynamic> jsonList) {
    List<ExpedienteSinoe> expediente = [];
    for (var expedienteJson in jsonList) {
      expediente.add(ExpedienteSinoe.fromJson(expedienteJson));
    }
    return expediente;
  }
}
