import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/component/outLineButton.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/presentation/controler/addPost_provider.dart';

class AddQuestionOption extends ConsumerStatefulWidget {
  const AddQuestionOption({
    super.key,
    required this.selectedBladya,
    required this.selectedWilaya,
    required this.selectedPublish,
    required this.des,
    required this.title,
  });
  final String selectedWilaya;
  final String selectedBladya;
  final String selectedPublish;
  final String des;
  final String title;
  @override
  ConsumerState<AddQuestionOption> createState() => _AddQuestionOptionState();
}

class _AddQuestionOptionState extends ConsumerState<AddQuestionOption> {
  final TextEditingController _question = TextEditingController();
  final List<TextEditingController> _optionCtrls = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _question.dispose();
    for (var i in _optionCtrls) {
      i.dispose();
    }
    super.dispose();
  }

  void submit() {
    if (_formkey.currentState!.validate()  ) {
      final user = ref.read(userNotifireProvider);
      ref.watch(addPostNotifireProvider.notifier)
          .savePost(
            user: user.value!,
            des: widget.des.trim(),
            title: widget.title.trim(),
            location: "${widget.selectedWilaya} - ${widget.selectedBladya}",
            question: _question.text.trim(),
            options: _optionCtrls.map((ctrl) => ctrl.text.trim()).toList(),
            setPostFor: widget.selectedPublish,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
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
                      Navigator.of(context).pop();
                    },
                    leadIcon: Icons.arrow_back_ios,
                    text: "Back",
                  ),
                  PrimaryButton(fun: submit, label: "Post"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
