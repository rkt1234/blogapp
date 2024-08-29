import 'dart:convert';

import 'package:blogapp/models/blog.dart';
import 'package:blogapp/utils/api_urls.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:http/http.dart' as http;

Stream<List<Blog>> getBlogStream(String token) async* {
  try {
    while (true) {
      List<Blog> blogs = await getBlog(token);
      yield blogs;
      await Future.delayed(const Duration(seconds: 1)); // Polling interval
    }
  } catch (e) {
    yield [];
  }
}

Future<List<Blog>> getBlog(token) async{
  Map<String, String> headers = {
    'uid': uId.toString(),
  };
  dynamic response = await http.get(Uri.parse(fetchBlogUrl), headers: headers);
  print(response.body);
   if (response.statusCode == 200) {
    print("ye nhi h");
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> messages = data['message'];
    return messages.map((json) => Blog.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<dynamic> createBlog(String title, String description, String createdTime, String blogimageUrl, int userId, String token, String authorName, String authorImageUrl) async {
  Map<String,dynamic> body = Blog(title: title, description: description, createdTime: createdTime, imageUrl: blogimageUrl, userId: userId, postId: 0, authorImageUrl: authorImageUrl, authorName: authorName).toJsonBlog();
   Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
    };
    print(token);
    print(body);
    dynamic response = await http.post(Uri.parse(createBlogUrl), body: jsonEncode(body), headers: headers);
    print(response.body);
    return response;
}

Future<List<Blog>> getUserBlog(token) async {
  Map<String, String> headers = {
    'uid': uId.toString(),
  };
  dynamic response = await http.get(Uri.parse(fetchUserBlogUrl), headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    print("ye nhi h");
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> messages = data['message'];
    return messages.map((json) => Blog.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<dynamic> deletePost(postId, token) async {
  Map<String, int> body = {"postId": postId};
     Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
  dynamic response = await http.delete(Uri.parse(deleteBlogUrl), body: jsonEncode(body), headers: headers);
  print(response.body);
  return response;

}

Future<dynamic> updateBlog(title, description, createdTime, blogImageUrl,
    userId, token, authorName, authorImageUrl, postId) async {
     Map<String, dynamic> body = Blog(
          title: title,
          description: description,
          createdTime: createdTime,
          imageUrl: blogImageUrl,
          userId: userId,
          postId: postId,
          authorImageUrl: authorImageUrl,
          authorName: authorName)
      .toJsonBlog();
      Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': "Bearer $token",
  };
    dynamic response = await http.post(Uri.parse(updateBlogUrl),
      body: jsonEncode(body), headers: headers);
  print(response.body);
  print(jsonDecode(response.body)['message']);
  return response;
}
