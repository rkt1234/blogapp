import 'package:blogapp/models/user.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic usernameError;
  dynamic passwordError;

  void checkValidity(email, userName, password) {
    emailError = email == "" ? "Please enter an email" : null;
    usernameError = userName == "" ? "Please enter a username" : null;
    passwordError = password == "" ? "Please enter a password" : null;

    if(emailError== null && usernameError==null && passwordError==null)
    {
      Map<String,String> user = UserModel(userName: userName, password: password, email: email, imageUrl: "imageUrl").toJson();
    }

    notifyListeners();
  }
}
