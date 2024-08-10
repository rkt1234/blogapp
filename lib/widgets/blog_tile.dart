import 'package:blogapp/utils/text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

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
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 350,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: widget.imageUrl,
                cacheManager: DefaultCacheManager(),
              ),
            ),
          ),
          
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: blogTitleStyle,
          ),
          SizedBox(height: 20,),
          Text(
            widget.description,
            maxLines: 4,
            overflow: TextOverflow.fade,
            style: blogDescriptionStyle,
          ),
          SizedBox(height: 10,),
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
          ),
          Divider()

        ],
      ),
    );
  }
}
