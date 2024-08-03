class Blog {
  final int postId;
  final String title;
  final String description;
  final String createdTime;
  final String imageUrl;
  final int userId;

  Blog({
    required this.postId,
    required this.title,
    required this.description,
    required this.createdTime,
    required this.imageUrl,
    required this.userId,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      postId: json['postid'],
      title: json['title'],
      description: json['description'],
      createdTime: json['createdtime'],
      imageUrl: json['imageurl'],
      userId: json['userid'],
    );
  }
}
