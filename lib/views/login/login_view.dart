import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:legaltech_temis/core/providers/index.dart';
import 'package:legaltech_temis/core/routes/routes.dart';
import 'package:legaltech_temis/core/services/auth_service.dart';
import 'package:legaltech_temis/core/services/snackbar_service.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';
import 'package:legaltech_temis/widgets/textformfield_widget.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = context.read<ThemeProvider>();
    final passwordVisibilityProvider =
        context.watch<PasswordVisibilityProvider>();
    final loginProvider = context.watch<LoginProvider>();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
          /*  */
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                // bottom: 50,
                right: 15,
                left: 15,
                top: 20,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height < 400
                    ? MediaQuery.of(context).size.height * 1.5
                    : MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width > 400
                    ? 320
                    : MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.bottomCenter,
                child: Form(
                  key: loginProvider.formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            height: 150,
                            child: Image(
                              image: AssetImage(
                                'assets/icons/TEMIS FAVICON3.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Inicia sesión",
                          style: Theme.of(context).textTheme.labelMedium,
                          // style: TextStyle(
                          //   // color: AppColors.primary,
                          //   fontFamily: "Poppins",
                          //   fontSize: 24,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(
                          double.infinity,
                          20,
                        ),
                      ),
                      TextFormFieldCustom(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.email_rounded),
                        ),
                        hintText: "email@temisperu.com",
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          loginProvider.email = value;
                        },
                        validator: (value) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = RegExp(pattern);

                          return regExp.hasMatch(value ?? '')
                              ? null
                              : 'La dirección de correo electrónico no es válida';
                        },
                      ),
                      SizedBox.fromSize(
                        size: const Size(
                          double.infinity,
                          20,
                        ),
                      ),
                      TextFormFieldCustom(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.password_outlined),
                        ),
                        hintText: "*********",
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: passwordVisibilityProvider.obscureText,
                        obscuringCharacter: "*",
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisibilityProvider.obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            passwordVisibilityProvider.toggleVisibility();
                            print("presionando icon eye");
                          },
                        ),
                        onChanged: (value) => loginProvider.password = value,
                        validator: (value) {
                          return (value != null && value.length >= 8)
                              ? null
                              : 'La contraseña debe tener más de 8 caracteres';
                        },
                      ),
                      SizedBox.fromSize(
                        size: const Size(
                          double.infinity,
                          50,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 3,
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor:
                                AppColors.primary.withAlpha(255),
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            minimumSize: const Size(88, 36),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                            ),
                          ),
                          /*  */
                          onPressed: loginProvider.isLoading
                              ? null
                              : () async {
                                  FocusScope.of(context).unfocus();
                                  /* -- */
                                  /* variable que conecta al servicio de faribase */
                                  final authService =
                                      context.read<AuthService>();
                                  if (!loginProvider.isValidForm()) return;
                                  loginProvider.isLoading = true;

                                  final String? errorMessage =
                                      await authService.login(
                                    loginProvider.email,
                                    loginProvider.password,
                                  );

                                  if (errorMessage == null) {
                                    // loginProvider.isLoading = false;
                                    SnackbarCustomService.showSnackbar(
                                      'Bienvenido',
                                      backgroundColor: Colors.green,
                                    );
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacementNamed(
                                        context, Routes.home);
                                  } else if (errorMessage ==
                                      "No hay conexión a Internet") {
                                    Fluttertoast.showToast(
                                      msg: errorMessage,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey.shade600,
                                      textColor: Colors.white,
                                    );
                                  } else {
                                    // loginProvider.isLoading = false;
                                    SnackbarCustomService.showSnackbar(
                                      errorMessage,
                                      backgroundColor: Colors.red.shade700,
                                    );
                                  }
                                  loginProvider.isLoading = false;

                                  // await Future.delayed(
                                  //   const Duration(seconds: 2),
                                  // );
                                },

                          child: (loginProvider.isLoading)
                              ? const SizedBox(
                                  height: 23,
                                  width: 23,
                                  child: CircularProgressIndicator(
                                    color: AppColors.secondary,
                                    backgroundColor: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Iniciar sesión",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                          /*  */
                          // child: const Text(
                          //   "Iniciar sesión",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontFamily: "Poppins",
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ),
                      ),
                      SizedBox.fromSize(
                        size: const Size(
                          double.infinity,
                          50,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
