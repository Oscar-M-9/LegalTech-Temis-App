import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:http/http.dart' as http;
import 'package:legaltech_temis/core/utils/network_util.dart';

class ProcesoTaskService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  // ? /api/poder-judicial/task?Exp= - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoTaskJudicial(int idExp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Map<String, String> params = {
      "Exp": idExp.toString(),
    };
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/poder-judicial/task', params)
        : Uri.http(_baseUrl, '/api/poder-judicial/task', params);

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
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": decodeResponse,
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "statusCode": 404,
    };
  }

  // ? /api/corte-suprema/task?Exp= - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoTaskSuprema(int idExp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Map<String, String> params = {
      "Exp": idExp.toString(),
    };
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/corte-suprema/task', params)
        : Uri.http(_baseUrl, '/api/corte-suprema/task', params);

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
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": decodeResponse,
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "statusCode": 404,
    };
  }

  // ? /api/indecopi/task?Exp= - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoTaskIndecopi(int idExp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Map<String, String> params = {
      "Exp": idExp.toString(),
    };
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/indecopi/task', params)
        : Uri.http(_baseUrl, '/api/indecopi/task', params);

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
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": decodeResponse,
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "statusCode": 404,
    };
  }

  // ? /api/sinoe/task?Exp= - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoTaskSinoe(int idExp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Map<String, String> params = {
      "Exp": idExp.toString(),
    };
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/sinoe/task', params)
        : Uri.http(_baseUrl, '/api/sinoe/task', params);

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
      if (response.statusCode == 401 || response.statusCode == 422) {
        return {
          "status": false,
          "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }

      if (response.statusCode == 200) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": decodeResponse,
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          // "message": decodeResponse["message"],
          "data": [],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "statusCode": 404,
    };
  }
}
