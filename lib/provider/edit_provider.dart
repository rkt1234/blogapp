import 'dart:convert';
import 'dart:io';
import 'package:blogapp/services/blog_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProvider extends ChangeNotifier {
    dynamic titleError;
  dynamic descriptionError;
  dynamic response;
    late Icon icon;
  String toastMessage = "";
  File? pickedImage;
  late String blogImageUrl;
bool isLoading = false;
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
        blogImageUrl = jsonMap['secure_url'];
        print(blogImageUrl);
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    }
  }
  void resetPickedImage() {
    pickedImage = null;
    notifyListeners();
  }
     Future<bool> checkValidity(currentBlogImageUrl,title, description, createdTime, userId, token,
      authorName, authorImageUrl, postId) async {
        blogImageUrl=currentBlogImageUrl;
    print("is wale me");

    titleError = title == "" ? "Please enter a title" : null;
    descriptionError = description == "" ? "Please enter description" : null;
    notifyListeners();
    return userServiceCall(title, description, createdTime, userId, token,
        authorName, authorImageUrl, postId);
  }
      Future<bool> userServiceCall(title, description, createdTime, userId, token,
      authorName, authorImageUrl, postId) async {
    isLoading = true;
    late bool isNavigate;
    if (titleError == null && descriptionError == null) {
      await uploadImage();
      response = await updateBlog(title, description, createdTime, blogImageUrl,
          userId, token, authorName, authorImageUrl, postId);

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
    print("yaha tak aa rha h ");
    isLoading = false;
    notifyListeners();
    return isNavigate;
  }
}