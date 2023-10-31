import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/pages/methods/post_storage.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data!.docs;

        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8),
            height: 540,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: data.map((post) {
                final postCaption = post['caption'];
                final postUrl = post['postUrl'];
                final profImage = post['profImage'];
                final username = post['username'];
                final postId = post['postId'];

                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(profImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(username),
                          Spacer(),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () async {
                              await PostStorage().deletePost(postId);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Post Deleted"),
                              ));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Text(postCaption),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(postUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
