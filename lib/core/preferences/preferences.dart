import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _token = '';
  static String _user = '';
  static String _dataCompany = '';
  static String _dataSuscripcion = '';
  static int _countNoti = 0;
  static int _idUltNoti = 0;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //? GET & SET

  // * token de la autentificación
  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token) {
    _token = token;
    _prefs.setString('token', token);
  }

  // * Usuario autentificado
  static String get user {
    return _prefs.getString('user') ?? _user;
  }

  static set user(String user) {
    _user = user;
    _prefs.setString('user', user);
  }

  // * Datos de la compañia del usuario autentificado
  static String get dataCompany {
    return _prefs.getString('dataCompany') ?? _dataCompany;
  }

  static set dataCompany(String dataCompany) {
    _dataCompany = dataCompany;
    _prefs.setString('dataCompany', dataCompany);
  }

  // * Datos de la suscripción del usuario autentificado
  static String get dataSuscripcion {
    return _prefs.getString('dataSuscripcion') ?? _dataSuscripcion;
  }

  static set dataSuscripcion(String dataSuscripcion) {
    _dataSuscripcion = dataSuscripcion;
    _prefs.setString('dataSuscripcion', dataSuscripcion);
  }

  // * cantidad de notificaciones

  static int get countNoti {
    return _prefs.getInt('countNoti') ?? _countNoti;
  }

  static set countNoti(int countNoti) {
    _countNoti = countNoti;
    _prefs.setInt('countNoti', countNoti);
  }
  // * id de la ultima notificacion

  static int get idUltNoti {
    return _prefs.getInt('idUltNoti') ?? _idUltNoti;
  }

  static set idUltNoti(int idUltNoti) {
    _idUltNoti = idUltNoti;
    _prefs.setInt('idUltNoti', idUltNoti);
  }
}
