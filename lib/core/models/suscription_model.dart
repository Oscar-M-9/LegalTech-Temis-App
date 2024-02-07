// To parse this JSON data, do
//
//     final suscription = suscriptionFromJson(jsonString);

import 'dart:convert';

Suscription suscriptionFromJson(String str) =>
    Suscription.fromJson(json.decode(str));

String suscriptionToJson(Suscription data) => json.encode(data.toJson());

class Suscription {
  final int? id;
  final int? price;
  final String? typeSuscripcion;
  final int? diasSuscripcion;
  final String? acceptTermsAndConditions;
  final DateTime? currentPeriodStart;
  final DateTime? currentPeriodEnd;
  final dynamic cancelAtPeriodEnd;
  final dynamic cancelAt;
  final dynamic endedAt;
  final int? limitCredit;
  final dynamic limitUsers;
  final dynamic limitWorkflows;
  final String? accessJudicial;
  final String? accessIndecopi;
  final String? accessSuprema;
  final String? accessSinoe;
  final String? accessLegaltech;
  final dynamic limitJudicial;
  final dynamic limitIndecopi;
  final dynamic limitSuprema;
  final dynamic limitSinoe;
  final dynamic limitCredencialSinoe;
  final dynamic metadata;
  final dynamic createdAt;
  final DateTime? updatedAt;

  Suscription({
    this.id,
    this.price,
    this.typeSuscripcion,
    this.diasSuscripcion,
    this.acceptTermsAndConditions,
    this.currentPeriodStart,
    this.currentPeriodEnd,
    this.cancelAtPeriodEnd,
    this.cancelAt,
    this.endedAt,
    this.limitCredit,
    this.limitUsers,
    this.limitWorkflows,
    this.accessJudicial,
    this.accessIndecopi,
    this.accessSuprema,
    this.accessSinoe,
    this.accessLegaltech,
    this.limitJudicial,
    this.limitIndecopi,
    this.limitSuprema,
    this.limitSinoe,
    this.limitCredencialSinoe,
    this.metadata,
    this.createdAt,
    this.updatedAt,
  });

  Suscription copyWith({
    int? id,
    int? price,
    String? typeSuscripcion,
    int? diasSuscripcion,
    String? acceptTermsAndConditions,
    DateTime? currentPeriodStart,
    DateTime? currentPeriodEnd,
    dynamic cancelAtPeriodEnd,
    dynamic cancelAt,
    dynamic endedAt,
    int? limitCredit,
    dynamic limitUsers,
    dynamic limitWorkflows,
    String? accessJudicial,
    String? accessIndecopi,
    String? accessSuprema,
    String? accessSinoe,
    String? accessLegaltech,
    dynamic limitJudicial,
    dynamic limitIndecopi,
    dynamic limitSuprema,
    dynamic limitSinoe,
    dynamic limitCredencialSinoe,
    dynamic metadata,
    dynamic createdAt,
    DateTime? updatedAt,
  }) =>
      Suscription(
        id: id ?? this.id,
        price: price ?? this.price,
        typeSuscripcion: typeSuscripcion ?? this.typeSuscripcion,
        diasSuscripcion: diasSuscripcion ?? this.diasSuscripcion,
        acceptTermsAndConditions:
            acceptTermsAndConditions ?? this.acceptTermsAndConditions,
        currentPeriodStart: currentPeriodStart ?? this.currentPeriodStart,
        currentPeriodEnd: currentPeriodEnd ?? this.currentPeriodEnd,
        cancelAtPeriodEnd: cancelAtPeriodEnd ?? this.cancelAtPeriodEnd,
        cancelAt: cancelAt ?? this.cancelAt,
        endedAt: endedAt ?? this.endedAt,
        limitCredit: limitCredit ?? this.limitCredit,
        limitUsers: limitUsers ?? this.limitUsers,
        limitWorkflows: limitWorkflows ?? this.limitWorkflows,
        accessJudicial: accessJudicial ?? this.accessJudicial,
        accessIndecopi: accessIndecopi ?? this.accessIndecopi,
        accessSuprema: accessSuprema ?? this.accessSuprema,
        accessSinoe: accessSinoe ?? this.accessSinoe,
        accessLegaltech: accessLegaltech ?? this.accessLegaltech,
        limitJudicial: limitJudicial ?? this.limitJudicial,
        limitIndecopi: limitIndecopi ?? this.limitIndecopi,
        limitSuprema: limitSuprema ?? this.limitSuprema,
        limitSinoe: limitSinoe ?? this.limitSinoe,
        limitCredencialSinoe: limitCredencialSinoe ?? this.limitCredencialSinoe,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Suscription.fromJson(Map<String, dynamic> json) => Suscription(
        id: json["id"],
        price: json["price"],
        typeSuscripcion: json["type_suscripcion"],
        diasSuscripcion: json["dias_suscripcion"],
        acceptTermsAndConditions: json["accept_terms_and_conditions"],
        currentPeriodStart: json["current_period_start"] == null
            ? null
            : DateTime.parse(json["current_period_start"]),
        currentPeriodEnd: json["current_period_end"] == null
            ? null
            : DateTime.parse(json["current_period_end"]),
        cancelAtPeriodEnd: json["cancel_at_period_end"],
        cancelAt: json["cancel_at"],
        endedAt: json["ended_at"],
        limitCredit: json["limit_credit"],
        limitUsers: json["limit_users"],
        limitWorkflows: json["limit_workflows"],
        accessJudicial: json["access_judicial"],
        accessIndecopi: json["access_indecopi"],
        accessSuprema: json["access_suprema"],
        accessSinoe: json["access_sinoe"],
        accessLegaltech: json["access_legaltech"],
        limitJudicial: json["limit_judicial"],
        limitIndecopi: json["limit_indecopi"],
        limitSuprema: json["limit_suprema"],
        limitSinoe: json["limit_sinoe"],
        limitCredencialSinoe: json["limit_credencial_sinoe"],
        metadata: json["metadata"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "type_suscripcion": typeSuscripcion,
        "dias_suscripcion": diasSuscripcion,
        "accept_terms_and_conditions": acceptTermsAndConditions,
        "current_period_start":
            "${currentPeriodStart!.year.toString().padLeft(4, '0')}-${currentPeriodStart!.month.toString().padLeft(2, '0')}-${currentPeriodStart!.day.toString().padLeft(2, '0')}",
        "current_period_end":
            "${currentPeriodEnd!.year.toString().padLeft(4, '0')}-${currentPeriodEnd!.month.toString().padLeft(2, '0')}-${currentPeriodEnd!.day.toString().padLeft(2, '0')}",
        "cancel_at_period_end": cancelAtPeriodEnd,
        "cancel_at": cancelAt,
        "ended_at": endedAt,
        "limit_credit": limitCredit,
        "limit_users": limitUsers,
        "limit_workflows": limitWorkflows,
        "access_judicial": accessJudicial,
        "access_indecopi": accessIndecopi,
        "access_suprema": accessSuprema,
        "access_sinoe": accessSinoe,
        "access_legaltech": accessLegaltech,
        "limit_judicial": limitJudicial,
        "limit_indecopi": limitIndecopi,
        "limit_suprema": limitSuprema,
        "limit_sinoe": limitSinoe,
        "limit_credencial_sinoe": limitCredencialSinoe,
        "metadata": metadata,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
