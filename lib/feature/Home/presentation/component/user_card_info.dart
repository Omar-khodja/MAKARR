import 'package:flutter/material.dart';

class UserCardInfo extends StatelessWidget {
  const UserCardInfo({super.key, required this.name, required this.imageUrl});
  final String name;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final hasValidImageUrl = imageUrl.trim().isNotEmpty;

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: hasValidImageUrl ? Colors.transparent : Colors.grey,
        backgroundImage: hasValidImageUrl
            ? NetworkImage(imageUrl)
            : const AssetImage("assets/image/noprofilel.png"),
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
