import 'package:blogapp/screens/home_screen.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MyApp(),debugShowCheckedModeBanner: false,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}