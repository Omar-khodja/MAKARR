import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.title,
    required this.data,
    required this.icon,
  });
  final String title;
  final String? data;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(data ?? "Unkown"),
      ),
    );
  }
}
