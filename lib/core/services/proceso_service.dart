import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:legaltech_temis/core/config/config_app.dart';
import 'package:http/http.dart' as http;
import 'package:legaltech_temis/core/models/combined_procesos_model.dart';
import 'package:legaltech_temis/core/models/proceso_indecopi_model.dart';
import 'package:legaltech_temis/core/models/proceso_judicial_model.dart';
import 'package:legaltech_temis/core/models/proceso_sinoe_model.dart';
import 'package:legaltech_temis/core/models/proceso_suprema_model.dart';
import 'package:legaltech_temis/core/utils/network_util.dart';

class ProcesoService extends ChangeNotifier {
  final String _baseUrl = ConfigApp.apiBaseUrl;
  final bool _isProduction = ConfigApp.isProduction;
  final storage = const FlutterSecureStorage();

  List<Expediente> _expedienteModel = [];
  List<Expediente> get expedienteModel => _expedienteModel;

  void setExpedienteModel(List<Expediente> expediente) {
    _expedienteModel = expediente;
    notifyListeners();
  }

  List<ExpedienteSuprema> _expedienteSupremaModel = [];
  List<ExpedienteSuprema> get expedienteSupremaModel => _expedienteSupremaModel;

  void setExpedienteSupremaModel(
      List<ExpedienteSuprema> expedienteSupremaModel) {
    _expedienteSupremaModel = expedienteSupremaModel;
    notifyListeners();
  }

  List<ExpedienteIndecopi> _expedienteIndecopiModel = [];
  List<ExpedienteIndecopi> get expedienteIndecopiModel =>
      _expedienteIndecopiModel;

  void setExpedienteIndecopiModel(
      List<ExpedienteIndecopi> expedienteIndecopiModel) {
    _expedienteIndecopiModel = expedienteIndecopiModel;
    notifyListeners();
  }

  List<ExpedienteSinoe> _expedienteSinoeModel = [];
  List<ExpedienteSinoe> get expedienteSinoeModel => _expedienteSinoeModel;

  void setExpedienteSinoeModel(List<ExpedienteSinoe> expedienteSinoeModel) {
    _expedienteSinoeModel = expedienteSinoeModel;
    notifyListeners();
  }

  late CombinedDataProcesos _combinedDataProcesos;
  CombinedDataProcesos get combinedDataProcesos => _combinedDataProcesos;

  String _query = "";
  String get query => _query;
  set query(String val) {
    _query = val;
    notifyListeners();
  }

  bool _procesoLoaded = false;
  bool get procesoLoaded => _procesoLoaded;
  set procesoLoaded(bool procesoLoaded) {
    _procesoLoaded = procesoLoaded;
    notifyListeners();
  }

  void setCombinedDataProcesos(CombinedDataProcesos combinedDataProcesos) {
    _combinedDataProcesos = combinedDataProcesos;
    notifyListeners();
  }

  //
  Future<CombinedDataProcesos> fetchCombinedData(int idClient) async {
    // Realizar las llamadas a las tres APIs de forma asíncrona
    final Future<Map<String, dynamic>> api1Result = procesoJudicial(idClient);
    final Future<Map<String, dynamic>> api2Result = procesoSuprema(idClient);
    final Future<Map<String, dynamic>> api3Result = procesoIndecopi(idClient);
    final Future<Map<String, dynamic>> api4Result = procesoSinoe(idClient);

    // Esperar a que todas las llamadas se completen usando Future.wait
    final List<dynamic> results = await Future.wait([
      api1Result,
      api2Result,
      api3Result,
      api4Result,
    ]);
    // procesoLoaded = true;

    // Obtener los resultados individuales de las API
    final expedienteJson = results[0]["data"];
    final List<Expediente> exp = Expediente.fromJsonList(expedienteJson);
    setExpedienteModel(exp);

    final expedienteSupremaJson = results[1]["data"];
    final List<ExpedienteSuprema> expSuprema =
        ExpedienteSuprema.fromJsonList(expedienteSupremaJson);
    setExpedienteSupremaModel(expSuprema);

    final expedienteIndecopiJson = results[2]["data"];
    final List<ExpedienteIndecopi> expIndecopi =
        ExpedienteIndecopi.fromJsonList(expedienteIndecopiJson);
    setExpedienteIndecopiModel(expIndecopi);

    final expedienteSinoeJson = results[3]["data"];
    final List<ExpedienteSinoe> expSinoe =
        ExpedienteSinoe.fromJsonList(expedienteSinoeJson);
    setExpedienteSinoeModel(expSinoe);

    procesoLoaded = true;

    // Retornar una instancia de CombinedData con los resultados combinados
    setCombinedDataProcesos(
      CombinedDataProcesos(
        expedienteJudicial: exp,
        expedienteSuprema: expSuprema,
        expedienteIndecopi: expIndecopi,
        expedienteSinoe: expSinoe,
      ),
    );
    return CombinedDataProcesos(
      expedienteJudicial: exp,
      expedienteSuprema: expSuprema,
      expedienteIndecopi: expIndecopi,
      expedienteSinoe: expSinoe,
    );
  }

