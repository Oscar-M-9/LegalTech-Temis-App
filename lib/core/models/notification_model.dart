// To parse this JSON data, do
//
//     final notificationAll = notificationAllFromJson(jsonString);

import 'dart:convert';

NotificationAll notificationAllFromJson(String str) =>
    NotificationAll.fromJson(json.decode(str));

String notificationAllToJson(NotificationAll data) =>
    json.encode(data.toJson());

class NotificationAll {
  final bool? status;
  final List<Datum>? data;

  NotificationAll({
    this.status,
    this.data,
  });

  NotificationAll copyWith({
    bool? status,
    List<Datum>? data,
  }) =>
      NotificationAll(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory NotificationAll.fromJson(Map<String, dynamic> json) =>
      NotificationAll(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final int? idHistory;
  final int? idExp;
  final int? idClient;
  final int? idMovimiento;
  final DateTime? dateTime;
  final String? estado;
  final String? entidad;
  final String? expNExp;
  final String? moviAccionRealizada;
  final String? moviAnotaciones;
  final String? clientTypeContact;
  final dynamic clientName;
  final dynamic clientLastName;
  final String? clientNameCompany;
  final String? url;

  Datum({
    this.idHistory,
    this.idExp,
    this.idClient,
    this.idMovimiento,
    this.dateTime,
    this.estado,
    this.entidad,
    this.expNExp,
    this.moviAccionRealizada,
    this.moviAnotaciones,
    this.clientTypeContact,
    this.clientName,
    this.clientLastName,
    this.clientNameCompany,
    this.url,
  });

  Datum copyWith({
    int? idHistory,
    int? idExp,
    int? idClient,
    int? idMovimiento,
    DateTime? dateTime,
    String? estado,
    String? entidad,
    String? expNExp,
    String? moviAccionRealizada,
    String? moviAnotaciones,
    String? clientTypeContact,
    dynamic clientName,
    dynamic clientLastName,
    String? clientNameCompany,
    String? url,
  }) =>
      Datum(
        idHistory: idHistory ?? this.idHistory,
        idExp: idExp ?? this.idExp,
        idClient: idClient ?? this.idClient,
        idMovimiento: idMovimiento ?? this.idMovimiento,
        dateTime: dateTime ?? this.dateTime,
        estado: estado ?? this.estado,
        entidad: entidad ?? this.entidad,
        expNExp: expNExp ?? this.expNExp,
        moviAccionRealizada: moviAccionRealizada ?? this.moviAccionRealizada,
        moviAnotaciones: moviAnotaciones ?? this.moviAnotaciones,
        clientTypeContact: clientTypeContact ?? this.clientTypeContact,
        clientName: clientName ?? this.clientName,
        clientLastName: clientLastName ?? this.clientLastName,
        clientNameCompany: clientNameCompany ?? this.clientNameCompany,
        url: url ?? this.url,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idHistory: json["id_history"],
        idExp: json["id_exp"],
        idClient: json["id_client"],
        idMovimiento: json["id_movimiento"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        estado: json["estado"],
        entidad: json["entidad"],
        expNExp: json["exp_n_exp"],
        moviAccionRealizada: json["movi_accion_realizada"],
        moviAnotaciones: json["movi_anotaciones"],
        clientTypeContact: json["client_type_contact"],
        clientName: json["client_name"],
        clientLastName: json["client_last_name"],
        clientNameCompany: json["client_name_company"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id_history": idHistory,
        "id_exp": idExp,
        "id_client": idClient,
        "id_movimiento": idMovimiento,
        "date_time": dateTime?.toIso8601String(),
        "estado": estado,
        "entidad": entidad,
        "exp_n_exp": expNExp,
        "movi_accion_realizada": moviAccionRealizada,
        "movi_anotaciones": moviAnotaciones,
        "client_type_contact": clientTypeContact,
        "client_name": clientName,
        "client_last_name": clientLastName,
        "client_name_company": clientNameCompany,
        "url": url,
      };
}
