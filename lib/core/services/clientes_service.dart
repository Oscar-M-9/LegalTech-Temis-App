import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:http/http.dart' as http;
import 'package:legaltech_temis/core/models/clientes_model.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';

class ClienteService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  List<Cliente> _clienteModel = [];
  List<Cliente> get clienteModel => _clienteModel;

  String _query = "";
  String get query => _query;
  set query(String val) {
    _query = val;
    notifyListeners();
  }

  bool _clientesLoaded = false;
  bool get clientesLoaded => _clientesLoaded;
  set clientesLoaded(bool clientesLoaded) {
    _clientesLoaded = clientesLoaded;
    notifyListeners();
  }

  void setClienteModel(List<Cliente> clientes) {
    _clienteModel = clientes;
    notifyListeners();
  }

  List<Cliente> getFilteredItems(String query) {
    return _clienteModel.where((item) {
      if (item.typeContact == "Empresa") {
        return item.nameCompany!.toLowerCase().contains(query.toLowerCase());
      } else {
        return item.name!.toLowerCase().contains(query.toLowerCase()) ||
            item.lastName!.toLowerCase().contains(query.toLowerCase());
      }
    }).toList();
  }

  // ? api/clientes - Mostrar clientes del usuario
  Future<Map<String, dynamic>> clientes() async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/clientes')
        : Uri.http(_baseUrl, '/api/clientes');

    try {
      // Obtiene el token almacenado
      final String? token = await storage.read(key: 'token');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      final Map<String, dynamic> decodeResponse = json.decode(response.body);
      clientesLoaded = true;
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": null,
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        final clientesJson = decodeResponse["clientes"];
        final List<Cliente> clientes = Cliente.fromJsonList(clientesJson);
        setClienteModel(clientes);
        // return decodeResponse;
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": decodeResponse["clientes"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      // print('Error en la solicitud: $e');
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": null,
      "statusCode": 404,
    };
  }

  Future<Map<String, dynamic>> refreshClientes() async {
    final data = await clientes();
    notifyListeners();
    return {
      "status": true,
      "message": data["message"],
      "data": data["clientes"],
      "statusCode": data["statusCode"],
    };
  }
}
