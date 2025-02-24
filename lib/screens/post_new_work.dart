import 'package:flutter/material.dart';

class PostNewWorkPage extends StatelessWidget {
  const PostNewWorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post New Work"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text("Upload Your Work Here"),
      ),
    );
  }
}
