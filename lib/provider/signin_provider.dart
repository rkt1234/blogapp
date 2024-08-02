

import 'dart:convert';

import 'package:blogapp/services/call.dart';
import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic passwordError;
  dynamic response;

  String toastMessage = "";

  Future<bool> checkValidity(email, password) async{
    late bool isNavigate;
    print("hello here");
    emailError = email == "" ? "Please enter an email" : null;
    passwordError = password == "" ? "Please enter a password" : null;
    if(emailError == null && passwordError == null){
      response = await call(email, password);
      print("hello here");
      print(jsonDecode(response.body)['message']);
      if(response.statusCode==200) {
        toastMessage = jsonDecode(response.body)['message'];
        isNavigate=true;
      } else {
        toastMessage = jsonDecode(response.body)['message'];
        isNavigate=false;
      }
    }
    print(toastMessage);
    notifyListeners();
    return isNavigate;
  }
}
