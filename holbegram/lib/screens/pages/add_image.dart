import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/home.dart';
import 'package:image_picker/image_picker.dart';

import 'methods/post_storage.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _image = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Image"),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  final String res = await PostStorage()
                      .uploadPost("caption", "", "majdi", "profImage", _image!);
                  if (res == "Ok") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Post",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Billabong",
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Add Image"),
          Text("Choose an image from your gallery or take a one"),
          IconButton(
            onPressed: selectImageFromGallery,
            icon: const Icon(
              Icons.add,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