  //

  CombinedDataProcesos getFilteredItems(String query) {
    // Filtrar los datos de la primera API (expedienteJudicial)
    List<Expediente> filteredExpedienteJudicial =
        _combinedDataProcesos.expedienteJudicial.where((item) {
      return item.nExpediente!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Filtrar los datos de la segunda API (expedienteSuprema)
    List<ExpedienteSuprema> filteredExpedienteSuprema = _combinedDataProcesos
        .expedienteSuprema
        .where((item) =>
            item.nExpediente!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Filtrar los datos de la segunda API (expedienteIndecopi)
    List<ExpedienteIndecopi> filteredExpedienteIndecopi = _combinedDataProcesos
        .expedienteIndecopi
        .where(
            (item) => item.numero!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Filtrar los datos de la segunda API (expedientesinoe)
    List<ExpedienteSinoe> filteredExpedienteSinoe = _combinedDataProcesos
        .expedienteSinoe
        .where((item) =>
            item.nExpediente!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Devolver un nuevo objeto CombinedDataProcesos con las listas filtradas
    return CombinedDataProcesos(
      expedienteJudicial: filteredExpedienteJudicial,
      expedienteSuprema: filteredExpedienteSuprema,
      expedienteIndecopi: filteredExpedienteIndecopi,
      expedienteSinoe: filteredExpedienteSinoe,
    );
  }

  // ? /api/procesos-poder-judicial/{idClient} - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoJudicial(int idClient) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/procesos-poder-judicial/$idClient')
        : Uri.http(_baseUrl, '/api/procesos-poder-judicial/$idClient');

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
        // final expedienteJson = decodeResponse["expedientes"];
        // final List<Expediente> exp = Expediente.fromJsonList(expedienteJson);
        // setExpedienteModel(exp);
        // return decodeResponse;
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": decodeResponse["expedientes"],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": [],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "totalExpedientes": 0,
        "limitExpedientes": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "totalExpedientes": 0,
      "limitExpedientes": null,
      "statusCode": 404,
    };
  }

  // ? /api/procesos-corte-suprema/{idClient}- Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoSuprema(int idClient) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/procesos-corte-suprema/$idClient')
        : Uri.http(_baseUrl, '/api/procesos-corte-suprema/$idClient');

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
          "message": decodeResponse["message"],
          "data": decodeResponse["expedientes"],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": [],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "totalExpedientes": 0,
        "limitExpedientes": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "totalExpedientes": 0,
      "limitExpedientes": null,
      "statusCode": 404,
    };
  }

  // ? /api/procesos-indecopi/{idClient} - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoIndecopi(int idClient) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/procesos-indecopi/$idClient')
        : Uri.http(_baseUrl, '/api/procesos-indecopi/$idClient');

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
          "message": decodeResponse["message"],
          "data": decodeResponse["expedientes"],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": [],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "totalExpedientes": 0,
        "limitExpedientes": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "totalExpedientes": 0,
      "limitExpedientes": null,
      "statusCode": 404,
    };
  }

  // ? /api/procesos-sinoe/{idClient} - Mostrar expediente del usuario
  Future<Map<String, dynamic>> procesoSinoe(int idClient) async {
    // Verifica la conexión a Internet
    if (!(await NetworkUtil.checkInternetConnection())) {
      return {
        "status": false,
        "message": "No hay conexión a Internet",
      };
    }
    final Uri url = _isProduction
        ? Uri.https(_baseUrl, '/api/procesos-sinoe/$idClient')
        : Uri.http(_baseUrl, '/api/procesos-sinoe/$idClient');

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
          "message": decodeResponse["message"],
          "data": decodeResponse["expedientes"],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
      if (response.statusCode == 404) {
        return {
          "status": true,
          "message": decodeResponse["message"],
          "data": [],
          "totalExpedientes": decodeResponse["totalExpedientes"],
          "limitExpedientes": decodeResponse["limitExpedientes"],
          "statusCode": response.statusCode,
        };
      }
    } catch (e) {
      return {
        "status": false,
        "message": "Error en la solicitud $e",
        "data": [],
        "totalExpedientes": 0,
        "limitExpedientes": null,
        "statusCode": 404,
      };
    }

    // En caso de que algo salga mal
    return {
      "status": false,
      "message": "Error desconocido",
      "data": [],
      "totalExpedientes": 0,
      "limitExpedientes": null,
      "statusCode": 404,
    };
  }
}
