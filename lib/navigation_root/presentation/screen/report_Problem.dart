import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/component/Custom_elevatedButton.dart';
import 'package:makarr/navigation_root/presentation/component/Image_card.dart';
import 'package:makarr/navigation_root/presentation/component/user_card_info.dart';
import 'package:makarr/navigation_root/presentation/controler/reportNotifire.dart';
import 'package:video_player/video_player.dart';

class ReportProblem extends ConsumerStatefulWidget {
  const ReportProblem({super.key});

  @override
  ConsumerState<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends ConsumerState<ReportProblem> {
  VideoPlayerController? _videoController;
  late final Reportnotifire notifireMethods;
  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    notifireMethods = ref.read(reportNotifireProvider.notifier);
  }

  void showSnackBar() {
    ref.listen(reportNotifireProvider, (previous, next) {
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

  @override
  Widget build(BuildContext context) {
    final notifire = ref.watch(reportNotifireProvider);
    showSnackBar();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 50,
        ),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            const UserCardInfo(name: "omar khodja"),
            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Describe the issue...",
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  8,
                ), // space between text and border
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // border color
                    width: 1, // border width
                  ),
                  borderRadius: BorderRadius.circular(8), // rounded corners
                ),
                child: Text(notifire.position["address"] ?? 'Current location'),
              ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: notifire.imageFile.map((file) {
                return SizedBox(
                  width: (MediaQuery.of(context).size.width - 60) / 2,
                  height: 180,
                  child: ImageCard(
                    image: file,
                    onDelete: () => notifireMethods.deleteImage(file),
                  ),
                );
              }).toList(),
            ),

            /*   if (notifire.video != null)
              VideoCard(
                videoPath: notifire.video!,
                onDelete: notifireMethods.deleteVideo,
              ),
 */
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: .spaceEvenly,

              children: [
                if (notifire.video == null)
                  CustomElevatedbutton(
                    label: 'Photo',
                    leadIcon: Icons.photo_library_outlined,
                    fun: notifireMethods.pickImage,
                  ),
                ElevatedButton(
                  onPressed: notifireMethods.gerCurrentLocation,
                  child: const Text("Get Current location"),
                ),
                /*     if (notifire.imageFile.isEmpty)
                  CustomElevatedbutton(
                    label: 'Video',
                    leadIcon: Icons.video_library_outlined,
                    fun: notifireMethods.pickVideo,
                  ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
