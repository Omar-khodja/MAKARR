import 'package:flutter/material.dart';

class PostIconbutton extends StatelessWidget {
  const PostIconbutton({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Row(
        children: [Icon(icon), const SizedBox(width: 5), const Text("24")],
      ),
    );
  }
}
