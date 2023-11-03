import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatelessWidget {
  Favorite({super.key});

  List<dynamic> postsIds = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    postsIds = userProvider.user!.saved;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Favorite",
          style: TextStyle(
            fontFamily: "Billabong",
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final posts = snapshot.data;

          if (posts!.isEmpty) {
            return Center(child: Text('No posts available.'));
          }

          // Use ListView.builder to create a dynamic list view of specific posts
          // return ListView.builder(
          //   itemCount: posts.length,
          //   itemBuilder: (context, index) {
          //     final Post post = Post.fromSnap(posts[index]);

          //     return ListTile(
          //       title: Text(post.caption),
          //       subtitle: Text(post.username),
          //     );
          //   },
          // );
          return ListView.separated(
            itemCount: posts.length,
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: 10,
              );
            }),
            itemBuilder: (context, index) {
              final Post post = Post.fromSnap(posts[index]);
              return Image.network(
                post.postUrl,
                height: 300,
                fit: BoxFit.cover,
              );
            },
          );
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> getPosts() async {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('posts');

    // Query Firestore to fetch specific posts by their IDs
    final query = collection.where(FieldPath.documentId, whereIn: postsIds);
    final querySnapshot = await query.get();

    return querySnapshot.docs;
  }
}
