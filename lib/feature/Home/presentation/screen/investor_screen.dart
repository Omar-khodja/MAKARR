import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Home/domain/entities/post.dart';
import 'package:makarr/feature/Home/presentation/component/post/post_card.dart';
import 'package:makarr/feature/Home/presentation/controler/Investment_notifire.dart';
import 'package:makarr/feature/Home/presentation/controler/get_post_notifire.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InvestorScreen extends ConsumerStatefulWidget {
  const InvestorScreen({super.key});

  @override
  ConsumerState<InvestorScreen> createState() => _InvestorScreenState();
}

class _InvestorScreenState extends ConsumerState<InvestorScreen> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    carouselController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final user = ref.read(userNotifireProvider);
      if (user.value == null) return;
      ref.read(investmentNotifireProvider.notifier).getInvestmentPost();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(investmentNotifireProvider);
    final user = ref.read(userNotifireProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(getPostNotifireProvider.notifier)
            .getPost("${user.value!.wilaya} - ${user.value!.bladya}");

        Fluttertoast.showToast(
          msg: "Reloading...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16,
        );
      },
      child: state.when(
        data: (data) {
          if (data.isEmpty) return const Center(child: Text("No post yet!!"));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final post = data[index];
                    return PostCard(
                      postType: "Investment",
                      userId: user.value!.id,
                      carouselController: carouselController,
                      post: post,
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => RefreshIndicator(
          onRefresh: () async {
            ref
                .read(getPostNotifireProvider.notifier)
                .getPost("${user.value!.wilaya} - ${user.value!.bladya}");

            Fluttertoast.showToast(
              msg: "Reloading...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              fontSize: 16,
            );
          },
          child: Center(child: Text(error.toString())),
        ),
        loading: () => Skeletonizer(
          enabled: true,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return PostCard(
                postType: "",
                userId: "",
                carouselController: carouselController,
                post: Post(
                  userId: "",
                  title: "",
                  username: "username",
                  userImageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/makarr-bc736.firebasestorage.app/o/profile_images%2FgW6AJ2U71dVXZOh7LdogxC3Tbfp2.jpg?alt=media&token=e761f634-a337-4285-ba18-c10c5cfb5e89",
                  desciption:
                      "lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  time: DateTime.now(),
                  pdfName: "",
                  location: "${user.value!.wilaya} - ${user.value!.bladya}",
                  photosUrl: const [
                    "https://firebasestorage.googleapis.com/v0/b/makarr-bc736.firebasestorage.app/o/profile_images%2FgW6AJ2U71dVXZOh7LdogxC3Tbfp2.jpg?alt=media&token=e761f634-a337-4285-ba18-c10c5cfb5e89",
                  ],
                  question: "question ?",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
