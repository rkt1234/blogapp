import 'package:blogapp/provider/signin_provider.dart';
import 'package:blogapp/provider/signup_provider.dart';
import 'package:blogapp/screens/home_screen.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => SigninProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: MyApp(prefs: prefs))));
}

class MyApp extends StatefulWidget {
  final prefs;
  const MyApp({super.key, required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    String? token = widget.prefs.getString('jwt_token');
    if (token == null || JwtDecoder.isExpired(token)) {
      return const SigninScreen();
    } else {
      return HomeScreen(token: token);
    }
  }
}
