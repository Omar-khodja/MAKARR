import 'package:flutter/material.dart';

class PostUserInfo extends StatelessWidget {
  const PostUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/image/noprofilel.png"),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(
                    fontWeight: .w700,
                    color: darcktheme ? Colors.white : Colors.black54,
                  ),
                ),
                Text(
                  "2 hours ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: darcktheme ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
