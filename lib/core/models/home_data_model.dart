// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  final bool? status;
  final String? message;
  final Data? data;

  HomeData({
    this.status,
    this.message,
    this.data,
  });

  HomeData copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      HomeData(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? diasFaltantes;
  final List<int>? listExpedientes;
  final List<int>? listExpedientesAbierto;
  final List<int>? listExpedientesCerrado;
  final List<int>? listExpedientesPendiente;
  final List<int>? listSumaGastosMountSol;
  final List<int>? listSumaComisionesMountSol;
  final List<int>? listSumaRecaudacionMountSol;
  final List<int>? listSumaGastosMountDolar;
  final List<int>? listSumaComisionesMountDolar;
  final List<int>? listSumaRecaudacionMountDolar;

  Data({
    this.diasFaltantes,
    this.listExpedientes,
    this.listExpedientesAbierto,
    this.listExpedientesCerrado,
    this.listExpedientesPendiente,
    this.listSumaGastosMountSol,
    this.listSumaComisionesMountSol,
    this.listSumaRecaudacionMountSol,
    this.listSumaGastosMountDolar,
    this.listSumaComisionesMountDolar,
    this.listSumaRecaudacionMountDolar,
  });

  Data copyWith({
    int? diasFaltantes,
    List<int>? listExpedientes,
    List<int>? listExpedientesAbierto,
    List<int>? listExpedientesCerrado,
    List<int>? listExpedientesPendiente,
    List<int>? listSumaGastosMountSol,
    List<int>? listSumaComisionesMountSol,
    List<int>? listSumaRecaudacionMountSol,
    List<int>? listSumaGastosMountDolar,
    List<int>? listSumaComisionesMountDolar,
    List<int>? listSumaRecaudacionMountDolar,
  }) =>
      Data(
        diasFaltantes: diasFaltantes ?? this.diasFaltantes,
        listExpedientes: listExpedientes ?? this.listExpedientes,
        listExpedientesAbierto:
            listExpedientesAbierto ?? this.listExpedientesAbierto,
        listExpedientesCerrado:
            listExpedientesCerrado ?? this.listExpedientesCerrado,
        listExpedientesPendiente:
            listExpedientesPendiente ?? this.listExpedientesPendiente,
        listSumaGastosMountSol:
            listSumaGastosMountSol ?? this.listSumaGastosMountSol,
        listSumaComisionesMountSol:
            listSumaComisionesMountSol ?? this.listSumaComisionesMountSol,
        listSumaRecaudacionMountSol:
            listSumaRecaudacionMountSol ?? this.listSumaRecaudacionMountSol,
        listSumaGastosMountDolar:
            listSumaGastosMountDolar ?? this.listSumaGastosMountDolar,
        listSumaComisionesMountDolar:
            listSumaComisionesMountDolar ?? this.listSumaComisionesMountDolar,
        listSumaRecaudacionMountDolar:
            listSumaRecaudacionMountDolar ?? this.listSumaRecaudacionMountDolar,
      );
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        diasFaltantes: json["diasFaltantes"],
        listExpedientes: List<int>.from(json["listExpedientes"] ?? []),
        listExpedientesAbierto:
            List<int>.from(json["listExpedientesAbierto"] ?? []),
        listExpedientesCerrado:
            List<int>.from(json["listExpedientesCerrado"] ?? []),
        listExpedientesPendiente:
            List<int>.from(json["listExpedientesPendiente"] ?? []),
        listSumaGastosMountSol:
            List<int>.from(json["listSumaGastosMountSol"] ?? []),
        listSumaComisionesMountSol:
            List<int>.from(json["listSumaComisionesMountSol"] ?? []),
        listSumaRecaudacionMountSol:
            List<int>.from(json["listSumaRecaudacionMountSol"] ?? []),
        listSumaGastosMountDolar:
            List<int>.from(json["listSumaGastosMountDolar"] ?? []),
        listSumaComisionesMountDolar:
            List<int>.from(json["listSumaComisionesMountDolar"] ?? []),
        listSumaRecaudacionMountDolar:
            List<int>.from(json["listSumaRecaudacionMountDolar"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "diasFaltantes": diasFaltantes,
        "listExpedientes": listExpedientes,
        "listExpedientesAbierto": listExpedientesAbierto,
        "listExpedientesCerrado": listExpedientesCerrado,
        "listExpedientesPendiente": listExpedientesPendiente,
        "listSumaGastosMountSol": listSumaGastosMountSol,
        "listSumaComisionesMountSol": listSumaComisionesMountSol,
        "listSumaRecaudacionMountSol": listSumaRecaudacionMountSol,
        "listSumaGastosMountDolar": listSumaGastosMountDolar,
        "listSumaComisionesMountDolar": listSumaComisionesMountDolar,
        "listSumaRecaudacionMountDolar": listSumaRecaudacionMountDolar,
      };
}
