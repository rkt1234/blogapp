import 'dart:convert';
import 'dart:io';
import 'package:blogapp/services/user_api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignupProvider extends ChangeNotifier {
  dynamic emailError;
  dynamic usernameError;
  dynamic passwordError;
  bool isLoading = false;
  dynamic response;
  late Icon icon;
  String jwt = "";
  String toastMessage = "";
  File? pickedImage;

  Future<bool> checkValidity(email, userName, password) async{
    emailError = email == "" ? "Please enter an email" : null;
    usernameError = userName == "" ? "Please enter a username" : null;
    passwordError = password == "" ? "Please enter a password" : null;
    notifyListeners();
    return userServiceCall(email, password, userName);
  }

  
  Future<bool> userServiceCall(email, password, userName) async {
    isLoading = true;
    late bool isNavigate;
    if (emailError == null && passwordError == null && usernameError==null) {
      response = await registerService(email, password, userName);

      if (response.statusCode == 200) {
        toastMessage = jsonDecode(response.body)['message'];
        isNavigate = true;
        icon = const Icon(Icons.check, color: Colors.green);
      } else {
        toastMessage = jsonDecode(response.body)['message'];
        isNavigate = false;
        icon = const Icon(Icons.error, color: Colors.red);
      }
    }
    isLoading = false;
    notifyListeners();
    return isNavigate;
  }

    pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage=File(image.path);
    } 
    notifyListeners();
  }
}
