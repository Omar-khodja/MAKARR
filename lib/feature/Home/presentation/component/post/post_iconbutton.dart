import 'package:flutter/material.dart';

class PostIconbutton extends StatelessWidget {
  const PostIconbutton({
    super.key,
    required this.icon,
    this.counter,
     this.active = false,
    required this.onPressed,
  });
  final IconData icon;
  final int? counter;
  final bool active;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(
        children: [
          active ? Icon(icon, color: Colors.red) : Icon(icon),
          const SizedBox(width: 5),
          if (counter != null) Text("$counter"),
        ],
      ),
    );
  }
}
