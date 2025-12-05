import 'package:flutter/material.dart';

class UserCardInfo extends StatelessWidget {
  const UserCardInfo({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(radius: 30, backgroundColor: Colors.white),
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
