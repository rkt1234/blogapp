import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:flutter/material.dart';

/// A screen for viewing a blog post.
///
/// This screen displays the blog post's title, image, and description.
/// It also includes buttons for editing and deleting the post.
///
/// Example:
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(builder: (context) => ViewBlogScreen()),
/// );
/// ```
class ViewBlogScreen extends StatefulWidget {
  /// Creates a new instance of [ViewBlogScreen].
  const ViewBlogScreen({super.key});

  @override
  State<ViewBlogScreen> createState() => _ViewBlogScreenState();
}

class _ViewBlogScreenState extends State<ViewBlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(automaticallyImplyLeading: false,),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// A container for the blog post's metadata.

              /// The blog post's image.
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                      fit: BoxFit.cover,
                      "https://media.gettyimages.com/id/1492656400/photo/chennai-india-mahendra-singh-dhoni-of-chennai-super-kings-catches-their-helmet-whilst.jpg?s=612x612&w=gi&k=20&c=JbYno-lPxLLeKkCy4sa9TYJ1IMPDFMNVO0VF1xgqYCM="),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// The blog post's title.
              Text(
                "title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: blogTitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Created at"),
              const SizedBox(
                height: 10,
              ),

              /// The blog post's description.
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
