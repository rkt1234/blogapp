import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:flutter/material.dart';

class ViewBlogScreen extends StatefulWidget {
  const ViewBlogScreen({super.key});

  @override
  State<ViewBlogScreen> createState() => _ViewBlogScreenState();
}

class _ViewBlogScreenState extends State<ViewBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const CircleAvatar(),
                    const Spacer(),
                    const Text("rest_less"),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://media.gettyimages.com/id/1492656400/photo/chennai-india-mahendra-singh-dhoni-of-chennai-super-kings-catches-their-helmet-whilst.jpg?s=612x612&w=gi&k=20&c=JbYno-lPxLLeKkCy4sa9TYJ1IMPDFMNVO0VF1xgqYCM="),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: blogTitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    random,
                    maxLines: null,
                    overflow: TextOverflow.fade,
                    style: blogDescriptionStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
