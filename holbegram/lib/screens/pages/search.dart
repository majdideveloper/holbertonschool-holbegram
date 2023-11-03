import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/widgets/text_field.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searcchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFieldInput(
          prefixIcon: Icon(Icons.search),
          controller: searcchController,
          isPassword: false,
          hintText: "search",
          keyboardType: TextInputType.none,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error!);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          return GridView.custom(
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: [
                const QuiltedGridTile(4, 4),
                const QuiltedGridTile(2, 2),
                const QuiltedGridTile(2, 2),
              ],
            ),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                final document = snapshot.data!.docs[index];
                final itemData = document.data() as Map<String, dynamic>;
                final Post post = Post.fromJson(itemData);
                return Container(
                  child: Image.network(
                    post.postUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
              childCount: snapshot.data!.docs.length,
            ),
          );
        },
      ),
    );
  }
}
