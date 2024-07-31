import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic passwordError;

  void checkValidity(email, password) async{
    emailError = email == "" ? "Please enter an email" : null;
    passwordError = password == "" ? "Please enter a password" : null;
    if(emailError == null && passwordError == null){
      print(emailError);
      print(passwordError);
    }
          print(email);
    print(password);
    notifyListeners();
  }
}
