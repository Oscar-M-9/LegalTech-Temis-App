import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:http/http.dart' as http;
import 'package:legaltech_temis/core/utils/network_util.dart';

class ProcesoDetalleService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  final List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> get data => _data;

  final List<Map<String, dynamic>> _dataEconomic = [];
  List<Map<String, dynamic>> get dataEconomic => _dataEconomic;

  final List<Map<String, dynamic>> _notify = [];
  List<Map<String, dynamic>> get notify => _notify;

  int _indexTab = 0;
  int get indexTab => _indexTab;
  set indexTab(int value) {
    _indexTab = value;
    notifyListeners();
  }

// ? Judicial
  Future<List<Map<String, dynamic>>> fetchDataJudicial(
      int currentPage, int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "Exp": exp.toString(),
      "page": currentPage.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/poder-judicial/seguimientos', params)
        : Uri.http(_baseUrl, '/api/poder-judicial/seguimientos', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null &&
          jsonResponse["movements"]["data"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["movements"]["data"].cast<Map<String, dynamic>>();
        data.clear();
        data.addAll(dataList);
      }
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

// ? Suprema
  Future<List<Map<String, dynamic>>> fetchDataSuprema(
      int currentPage, int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "Exp": exp.toString(),
      "page": currentPage.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(
            _baseUrl, '/api/corte-suprema/seguimientos-corte-suprema', params)
        : Uri.http(
            _baseUrl, '/api/corte-suprema/seguimientos-corte-suprema', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null &&
          jsonResponse["movements"]["data"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["movements"]["data"].cast<Map<String, dynamic>>();
        data.clear();
        data.addAll(dataList);
      }
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

// ? Indecopi
  Future<List<Map<String, dynamic>>> fetchDataIndecopi(
      int currentPage, int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "Exp": exp.toString(),
      "page": currentPage.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/indecopi/acciones-realizadas', params)
        : Uri.http(_baseUrl, '/api/indecopi/acciones-realizadas', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null &&
          jsonResponse["movements"]["data"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["movements"]["data"].cast<Map<String, dynamic>>();
        data.clear();
        data.addAll(dataList);
      }
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

// ? Sinoe
  Future<List<Map<String, dynamic>>> fetchDataSinoe(
      int currentPage, int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "Exp": exp.toString(),
      "page": currentPage.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/sinoe/seguimientos-sinoe', params)
        : Uri.http(_baseUrl, '/api/sinoe/seguimientos-sinoe', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null &&
          jsonResponse["movements"]["data"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["movements"]["data"].cast<Map<String, dynamic>>();
        data.clear();
        data.addAll(dataList);
      }

      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // * Data Economic

  // ? Judicial
  Future<List<Map<String, dynamic>>> fetchDataEconomicJudicial(int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "idExp": exp.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/poder-judicial/get-economic', params)
        : Uri.http(_baseUrl, '/api/poder-judicial/get-economic', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse["economic"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["economic"].cast<Map<String, dynamic>>();
        dataEconomic.clear();
        dataEconomic.addAll(dataList);
      }

      return dataEconomic;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // ? Suprema
  Future<List<Map<String, dynamic>>> fetchDataEconomicSuprema(int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "idExp": exp.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/corte-suprema/get-economic', params)
        : Uri.http(_baseUrl, '/api/corte-suprema/get-economic', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse["economic"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["economic"].cast<Map<String, dynamic>>();
        dataEconomic.clear();
        dataEconomic.addAll(dataList);
      }

      return dataEconomic;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // ? Indecopi
  Future<List<Map<String, dynamic>>> fetchDataEconomicIndecopi(int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "idExp": exp.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/indecopi/get-economic', params)
        : Uri.http(_baseUrl, '/api/indecopi/get-economic', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse["economic"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["economic"].cast<Map<String, dynamic>>();
        dataEconomic.clear();
        dataEconomic.addAll(dataList);
      }

      return dataEconomic;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // ? Sinoe
  Future<List<Map<String, dynamic>>> fetchDataEconomicSinoe(int exp) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return [];
    }
    final String? token = await storage.read(key: 'token');

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> params = {
      "idExp": exp.toString(),
    };

    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/sinoe/get-economic', params)
        : Uri.http(_baseUrl, '/api/sinoe/get-economic', params);

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse != null && jsonResponse["economic"] is List<dynamic>) {
        List<Map<String, dynamic>> dataList =
            jsonResponse["economic"].cast<Map<String, dynamic>>();
        dataEconomic.clear();
        dataEconomic.addAll(dataList);
      }

      return dataEconomic;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
