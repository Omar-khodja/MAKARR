import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makarr/feature/Home/presentation/component/post/postCarousel.dart';
import 'package:makarr/feature/Home/presentation/component/post/post_user_info.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';

class ReportComponent extends ConsumerStatefulWidget {
  const ReportComponent({super.key, required this.report});
  final Report report;

  @override
  ConsumerState<ReportComponent> createState() => _ReportComponentState();
}

class _ReportComponentState extends ConsumerState<ReportComponent> {
  CarouselController carouselController = CarouselController();
  @override
  void dispose() {
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            PostUserInfo(
              username: widget.report.userName,
              imageUrl: widget.report.userprofile,
              time: DateTime.parse(widget.report.date),
            ),
            const SizedBox(height: 8),
            Text(
              widget.report.titel,
              style: const TextStyle(fontSize: 20, fontWeight: .bold),
            ),
            const SizedBox(height: 8),
            Text(widget.report.discreption),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: PostCarousel(
                controller: carouselController,
                images: widget.report.imagesUrl!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
