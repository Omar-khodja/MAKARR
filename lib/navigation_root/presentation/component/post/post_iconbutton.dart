import 'package:flutter/material.dart';

class PostIconbutton extends StatelessWidget {
  const PostIconbutton({super.key, required this.icon, this.counter});
  final IconData icon;
  final int? counter;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          if (counter != null) Text("$counter"),
        ],
      ),
    );
  }
}
