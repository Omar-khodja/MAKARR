import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/applogger/appLogger.dart';
import 'package:makarr/core/component/outLineButton.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/feature/Home/presentation/component/Image_card.dart';
import 'package:makarr/feature/Home/presentation/component/user_card_info.dart';
import 'package:makarr/feature/Home/presentation/controler/addPostNotifire.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/presentation/screen/pdfViewer.dart';
import 'package:makarr/feature/auth/presentation/component/custom_dropbox.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';

class AddPost extends ConsumerStatefulWidget {
  const AddPost({super.key});

  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}

class _AddPostState extends ConsumerState<AddPost> {
  final TextEditingController _des = TextEditingController();
  final TextEditingController _question = TextEditingController();
  final List<TextEditingController> _optionCtrls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final _formkey1 = GlobalKey<FormState>();

  final PageController _pageController = PageController();
  int currentpage = 0;
  String? selectedWilaya = "Adrar";
  String? selectedBladya = "Aoulef";
  @override
  void dispose() {
    _pageController.dispose();
    _des.dispose();
    _question.dispose();
    for (var ctrl in _optionCtrls) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void submit(AddpostnotifireState state, AddPostNotifire ref, UserNav user) {
    if (_formkey1.currentState!.validate()) {
      if (selectedBladya == null || selectedWilaya == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please select a location",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        return;
      }

      ref.savePost(
        user: user,
        des: _des.text.trim(),
        location: "$selectedWilaya - $selectedBladya",
        question: _question.text.trim(),
        options: _optionCtrls.map((ctrl) => ctrl.text.trim()).toList(),
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
        key: _formkey1,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              currentpage = index;
            });
          },
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    UserCardInfo(
                      name:
                          "${userState.value!.fname} ${userState.value!.lname}",
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
                          return 'Description cannot be empty';
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
                      label: "Next",
                      fun: () => _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      isLoading: state.isLoading,
                      tailIcon: Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _question,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Question?",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Question cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _optionCtrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: TextFormField(
                            controller: _optionCtrls[index],
                            decoration: InputDecoration(
                              labelText: "Option ${index + 1}",
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      OutLineButton(
                        fun: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        leadIcon: Icons.arrow_back_ios,
                        text: "Back",
                      ),
                      PrimaryButton(
                        fun: () => submit(state, notifier, userState.value!),
                        label: "Post",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
