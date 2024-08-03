import 'package:blogapp/screens/signin_screen.dart';
import 'package:blogapp/services/navigation_service.dart';
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
  late String userName;
  late SharedPreferences pref;
  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    Map<String, dynamic> jwtDecoded = JwtDecoder.decode(widget.token,);
    userName = jwtDecoded['username'];
  }

  void initSharedPreferences() async {
    pref = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await pref.remove('jwt_token');
          pushReplacement(context, const SigninScreen());
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
                  const CircleAvatar(),
                  const Spacer(),
                  Text(userName),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return const BlogTile();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
