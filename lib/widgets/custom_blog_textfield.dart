import 'package:flutter/material.dart';

class BlogCustomTextField extends StatefulWidget {
  final String labelText;
  final TextStyle labelStyle;
  final TextEditingController? controller;
  // ignore: prefer_typing_uninitialized_variables
  final errorText;
  BlogCustomTextField({super.key, this.controller, required this.labelText, required this.labelStyle, this.errorText});

  @override
  State<BlogCustomTextField> createState() => _BlogCustomTextFieldState();
}

class _BlogCustomTextFieldState extends State<BlogCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: widget.controller,
      decoration: InputDecoration(
        errorText: widget.errorText,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        border: InputBorder.none,
        
      ),
    );
    
  }
}
