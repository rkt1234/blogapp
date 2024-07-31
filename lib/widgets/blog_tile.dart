import 'package:blogapp/utils/constants.dart';
import 'package:blogapp/utils/text_style.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatefulWidget {
  const BlogTile({super.key});

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
                height: 100,
                width: 150,
                fit: BoxFit.cover,
                "https://media.gettyimages.com/id/1492656400/photo/chennai-india-mahendra-singh-dhoni-of-chennai-super-kings-catches-their-helmet-whilst.jpg?s=612x612&w=gi&k=20&c=JbYno-lPxLLeKkCy4sa9TYJ1IMPDFMNVO0VF1xgqYCM="),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: blogTitleStyle,
                ),
                Text(
                  random,
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                  style: blogDescriptionStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Author")
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
