import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legaltech_temis/core/models/user_model.dart';
import 'package:legaltech_temis/core/preferences/preferences.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
import 'package:legaltech_temis/core/services/clientes_service.dart';
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jsonUser = jsonDecode(Preferences.user);
    final User usuario = User.fromJson(jsonUser);
    Brightness currentBrightness = Theme.of(context).brightness;

    return Drawer(
      backgroundColor:
          currentBrightness == Brightness.light ? Colors.white : Colors.black,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    maxRadius: 35,
                    backgroundColor: AppColors.primary,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage("assets/icons/TEMIS FAVICON2.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        "${usuario.name}, ${usuario.lastname}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AutoSizeText(
                        usuario.email,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 10,
          //     left: 10,
          //     top: 40,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       const CircleAvatar(
          //         maxRadius: 40,
          //         backgroundColor: AppColors.primary,
          //         child: Padding(
          //           padding: EdgeInsets.all(10.0),
          //           child: Image(
          //             image: AssetImage("assets/icons/TEMIS FAVICON2.png"),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 15,
          //       ),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           AutoSizeText(
          //             "${usuario.name}, ${usuario.lastname}",
          //             style: const TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //           AutoSizeText(
          //             usuario.email,
          //             style: const TextStyle(
          //               fontSize: 13,
          //               fontWeight: FontWeight.w300,
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    // color: currentBrightness == Brightness.light
                    //     ? AppColors.primary950.withOpacity(.1)
                    //     : Colors.grey[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    leading: const Icon(Icons.home_rounded),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.home);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 15,
                    bottom: 5,
                  ),
                  child: SizedBox(
                    height: 25,
                    child: Text(
                      "Administración".toUpperCase(),
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w700,
                        color: currentBrightness == Brightness.light
                            ? AppColors.primary950.withOpacity(.3)
                            : Colors.grey[600],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    // color: currentBrightness == Brightness.light
                    //     ? AppColors.primary950.withOpacity(.1)
                    //     : Colors.grey[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    leading: const Icon(CupertinoIcons.person_3_fill),
                    title: const Text('Clientes'),
                    onTap: () {
                      final clienteService = context.read<ClienteService>();
                      clienteService.query = "";
                      clienteService.clientesLoaded = false;
                      Navigator.pushReplacementNamed(context, Routes.clientes);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: 15,
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.only(
                left: 20,
                top: 15,
                bottom: 15,
              ),
              color: currentBrightness == Brightness.light
                  ? Colors.red[700]
                  : Colors.red[900],
              borderRadius: BorderRadius.circular(15),
              pressedOpacity: 0.7,
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: currentBrightness == Brightness.light
                          ? AppColors.white
                          : Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AutoSizeText(
                      "Cerrar sesión",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: currentBrightness == Brightness.light
                            ? AppColors.white
                            : Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () async {
                final authService = context.read<AuthService>();
                final String? message = await authService.logout();
                if (message == null) {
                  SnackbarCustomService.showSnackbar(
                    'Error en la solicitud',
                    backgroundColor: Colors.red.shade700,
                  );
                } else if (message == "No hay conexión a Internet") {
                  Fluttertoast.showToast(
                    msg: message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey.shade600,
                    textColor: Colors.white,
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false, // Elimina todas las rutas anteriores
                  );
                  SnackbarCustomService.showSnackbar(
                    message,
                    backgroundColor: Colors.green,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
