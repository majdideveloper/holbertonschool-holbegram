import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'methods/post_storage.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final TextEditingController captionController = TextEditingController();
  Uint8List? _image;

  // void selectImageFromGallery() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     final bytes = await image.readAsBytes();
  //     setState(() {
  //       _image = bytes;
  //     });
  //   }
  // }

  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _image = bytes;
      });
    } else {
      print('No image selected');
    }
  }

  void _showImageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text('Select an Image Source'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                _selectImage(ImageSource.gallery); // Select from gallery
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {
                _selectImage(ImageSource.camera); // Capture from camera
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Camera'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Image",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  final String res = await PostStorage().uploadPost(
                      captionController.text,
                      userProvider.user!.uid,
                      userProvider.user!.username,
                      userProvider.user!.photoUrl,
                      _image!);
                  if (res == "Ok") {
                    userProvider.refreshUser();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      ((route) => false),
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Add Image",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Choose an image from your gallery or take a one.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: captionController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
              hintText: "Write a caption...",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _showImageSelectionDialog(context);
            },
            //selectImageFromGallery,
            child: _image == null
                ? Image.asset(
                    "assets/images/add.png",
                    width: 200,
                    height: 200,
                  )
                : Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(_image!) // XFileImage(_image!),
                          ),
                    )),
          ),
        ],
      ),
    );
  }
}
