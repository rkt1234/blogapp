import 'dart:convert';

import 'package:blogapp/services/blog_api_service.dart';
import 'package:flutter/material.dart';

class DeleteProvider extends ChangeNotifier {

  bool islogin=false;
  late Icon icon;
    String toastMessage = "";
    showBottomSheet(BuildContext context, int postId, String token) async {
      print(islogin);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text('Delete'),
              onTap: () async {
                islogin=true;
                print("inside");
                // Handle delete action
                Navigator.pop(context);
                final response = await deletePost(postId, token);
                if (response.statusCode == 200) {
                  toastMessage = "Blog deleted";
                  // isNavigate = true;
                  icon = const Icon(Icons.check, color: Colors.green);
                } else {
                  toastMessage = jsonDecode(response.body)['message'];
                  // isNavigate = false;
                  icon = const Icon(Icons.error, color: Colors.red);
                }
                islogin=false;
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit'),
              onTap: () {
                // Handle edit action
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    notifyListeners();
  }
}