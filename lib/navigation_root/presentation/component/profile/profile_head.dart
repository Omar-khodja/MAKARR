import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/navigation_root/presentation/controler/userNotifire.dart';

class ProfileHead extends ConsumerWidget {
  const ProfileHead({
    super.key,
    required this.name,
    required this.city,
    required this.imageUrl,
  });
  final String name;
  final String city;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateImage = ref.read(userNotifireProvider.notifier);

    final darktheme = Theme.of(context).brightness == Brightness.dark;
    return Card(
      color: darktheme
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15),
      ),
      clipBehavior: .antiAlias,
      elevation: 5,

      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: null,
          backgroundImage: imageUrl.isEmpty
              ? const AssetImage("assets/image/noprofilel.png")
              : NetworkImage(imageUrl) as ImageProvider,
        ),
        title: Text(
          name,
          style: TextStyle(
            color: darktheme
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimary,
            fontWeight: .w700,
          ),
        ),
        subtitle: Text(
          city,
          style: TextStyle(
            color: darktheme
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        trailing: IconButton(
          onPressed: () => _showImageOptions(context, updateImage),
          icon: const Icon(Icons.edit),
        ),
      ),
    );
  }

  void _showImageOptions(BuildContext context, UserNotofire updateImage) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    AppLogger.i(userid);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text("Take a photo"),
                onTap: () => updateImage.updateProfileImage(userid, "camera"),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text("Pick from gallery"),
                onTap: () => updateImage.updateProfileImage(userid, "gallery"),
              ),
            ],
          ),
        );
      },
    );
  }
}
