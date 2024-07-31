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
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add,color: Colors.black,),
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
                  const Text("rest_less"),
                  const Spacer(),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.logout))
                ],
              ),
            ),
            const SizedBox(height: 20,),
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