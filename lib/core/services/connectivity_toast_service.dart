import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToastOnConectivity {
  static showToastOnConnectivityChange(
      BuildContext context, ConnectivityResult connectivityResult) {
    String message = connectivityResult == ConnectivityResult.none
        ? "Desconectado"
        : "Conectado";

    Fluttertoast.cancel(); // Cancela cualquier Toast pendiente
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade600,
      textColor: Colors.white,
    );
  }
}
