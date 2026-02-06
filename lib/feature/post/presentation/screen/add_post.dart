import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/component/Custom_elevatedButton.dart';
import 'package:makarr/feature/post/presentation/component/Image_card.dart';
import 'package:makarr/feature/post/presentation/component/user_card_info.dart';
import 'package:makarr/feature/post/presentation/controler/addPostNotifire.dart';
import 'package:makarr/feature/navigation_root/presentation/controler/userNotifire.dart';
import 'package:makarr/feature/post/presentation/screen/pdfViewer.dart';

class AddPost extends ConsumerStatefulWidget {
  const AddPost({super.key});

  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}

class _AddPostState extends ConsumerState<AddPost> {
  final TextEditingController _des = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  void submit(
    AddpostnotifireState state,
    AddPostNotifire ref,
    UserNotifireState user,
  ) {
    if (_formkey.currentState!.validate()) {
      AppLogger.i(state.pdf.toString());
      if (state.imageFile.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You must add  an image",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        return;
      } else if (state.pdf != null && state.pdf!.path.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "You must add  an Pdf",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        return;
      }
      ref.savePost(user.user, _des.text.trim());
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userNotifireProvider);
    final notifier = ref.read(addPostNotifireProvider.notifier);
    final state = ref.watch(addPostNotifireProvider);
    showSnackBar();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Post"),
        actions: [
          IconButton(
            onPressed: () => submit(state, notifier, user),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            children: [
              UserCardInfo(
                name: "${user.user.fname} ${user.user.lname}",
                imageUrl: user.user.imagUrl,
              ),
              const SizedBox(height: 10),
              Form(
                key: _formkey,
                child: TextFormField(
                  controller: _des,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "What's on your mind, ${user.user.fname}?",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: state.imageFile.map((file) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 60) / 2,
                    height: 150,
                    child: ImageCard(
                      image: file,
                      onDelete: () => notifier.removeImage(file),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              if (state.pdf != null && state.pdf!.path.isNotEmpty)
                ListTile(
                  leading: const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.red,
                    size: 30,
                  ),
                  title: Text(state.pdf!.path.split('/').last),
                  trailing: IconButton(
                    onPressed: () => notifier.removePdf(),
                    icon: const Icon(Icons.close),
                  ),
                  onTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Pdfviewer(file: state.pdf!),
                      ),
                    ),
                  },
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: .spaceAround,
                crossAxisAlignment: .center,
                children: [
                  CustomElevatedbutton(
                    label: 'Photo',
                    leadIcon: Icons.photo_library_outlined,
                    fun: notifier.pickImages,
                  ),
                  CustomElevatedbutton(
                    label: 'pdf',
                    leadIcon: Icons.photo_library_outlined,
                    fun: notifier.pickPdfFile,
                    isLoading: state.isLoading,
                  ),
                ],
              ),
            ],
          ),
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

  @override
  void dispose() {
    _des.dispose();
    super.dispose();
  }
}
