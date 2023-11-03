import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  TextEditingController controller;

  bool isPassword;
  String hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  TextInputType keyboardType;
  TextFieldInput({
    Key? key,
    required this.controller,
    required this.isPassword,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      cursorColor: const Color.fromARGB(218, 226, 37, 24),
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      textInputAction: TextInputAction.next,
      obscureText: isPassword,
    );
  }
}
