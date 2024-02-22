import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';

class AuthService extends ChangeNotifier {
  /* https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[API_KEY] */
  // final String _firebaseKey = 'AIzaSyC_-VMAvrAujANe2s5iNT3T0_ROatDxtX4';
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  /* Registro de usuario */
  // Future<String?> crateUser(String email, String password) async {
  //   final Map<String, dynamic> authData = {
  //     'email': email,
  //     'password': password
  //   };
  //   final url =
  //       Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseKey});
  //   final response = await http.post(url, body: json.encode(authData));
  //   final Map<String, dynamic> decodeResponse = json.decode(response.body);

  //   if (decodeResponse.containsKey('idToken')) {
  //     storage.write(key: 'token', value: decodeResponse['idToken']);
  //     return null;
  //   } else {
  //     return decodeResponse['error']['message'];
  //   }
  // }

  /* login de usuario */
  Future<String?> login(String email, String password) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return "No hay conexión a Internet";
    }
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };
    final Uri url;
    if (_isProduction) {
      url = Uri.https(_baseUrl, '/api/auth/login');
    } else {
      url = Uri.http(_baseUrl, '/api/auth/login');
    }
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(authData),
      );

      final Map<String, dynamic> decodeResponse = json.decode(response.body);

      if (response.statusCode == 422) {
        return "Las credenciales ingresadas no coinciden con nuestros registros";
      }

      if (response.statusCode == 200) {
        if (decodeResponse.containsKey('token')) {
          storage.write(key: 'token', value: decodeResponse['token']);
          Preferences.user = jsonEncode(decodeResponse['user']);
          Preferences.dataCompany = jsonEncode(decodeResponse['dataCompany']);
          Preferences.dataSuscripcion =
              jsonEncode(decodeResponse['dataSuscripcion']);
          return null;
        }
      }

      return decodeResponse['message'];
    } catch (error) {
      // print('Error en la solicitud: $error');
      return "Ocurrió un error durante el inicio de sesión";
    }
  }

  /* cerrar sesion */
  Future<String?> logout() async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return "No hay conexión a Internet";
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/auth/logout')
        : Uri.http(_baseUrl, '/api/auth/logout');
    try {
      // Obtiene el token almacenado
      final String? token = await storage.read(key: 'token');

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodeResponse = json.decode(response.body);
        final String? message = decodeResponse["message"];

        // Elimina el token después de que la operación es exitosa
        await storage.delete(key: 'token');

        return message;
      } else if (response.statusCode == 401) {
        // Elimina el token después de que la operación es exitosa
        await storage.delete(key: 'token');
        return "La sesión se ha cerrado correctamente";
      } else {
        // Manejo de errores, puedes imprimir información detallada del error en consola
        // print('Error en la solicitud: ${response.statusCode}');
        // print('Cuerpo de la respuesta: ${response.body}');
        return null;
      }
    } catch (error) {
      // Manejo de errores de red u otros
      // print('Error en la solicitud: $error');
      return null;
    }
  }

  /* verificar existencia del token */
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
