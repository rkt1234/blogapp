import 'package:flutter/material.dart';

class AuthCustomTextField extends StatefulWidget {
  final String labelText;
  final TextStyle labelStyle;
  const AuthCustomTextField({super.key, required this.labelText, required this.labelStyle});

  @override
  State<AuthCustomTextField> createState() => _AuthCustomTextFieldState();
}

class _AuthCustomTextFieldState extends State<AuthCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        labelText:widget.labelText,
        labelStyle:widget.labelStyle ,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
