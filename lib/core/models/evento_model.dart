// To parse this JSON data, do
//
//     final evento = eventoFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<Evento> eventoFromJson(String str) =>
    List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

String eventoToJson(List<Evento> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Evento {
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
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool? editable;

  Evento({
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

  Evento copyWith({
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
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    bool? editable,
  }) =>
      Evento(
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

  factory Evento.fromJson(Map<String, dynamic> json) => Evento(
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
