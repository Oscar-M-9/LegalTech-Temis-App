import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
// import 'package:legaltech_temis/views/home/home_view.dart';
// import 'package:legaltech_temis/views/login/login_view.dart';
import 'package:provider/provider.dart';

class VerifyAuthView extends StatelessWidget {
  const VerifyAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return const Text(
                'Cargando . . . ',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                ),
              );
            }
            if (snapshot.data == '') {
              Future.microtask(
                () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
              );
            } else {
              Future.microtask(
                () {
                  Navigator.pushReplacementNamed(context, Routes.home);
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
