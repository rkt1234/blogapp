import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic usernameError;
  dynamic passwordError;

  void checkValidity(email, username, password) {
    print("inside");
    print(email);
    emailError = email == "" ? "Please enter an email" : null;
    usernameError = username == "" ? "Please enter a username" : null;
    passwordError = password == "" ? "Please enter a password" : null;

    notifyListeners();
  }
}
