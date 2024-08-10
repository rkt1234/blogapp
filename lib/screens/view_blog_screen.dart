import 'package:blogapp/utils/configs.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  String title;
  String description;
  String blogImageUrl;
  String createdAt;
  /// Creates a new instance of [ViewBlogScreen].
   ViewBlogScreen({super.key, required this.title, required this.description, required this.blogImageUrl, required this.createdAt});

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
                  child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl:widget.blogImageUrl),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              /// The blog post's title.
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    widget.title,
                    maxLines: null,
                    overflow: TextOverflow.ellipsis,
                    style: blogTitleStyle,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Created at ${widget.createdAt}"),
              const SizedBox(
                height: 10,
              ),

              /// The blog post's description.
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    widget.description,
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
