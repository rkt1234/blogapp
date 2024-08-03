import 'dart:convert';

import 'package:blogapp/models/blog.dart';
import 'package:blogapp/utils/api_urls.dart';
import 'package:http/http.dart' as http;

Future<List<Blog>> getBlog() async{
  dynamic response = await http.get(Uri.parse(fetchBlogUrl));
  print(response.body);
   if (response.statusCode == 401) {
    print("ye nhi h");
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> messages = data['message'];
    return messages.map((json) => Blog.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}