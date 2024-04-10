import 'package:chat_app/theme/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: MyColors.primary,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: MyColors.primary),
        ),
        fillColor: MyColors.white,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColors.grey),
      ),
    );
  }
}
