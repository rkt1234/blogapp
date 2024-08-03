import 'dart:convert';

import 'package:blogapp/services/user_api_service.dart';
import 'package:blogapp/utils/api_urls.dart';
import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic passwordError;
  dynamic response;
  late Icon icon;
  String toastMessage = "";
  String jwt="";
  bool isLoading=false;


  Future<bool> checkValidity(email, password) async {
    emailError = email == "" ? "Please enter an email" : null;
    passwordError = password == "" ? "Please enter a password" : null;
    notifyListeners();
    return userServiceCall(email, password);
  }

  Future<bool> userServiceCall(email, password) async {
    isLoading=true;
    late bool isNavigate;
    if (emailError == null && passwordError == null) {
      response = await loginService(email, password);

      if (response.statusCode == 200) {
        jwt = jsonDecode(response.body)['message'];
        toastMessage = "Login successful";
        isNavigate = true;
        icon = const Icon(Icons.check, color: Colors.green);
      } else {
        toastMessage = jsonDecode(response.body)['message'];
        isNavigate = false;
        icon = const Icon(Icons.error, color: Colors.red);
      }
    }
    isLoading=false;
    notifyListeners();
    return isNavigate;
  }
}



