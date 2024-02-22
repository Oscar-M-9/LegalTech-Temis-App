import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
// import 'package:legaltech_temis/views/login/login_view.dart';
import 'package:legaltech_temis/widgets/drawer_widget.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.calendar,
              ),
            ),
          ),
          badges.Badge(
            showBadge: true,
            ignorePointer: false,
            onTap: () {},
            badgeContent: const Text("0"),
            badgeAnimation: const badges.BadgeAnimation.scale(),
            badgeStyle: badges.BadgeStyle(
              badgeColor: CupertinoColors.destructiveRed,
              padding: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(4),
              elevation: 0,
            ),
            child: const Icon(CupertinoIcons.bell_solid),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              right: 10,
              left: 10,
              top: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: AppColors.primary700,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage("assets/icons/TEMIS FAVICON2.png"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Oscar, Chavesta",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "emai@email.com",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 40,
          //     left: 10,
          //     right: 10,
          //   ),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width * 0.9,
          //     height: 70,
          //     decoration: BoxDecoration(
          //       color: CupertinoColors.systemGrey6,
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: InkWell(
          //       onTap: () {
          //         print("cerrar sesion");
          //       },
          //       splashColor: AppColors.primary800,
          //       borderRadius: BorderRadius.circular(15),
          //       child: const Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         child: Row(
          //           children: [
          //             Icon(
          //               Icons.logout_outlined,
          //             ),
          //             SizedBox(
          //               width: 20,
          //             ),
          //             Text(
          //               "Cerrar sesión",
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              left: 10,
              right: 10,
            ),
            child: CupertinoButton(
              color: CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(15),
              pressedOpacity: 0.7,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Cerrar sesión",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
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
                } else {
                  // PersistentTabController().dispose();

                  // Luego, navega a la pantalla de inicio de sesión
                  // Navigator.pushReplacementNamed(context, Routes.login);
                  // ignore: use_build_context_synchronously
                  // Navigator.of(context).popUntil((route) {
                  //   return route.settings.name == Routes.login;
                  // });
                  // Navigator.of(context).popUntil((route) => true);
                  // Navigator.pushReplacementNamed(context, Routes.login);
                  // PersistentNavBarNavigator.pushNewScreen(
                  //   context,
                  //   screen: LoginView(),
                  //   withNavBar: false, // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );
                  // Navigator.of(context).popUntil((route) => false);
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   CupertinoPageRoute(
                  //     builder: (BuildContext context) {
                  //       return LoginView();
                  //     },
                  //   ),
                  //   (_) => false,
                  // );
                  // ignore: use_build_context_synchronously
                  // Navigator.pushReplacementNamed(context, Routes.login);
                  // ignore: use_build_context_synchronously
                  // PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                  //   context,
                  //   settings: const RouteSettings(name: Routes.login),
                  //   screen: const LoginView(),
                  //   withNavBar: false,
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );
                  // SnackbarCustomService.showSnackbar(
                  //   message,
                  //   backgroundColor: Colors.green,
                  // );

                  // Navigator.popUntil(context, (route) {
                  //   final name = route.settings.name.;
                  //   print("😎 ${name}");
                  //   if (name == Routes.login) {
                  //     return true;
                  //   }
                  //   return false;
                  // });
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                    (route) => false, // Elimina todas las rutas anteriores
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
