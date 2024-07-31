import 'package:blogapp/widgets/blog_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  const Text("rest_less"),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
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