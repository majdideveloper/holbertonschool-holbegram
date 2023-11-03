import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/auth/login_screen.dart';
import 'package:holbegram/utils/posts.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  List<dynamic> postsIds = [];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    postsIds = userProvider.user!.posts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Billabong",
            fontSize: 30,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () async {
                  final res = await AuthMethods().logout();
                  if (res == "Ok") {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      ((route) => false),
                    );
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          userProvider.user!.photoUrl,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userProvider.user!.username,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  TextNumber(
                      text: "posts", number: userProvider.user!.posts.length),
                  TextNumber(
                      text: "followers",
                      number: userProvider.user!.follwers.length),
                  TextNumber(
                      text: "following",
                      number: userProvider.user!.follwing.length),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          SizedBox(
            height: 300,
            child: FutureBuilder(
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final Post post = Post.fromSnap(posts[index]);
                    return Image.network(
                      post.postUrl,
                      fit: BoxFit.cover,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget TextNumber({required String text, required int number}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(text),
      ],
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
