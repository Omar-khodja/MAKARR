import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/component/Custom_elevatedButton.dart';
import 'package:makarr/navigation_root/presentation/component/Image_card.dart';
import 'package:makarr/navigation_root/presentation/component/user_card_info.dart';
import 'package:makarr/navigation_root/presentation/controler/addPostNotifire.dart';
import 'package:makarr/navigation_root/presentation/controler/userNotifire.dart';

class AddPost extends ConsumerStatefulWidget {
  const AddPost({super.key});

  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}

class _AddPostState extends ConsumerState<AddPost> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userNotifireProvider);
    final addpost = ref.read(addPostNotifireProvider.notifier);
    final notifire = ref.watch(addPostNotifireProvider);
    showSnackBar();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            UserCardInfo(
              name: "${user.user.fname} ${user.user.lname}",
              imageUrl: user.user.imagUrl,
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "What's on your mind, ${user.user.fname}?",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: notifire.imageFile.map((file) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  height: 150,
                  child: ImageCard(image: file, onDelete: () {}),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: .spaceAround,
              crossAxisAlignment: .center,
              children: [
                CustomElevatedbutton(
                  label: 'Photo',
                  leadIcon: Icons.photo_library_outlined,
                  fun: addpost.pickImages,
                ),
                CustomElevatedbutton(
                  label: 'PDF',
                  leadIcon: Icons.photo_library_outlined,
                  fun: addpost.pickImages,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSnackBar() {
    ref.listen(addPostNotifireProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    });
  }
}
