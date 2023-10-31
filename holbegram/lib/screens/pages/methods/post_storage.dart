import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';

class PostStorage {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      final String postUrl =
          await StorageMethods().uploadImageToStorage(true, "posts", image);
      Post post = Post(
          caption: caption,
          uid: uid,
          username: username,
          likes: [],
          postId: uid,
          datePublished: DateTime.now(),
          postUrl: postUrl,
          profImage: profImage);

      await _firestore.collection("posts").doc(post.uid).set(post.toJson());
      return "ok";
    } catch (error) {
      return error.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
    } catch (error) {
      print('Error deleting post: $error');
    }
  }
}
