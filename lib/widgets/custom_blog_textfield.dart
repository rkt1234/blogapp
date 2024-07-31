import 'package:flutter/material.dart';

class BlogCustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  BlogCustomTextField({super.key, this.controller});

  @override
  State<BlogCustomTextField> createState() => _BlogCustomTextFieldState();
}

class _BlogCustomTextFieldState extends State<BlogCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: "E-mail"));
  }
}
