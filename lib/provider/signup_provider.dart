import 'dart:convert';
import 'dart:io';
// import 'dart:js_interop';
import 'package:blogapp/services/user_api_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  Future<bool> checkValidity(email, userName, password) async {
    emailError = email == "" ? "Please enter an email" : null;
    usernameError = userName == "" ? "Please enter a username" : null;
    passwordError = password == "" ? "Please enter a password" : null;
    notifyListeners();
    return userServiceCall(email, password, userName);
  }

  Future<bool> userServiceCall(email, password, userName) async {
    isLoading = true;
    late bool isNavigate;
    if (emailError == null && passwordError == null && usernameError == null) {
      await uploadImage();
      response = await registerService(email, password, userName, imageUrl);

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
      pickedImage = File(image.path);
      print(pickedImage);
      
    }
    notifyListeners();
  }

  Future<void> uploadImage() async {
    final uploadUrl = "https://api.cloudinary.com/v1_1/ddrldbm5c/upload";

    if (pickedImage != null) {
      final request = http.MultipartRequest('POST', Uri.parse(uploadUrl))
        ..fields['upload_preset'] = "vjb0mgsb"
        ..files
            .add(await http.MultipartFile.fromPath('file', pickedImage!.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = utf8.decode(responseData);
        final jsonMap = jsonDecode(responseString);
        // Use the jsonMap to extract the uploaded image URL
        imageUrl = jsonMap['secure_url'];
        print(imageUrl);
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    }
  }
}
