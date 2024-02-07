// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String? name;
  final String? lastname;
  final String email;
  final String? rol;
  final String? typeUser;
  final String? codeUser;
  final String? codeCompany;
  final dynamic apiToken;
  final int? active;
  final String? estado;
  final dynamic lastPasswordChange;
  final dynamic phone;
  final dynamic createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.lastname,
    this.email = "email@temisperu.com",
    this.rol,
    this.typeUser,
    this.codeUser,
    this.codeCompany,
    this.apiToken,
    this.active,
    this.estado,
    this.lastPasswordChange,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? lastname,
    String? email,
    String? rol,
    String? typeUser,
    String? codeUser,
    String? codeCompany,
    dynamic apiToken,
    int? active,
    String? estado,
    dynamic lastPasswordChange,
    dynamic phone,
    dynamic createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        rol: rol ?? this.rol,
        typeUser: typeUser ?? this.typeUser,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        apiToken: apiToken ?? this.apiToken,
        active: active ?? this.active,
        estado: estado ?? this.estado,
        lastPasswordChange: lastPasswordChange ?? this.lastPasswordChange,
        phone: phone ?? this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        rol: json["rol"],
        typeUser: json["type_user"],
        codeUser: json["code_user"],
        codeCompany: json["code_company"],
        apiToken: json["api_token"],
        active: json["active"],
        estado: json["estado"],
        lastPasswordChange: json["last_password_change"],
        phone: json["phone"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "rol": rol,
        "type_user": typeUser,
        "code_user": codeUser,
        "code_company": codeCompany,
        "api_token": apiToken,
        "active": active,
        "estado": estado,
        "last_password_change": lastPasswordChange,
        "phone": phone,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
