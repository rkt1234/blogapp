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
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';
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
    uId = jwtDecoded['sub'];
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
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl))),
                  const Spacer(),
                  Text(userName,  style: GoogleFonts.lato(
                        fontSize: 25, fontWeight: FontWeight.w900),
                  ),
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
                child: StreamBuilder<List<Blog>>(
              stream: getBlogStream(widget.token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/empty.json'),
                      Center(
                        child: Text(
                          'No blog posts yet',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          push(context, ViewBlogScreen(title: snapshot.data![index].title, description: snapshot.data![index].description, blogImageUrl: snapshot.data![index].imageUrl, createdAt: snapshot.data![index].createdTime,));
                        },
                        child: BlogTile(
                            description: snapshot.data![index].description,
                            title: snapshot.data![index].title,
                            authorName: snapshot.data![index].authorName,
                            authorImageUrl:
                                snapshot.data![index].authorImageUrl, imageUrl: snapshot.data![index].imageUrl,),
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
