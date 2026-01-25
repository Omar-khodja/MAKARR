import 'package:flutter/material.dart';

class UserCardInfo extends StatelessWidget {
  const UserCardInfo({super.key, required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: imageUrl.isEmpty ? Colors.grey : Colors.transparent,
        backgroundImage: imageUrl.isEmpty ? null : NetworkImage(imageUrl),
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: .w700,
        ),
      ),
    );
  }
}
