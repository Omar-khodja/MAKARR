import 'package:flutter/material.dart';

class ProfileHead extends StatelessWidget {
  const ProfileHead({super.key, required this.name, required this.city});
  final String name;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
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
            style: const TextStyle(color: Colors.white, fontWeight: .w700),
          ),
          subtitle: Text(city, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
