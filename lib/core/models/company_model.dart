// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'dart:convert';

Company companyFromJson(String str) => Company.fromJson(json.decode(str));

String companyToJson(Company data) => json.encode(data.toJson());

class Company {
  final int? id;
  final String name;
  final dynamic ruc;
  final dynamic email;
  final dynamic phone;
  final dynamic logo;
  final String? codeCompany;
  final String? idSuscripcion;
  final dynamic codeUser;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Company({
    this.id,
    this.name = "Home",
    this.ruc,
    this.email,
    this.phone,
    this.logo,
    this.codeCompany,
    this.idSuscripcion,
    this.codeUser,
    this.createdAt,
    this.updatedAt,
  });

  Company copyWith({
    int? id,
    String? name,
    dynamic ruc,
    dynamic email,
    dynamic phone,
    dynamic logo,
    String? codeCompany,
    String? idSuscripcion,
    dynamic codeUser,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Company(
        id: id ?? this.id,
        name: name ?? this.name,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        logo: logo ?? this.logo,
        codeCompany: codeCompany ?? this.codeCompany,
        idSuscripcion: idSuscripcion ?? this.idSuscripcion,
        codeUser: codeUser ?? this.codeUser,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"],
        codeCompany: json["code_company"],
        idSuscripcion: json["id_suscripcion"],
        codeUser: json["code_user"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ruc": ruc,
        "email": email,
        "phone": phone,
        "logo": logo,
        "code_company": codeCompany,
        "id_suscripcion": idSuscripcion,
        "code_user": codeUser,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
