import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';

class NoConnectionView extends StatelessWidget {
  final String? message;
  final void Function()? onPressed;
  const NoConnectionView({
    super.key,
    this.message,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              message ?? "",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: onPressed,
            elevation: 2,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 30,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: currentBrightness == Brightness.light
                ? Colors.grey[300]
                : Colors.grey[800],
            splashColor: AppColors.primary900.withOpacity(.1),
            child: const Text(
              "Reintentar",
            ),
          )
        ],
      ),
    );
  }
}
