import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/domain/entities/opinion.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/presentation/controler/opinion_provider_nitifire.dart';

class GiveOpinion extends ConsumerStatefulWidget {
  const GiveOpinion({super.key, required this.post});
  final Post post;

  @override
  ConsumerState<GiveOpinion> createState() => _GiveOpinionState();
}

class _GiveOpinionState extends ConsumerState<GiveOpinion> {
  String comment = "";
  String? selectedOption = "";

  void submit() async {
    final user = ref.read(userNotifireProvider);
    final bool result = await ref
        .read(opinionProvider.notifier)
        .setOpinion(
          Opinion(
            postId: widget.post.id!,
            opinion: selectedOption!,
            userId: user.value!.id,
            postLocation: widget.post.location,
            userProfile: user.value!.imagUrl,
            question: widget.post.question,

            comment: comment,
          ),
        );
    if (result) {
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Give Your Opinion")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "${widget.post.question} ?",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            RadioGroup<String>(
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
              child: Column(
                children: widget.post.option!.map((option) {
                  if (option != "") {
                    return RadioListTile<String>(
                      value: option!,
                      title: Text(option),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                hintText: "Additional Comments",
                border: OutlineInputBorder(),
              ),
              maxLength: 200,

              maxLines: 4,
              onChanged: (value) => setState(() {
                comment = value;
              }),
            ),

            const SizedBox(height: 20),
            PrimaryButton(fun: submit, label: "Submit"),
          ],
        ),
      ),
    );
  }
}
