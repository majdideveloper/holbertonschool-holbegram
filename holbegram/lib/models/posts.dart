class Post {
  String caption;
  String uid;
  String username;
  List<dynamic> likes;
  String postId;
  DateTime datePublished;
  String postUrl;
  String profImage;

  Post({
    required this.caption,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      caption: json['caption'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      likes: json['likes'] as List<dynamic>,
      postId: json['postId'] as String,
      datePublished: DateTime.parse(json['datePublished'] as String),
      postUrl: json['postUrl'] as String,
      profImage: json['profImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'uid': uid,
      'username': username,
      'likes': likes,
      'postId': postId,
      'datePublished': datePublished.toIso8601String(),
      'postUrl': postUrl,
      'profImage': profImage,
    };
  }
}
