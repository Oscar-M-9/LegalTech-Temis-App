import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final String hinText;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  const SearchInput({
    super.key,
    required this.hinText,
    required this.prefixIcon,
    this.onChanged,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ).copyWith(
        top: 15,
        bottom: 10,
      ),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        autocorrect: false,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hinText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.normal,
          ),
          filled: true,
          fillColor: currentBrightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.grey[800],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
