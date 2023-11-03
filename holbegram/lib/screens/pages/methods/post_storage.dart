import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:uuid/uuid.dart';

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
      String id = const Uuid().v1();
      final String postUrl =
          await StorageMethods().uploadImageToStorage(true, "posts", image);
      Post post = Post(
          caption: caption,
          uid: id,
          username: username,
          likes: [],
          postId: uid,
          datePublished: DateTime.now(),
          postUrl: postUrl,
          profImage: profImage);

      await _firestore.collection("posts").doc(post.uid).set(post.toJson());
      await _firestore.collection("users").doc(uid).update({
        'posts': FieldValue.arrayUnion([id]),
      });
      return "Ok";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> addToFavorite({
    required String idPost,
    required String idUser,
  }) async {
    try {
      print(idPost);
      print(idUser);
      await _firestore.collection("users").doc(idUser).update({
        'saved': FieldValue.arrayUnion([idPost]),
      });
      return "OK";
    } catch (error) {
      print('Error deleting post: $error');
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
