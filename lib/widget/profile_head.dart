import 'package:flutter/material.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({super.key, required this.name, required this.city});
  final String name;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      clipBehavior: .antiAlias,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const CircleAvatar(radius: 40, child: null),
          title: Text(
            name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: .w700,
            ),
          ),
          subtitle: Text(
            city,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
