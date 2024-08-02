import 'dart:convert';

import 'package:blogapp/models/user.dart';
import 'package:blogapp/utils/api_urls.dart';
import 'package:http/http.dart' as http;

Future<dynamic> call(String email, String password) async {
  {
    print(email);
    print(password);
    Map<String, String> body =
        UserModel(password: password, email: email, userName: '', imageUrl: '').toJsonLogin();
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // Add other headers if needed

    dynamic response = await http.post(Uri.parse(loginUrl),
        body: jsonEncode(body), headers: headers);

        return response;
  } 

  

}
