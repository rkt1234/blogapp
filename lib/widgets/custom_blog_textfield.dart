import 'package:flutter/material.dart';

class BlogCustomTextField extends StatefulWidget {
  const BlogCustomTextField({super.key});

  @override
  State<BlogCustomTextField> createState() => _BlogCustomTextFieldState();
}

class _BlogCustomTextFieldState extends State<BlogCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return  const TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "E-mail"
      )
    );
  }
}