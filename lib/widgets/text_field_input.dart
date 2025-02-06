import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput(
      {super.key,
      required this.controller,
      required this.hinttext,
      this.isPass = false,
      required this.textInputType});
  final TextEditingController controller;
  final String hinttext;
  final TextInputType textInputType;
  final bool isPass;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hinttext,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(10)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
