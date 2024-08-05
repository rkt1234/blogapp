import 'dart:convert';


import 'package:blogapp/models/user.dart';
import 'package:blogapp/utils/api_urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> loginService(String email, String password) async {
  print("api call started");
    Map<String, String> body =
        UserModel(password: password, email: email, userName: '', imageUrl: '').toJsonLogin();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // Add other headers if needed

    dynamic response = await http.post(Uri.parse(loginUrl),
        body: jsonEncode(body), headers: headers);
        return response;
  } 

Future<dynamic> registerService(String email, String password, String userName, String imageUrl) async {
  print("inside register");
  print(imageUrl);
  Map<String, String> body =
      UserModel(password: password, email: email, userName: userName, imageUrl: imageUrl)
          .toJsonRegister();
  Map<String, String> headers = {'Content-Type': 'application/json'};
  // Add other headers if needed

  dynamic response = await http.post(Uri.parse(registerUrl),
      body: jsonEncode(body), headers: headers);
      print(response.body);
  return response;
} 
