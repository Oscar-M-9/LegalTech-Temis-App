// To parse this JSON data, do
//
//     final clientes = clientesFromJson(jsonString);

import 'dart:convert';

Clientes clientesFromJson(String str) => Clientes.fromJson(json.decode(str));

String clientesToJson(Clientes data) => json.encode(data.toJson());

class Clientes {
  final bool? status;
  final String? message;
  final List<Cliente>? clientes;

  Clientes({
    this.status,
    this.message,
    this.clientes,
  });

  Clientes copyWith({
    bool? status,
    String? message,
    List<Cliente>? clientes,
  }) =>
      Clientes(
        status: status ?? this.status,
        message: message ?? this.message,
        clientes: clientes ?? this.clientes,
      );

  factory Clientes.fromJson(Map<String, dynamic> json) => Clientes(
        status: json["status"],
        message: json["message"],
        clientes: json["clientes"] == null
            ? []
            : List<Cliente>.from(
                json["clientes"]!.map((x) => Cliente.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "clientes": clientes == null
            ? []
            : List<dynamic>.from(clientes!.map((x) => x.toJson())),
      };
}

class Cliente {
  final int? id;
  final String? typeContact;
  final String? name;
  final String? lastName;
  final String? dni;
  final DateTime? birthdate;
  final String? company;
  final String? nameCompany;
  final String? ruc;
  final String? email;
  final String? phone;
  final String? address;
  final String? codeUser;
  final String? codeCompany;
  final dynamic createdAt;
  final dynamic updatedAt;

  Cliente({
    this.id,
    this.typeContact,
    this.name,
    this.lastName,
    this.dni,
    this.birthdate,
    this.company,
    this.nameCompany,
    this.ruc,
    this.email,
    this.phone,
    this.address,
    this.codeUser,
    this.codeCompany,
    this.createdAt,
    this.updatedAt,
  });

  Cliente copyWith({
    int? id,
    String? typeContact,
    String? name,
    String? lastName,
    String? dni,
    DateTime? birthdate,
    String? company,
    String? nameCompany,
    String? ruc,
    String? email,
    String? phone,
    String? address,
    String? codeUser,
    String? codeCompany,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      Cliente(
        id: id ?? this.id,
        typeContact: typeContact ?? this.typeContact,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        dni: dni ?? this.dni,
        birthdate: birthdate ?? this.birthdate,
        company: company ?? this.company,
        nameCompany: nameCompany ?? this.nameCompany,
        ruc: ruc ?? this.ruc,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        codeUser: codeUser ?? this.codeUser,
        codeCompany: codeCompany ?? this.codeCompany,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        typeContact: json["type_contact"],
        name: json["name"],
        lastName: json["last_name"],
        dni: json["dni"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        company: json["company"],
        nameCompany: json["name_company"],
        ruc: json["ruc"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        codeUser: json["code_user"],
        codeCompany: json["code_company"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_contact": typeContact,
        "name": name,
        "last_name": lastName,
        "dni": dni,
        "birthdate":
            "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
        "company": company,
        "name_company": nameCompany,
        "ruc": ruc,
        "email": email,
        "phone": phone,
        "address": address,
        "code_user": codeUser,
        "code_company": codeCompany,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  // Función para convertir una lista de clientes en JSON a una lista de objetos Cliente
  static List<Cliente> fromJsonList(List<dynamic> jsonList) {
    List<Cliente> clientes = [];
    for (var clienteJson in jsonList) {
      clientes.add(Cliente.fromJson(clienteJson));
    }
    return clientes;
  }
}
