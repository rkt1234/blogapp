import 'package:blogapp/provider/signin_provider.dart';
import 'package:blogapp/provider/signup_provider.dart';
import 'package:blogapp/screens/create_blog_screen.dart';
import 'package:blogapp/screens/home_screen.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/screens/signup_screen.dart';
import 'package:blogapp/screens/view_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
     runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => SigninProvider()),
      ],
      child:
          const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const SigninScreen();
  }
}