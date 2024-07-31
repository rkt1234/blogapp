import 'package:blogapp/widgets/custom_auth_textfield.dart';
import 'package:blogapp/widgets/custom_blog_textfield.dart';
import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create a new blog"), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10),child: const BlogCustomTextField(),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(10)),
              child: const BlogCustomTextField(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
