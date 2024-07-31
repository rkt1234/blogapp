import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic passwordError;

  void checkValidity(email, password) {
    print("inside");
    print(email);
    emailError = email == "" ? "Please enter an email" : null;
    passwordError = password == "" ? "Please enter a password" : null;

    notifyListeners();
  }
}
