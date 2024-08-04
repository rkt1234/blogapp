import 'dart:convert';

import 'package:blogapp/services/blog_api_service.dart';
import 'package:flutter/material.dart';

class CreateProvider extends ChangeNotifier {
  dynamic titleError;
  dynamic descriptionError;
  dynamic response;
  late Icon icon;
  String toastMessage = "";
  String jwt = "";
  bool isLoading = false;

   Future<bool> checkValidity(
      title, description, createdTime, imageUrl, userId, token, authorName, authorImageUrl) async {
        print("is wale me");
    titleError = title == "" ? "Please enter a title" : null;
    descriptionError = description == "" ? "Please enter description" : null;
    notifyListeners();
    return userServiceCall(title, description, createdTime, imageUrl, userId, token, authorName, authorImageUrl);
  }

    Future<bool> userServiceCall(
      title, description, createdTime, imageUrl, userId, token, authorName, authorImageUrl) async {
    isLoading = true;
    late bool isNavigate;
    if (titleError == null && descriptionError == null) {
      response = await createBlog(title, description, createdTime, imageUrl, userId, token, authorName, authorImageUrl);

      if (response.statusCode == 200) {
        toastMessage =  jsonDecode(response.body)['message'];
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
}