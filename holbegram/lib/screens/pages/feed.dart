import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Holbegram",
            style: TextStyle(fontFamily: "Billabong"),
          ),
        ),
        body: Container() //Posts(),
        );
  }
}
