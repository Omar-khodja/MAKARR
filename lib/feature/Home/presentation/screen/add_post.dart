import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/component/outLineButton.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/feature/Home/presentation/component/Image_card.dart';
import 'package:makarr/feature/Home/presentation/component/user_card_info.dart';
import 'package:makarr/feature/Home/presentation/controler/addPost_notifire.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/presentation/screen/add_question_option.dart';
import 'package:makarr/feature/Home/presentation/screen/pdfViewer.dart';
import 'package:makarr/feature/auth/presentation/component/custom_dropbox.dart';

class AddPost extends ConsumerStatefulWidget {
  const AddPost({super.key});

  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}

class _AddPostState extends ConsumerState<AddPost> {
  final TextEditingController _des = TextEditingController();
  final TextEditingController _title = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  int currentpage = 0;
  String selectedWilaya = "Adrar";
  String selectedBladya = "Aoulef";
  final List<String> whoCanSee = ["Client", "Investor"];
  String selectedPublish = "Client";
  @override
  void dispose() {
    _des.dispose();
    _title.dispose();

    super.dispose();
  }

  void submitClient(AddpostnotifireState state) {
    if (_formkey.currentState!.validate()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddQuestionOption(
            selectedBladya: selectedBladya,
            selectedWilaya: selectedWilaya,
            des: _des.value.text,
            title: _title.value.text,
            selectedPublish: selectedPublish,
          ),
        ),
      );
    }
    return;
  }

  void submitinvestor(AddpostnotifireState state) {
    if (_formkey.currentState!.validate()) {
      final user = ref.read(userNotifireProvider);

      ref
          .watch(addPostNotifireProvider.notifier)
          .savePost(
            user: user.value!,
            des: _des.text.trim(),
            title: _title.text.trim(),
            location: "$selectedWilaya - $selectedBladya",
            setPostFor: selectedPublish,
          );
      Navigator.of(context).pop();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.read(userNotifireProvider);
    final notifier = ref.read(addPostNotifireProvider.notifier);
    final state = ref.watch(addPostNotifireProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Add Post")),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Column(
              children: [
                UserCardInfo(
                  name: "${userState.value!.fname} ${userState.value!.lname}",
                  imageUrl: userState.value!.imagUrl,
                ),
                const SizedBox(height: 10),
                CustomDropbox(
                  onChange: (w, b) {
                    selectedBladya = b;
                    selectedWilaya = w;
                    AppLogger.i(
                      "Selected location: $selectedWilaya - $selectedBladya",
                    );
                  },
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  initialValue: selectedPublish,
                  decoration: const InputDecoration(
                    label: Text("this post is for:"),
                  ),
                  items: whoCanSee.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPublish = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _title,
                  decoration: InputDecoration(
                    labelText: "Project name",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 15) {
                      return 'Name cannot be empty or less than 15 latter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: _des,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText:
                        "What's on your mind, ${userState.value!.fname}?",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty or less than 15 latter';
                    }
                    return null;
                  },
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
                    OutLineButton(
                      text: 'Photo',
                      leadIcon: Icons.photo_library_outlined,
                      fun: notifier.pickImages,
                    ),
                    OutLineButton(
                      text: 'pdf',
                      leadIcon: Icons.photo_library_outlined,
                      fun: notifier.pickPdfFile,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: selectedPublish == "Client" ? "Next" : "Post",
                  fun: () => selectedPublish == "Client"
                      ? submitClient(state)
                      : submitinvestor(state),

                  tailIcon: selectedPublish == "Client"
                      ? Icons.arrow_forward_ios
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
