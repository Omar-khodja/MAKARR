import 'package:flutter/material.dart';

class PostUserInfo extends StatelessWidget {
  const PostUserInfo({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.time,
  });
  final String username;
  final String imageUrl;
  final DateTime time;

  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return 'just now';
    } else if (diff.inMinutes < 60) {
      return '${diff.inMinutes} min ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final darcktheme = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 10, horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            CircleAvatar(
              radius: 25,
              foregroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: .w700,
                    color: darcktheme ? Colors.white : Colors.black54,
                  ),
                ),
                Text(
                  timeAgo(time),
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
