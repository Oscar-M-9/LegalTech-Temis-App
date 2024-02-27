import 'package:flutter/material.dart';
import 'package:legaltech_temis/core/utils/app_colors.dart';

class TextFormFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? minLines;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String obscuringCharacter;
  // final void Function()? onTap;

  const TextFormFieldCustom({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.minLines = 1,
    this.hintText,
    this.prefixIcon,
    // this.onTap,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.obscuringCharacter = '•',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      minLines: minLines,
      maxLines: 1,
      cursorColor: AppColors.primary,
      cursorOpacityAnimates: true,
      keyboardType: keyboardType,
      autocorrect: false,
      obscureText: obscureText,
      obscuringCharacter: obscuringCharacter,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        hintTextDirection: TextDirection.ltr,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            style: BorderStyle.none,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red.shade400,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: TextStyle(
          color: Colors.red.shade400,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
