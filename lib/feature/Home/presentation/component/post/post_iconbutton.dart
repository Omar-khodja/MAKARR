import 'package:flutter/material.dart';

class PostIconbutton extends StatelessWidget {
  const PostIconbutton({
    super.key,
    required this.icon,
    this.counter,
    this.active = false,
    this.label,
    required this.onPressed,
  });
  final IconData icon;
  final int? counter;
  final bool active;
  final String? label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Row(

        children: [
          if (label != null) Text(label!),
          const SizedBox(width: 5),
          active ? Icon(icon, color: Colors.red) : Icon(icon),
          const SizedBox(width: 5),
          if (counter != null) Text("$counter"),
        ],
      ),
    );
  }
}
