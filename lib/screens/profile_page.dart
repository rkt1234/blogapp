import 'dart:convert';

import 'package:blogapp/models/blog.dart';
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
                future: getUserBlog(widget.token),
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
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                        onTap: () {
                                          // Handle edit action
                                          Navigator.pop(
                                              context); // Close the bottom sheet
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.delete, color: Colors.red,),
                                        title: Text('Delete'),
                                        onTap: () async{
                                          
                                         
                                          var response = await deletePost(snapshot.data![index].postId, widget.token);
                                          setState(() {
                                            print("inside set statde");
                                          });
                                          if(response.statusCode==200) {
                                            print("if me aa gaya h ");
                                            getToast(
                                                context, "Blog deleted", Icon(Icons.check, color: Colors.green,));
                                          }
                                          else {
                                            print("else me aa gaya h ");
                                            getToast(
                                                context,
                                                jsonDecode(response.body)['message'],
                                                Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ));
                                          }
                                          pop(context);
                                          print("baad mein ho rha h");
                                          // Handle delete action
                                         
                                            // Close the bottom sheet
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
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
}
