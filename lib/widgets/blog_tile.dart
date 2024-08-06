import 'package:blogapp/utils/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatefulWidget {
  final String title;
  final String description;
  final String authorName;
  final String authorImageUrl;
  final String imageUrl;
   const BlogTile({super.key, required this.title, required this.description, required this.authorName, required this.authorImageUrl, required this.imageUrl});

  @override
  State<BlogTile> createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              height: 100,
              width: 150,
              fit: BoxFit.cover,
              imageUrl: widget.imageUrl,
            ),
            // child: Image.network(
            //     height: 100,
            //     width: 150,
            //     fit: BoxFit.cover,
            //     widget.imageUrl),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: blogTitleStyle,
                ),
                Text(
                  widget.description,
                  maxLines: 4,
                  overflow: TextOverflow.fade,
                  style: blogDescriptionStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                 Row(
                  children: [
                     CircleAvatar(
                      backgroundImage: NetworkImage(widget.authorImageUrl),
                      radius: 10,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.authorName)
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
