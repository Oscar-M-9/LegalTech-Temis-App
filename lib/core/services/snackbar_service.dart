import 'package:flutter/material.dart';

class SnackbarCustomService {
  static GlobalKey<ScaffoldMessengerState> msgkey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String msg, {Color? backgroundColor, Color? color}) {
    final snackbar = SnackBar(
      backgroundColor: backgroundColor ?? Colors.grey.shade700,
      content: Text(
        msg,
        style: TextStyle(
          color: color ?? Colors.white,
        ),
      ),
    );
    msgkey.currentState!.showSnackBar(snackbar);
  }
}
