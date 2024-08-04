import 'package:blogapp/models/blog.dart';
import 'package:blogapp/screens/create_blog_screen.dart';
import 'package:blogapp/screens/profile_page.dart';
import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/screens/view_blog_screen.dart';
import 'package:blogapp/services/blog_api_service.dart';
import 'package:blogapp/services/navigation_service.dart';
import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/widgets/blog_tile.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final token;
  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences pref;
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(
      widget.token,
    );
    userName = jwtDecoded['username'];
    uId = jwtDecoded['uid'];
    imageUrl = jwtDecoded['imageurl'];
  }

  void initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          push(
              context,
              CreateBlog(
                token: widget.token,
              ));
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {
                        push(
                            context,
                            ProfileScreen(
                              token: widget.token,
                            ));
                      },
                      child: const CircleAvatar()),
                  const Spacer(),
                  Text(userName),
                  const Spacer(),
                  IconButton(
                      onPressed: () async {
                        await pref.remove('jwt_token');
                        pushReplacement(context, const SigninScreen());
                      },
                      icon: const Icon(Icons.logout))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                child: FutureBuilder<List<Blog>>(
              future: getBlog(widget.token),
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
                        onTap: () {
                          push(context, ViewBlogScreen());
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
    );
  }
}
