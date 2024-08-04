import 'dart:convert';

import 'package:blogapp/models/blog.dart';
import 'package:blogapp/provider/delete_provider.dart';
import 'package:blogapp/screens/view_blog_screen.dart';
import 'package:blogapp/services/blog_api_service.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/services/toast_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/widgets/blog_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final token;
  const ProfileScreen({super.key, this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Blog>> _futureBlogs;

  @override
  void initState() {
    
    super.initState();
    _futureBlogs = getUserBlog(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    print("firse");
    return Consumer<DeleteProvider>(
      builder: (context, provider, child) {
        return Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(userName),
                  const SizedBox(height: 20),
                  const Text("My Blogs "),
                  const SizedBox(
                    height: 50,
                  ),
                  Flexible(
                      child: FutureBuilder<List<Blog>>(
                    future: _futureBlogs,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Looks like it is empty here'));
                      } else {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () async {
                                await provider.showBottomSheet(context,
                                    snapshot.data![index].postId, widget.token);
                                print("baad mein");
                                getToast(
                                    context,
                                    provider.toastMessage,
                                    const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ));
                              },
                              onTap: () {
                                push(context, const ViewBlogScreen());
                              },
                              child: BlogTile(
                                description: snapshot.data![index].description,
                                title: snapshot.data![index].title,
                                authorName: snapshot.data![index].authorName,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ))
                ],
              ),
            ),
            // provider.islogin
            //     ? const Center(
            //         child: Text("yufvyv"),
            //       )
            //     : Container()
          ],
        )),
      );
      }
    );
  }
}
