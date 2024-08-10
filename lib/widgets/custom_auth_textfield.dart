import 'package:flutter/material.dart';

class AuthCustomTextField extends StatefulWidget {
  final String labelText;
  final TextStyle labelStyle;
  final TextEditingController? controller;
  final bool? obscureText;
  // ignore: prefer_typing_uninitialized_variables
  final errorText;
  const AuthCustomTextField(
      {super.key,
      required this.labelText,
      required this.labelStyle,
      this.controller,
      required this.errorText, this.obscureText});

  @override
  State<AuthCustomTextField> createState() => _AuthCustomTextFieldState();
}

class _AuthCustomTextFieldState extends State<AuthCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText??false,
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: widget.errorText,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
