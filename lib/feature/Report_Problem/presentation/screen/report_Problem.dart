import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:makarr/core/component/Custom_elevatedButton.dart';
import 'package:makarr/core/component/coustom_elevatedbutton.dart';
import 'package:makarr/core/component/primaryButton.dart';
import 'package:makarr/feature/Home/presentation/component/user_card_info.dart';
import 'package:makarr/feature/Report_Problem/domain/entities/report.dart';
import 'package:makarr/feature/Report_Problem/presentation/component/image_container.dart';
import 'package:makarr/feature/Report_Problem/presentation/component/location_component.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/image_provider.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/locarion_provider.dart';
import 'package:makarr/core/controler/userNotifire.dart';
import 'package:makarr/feature/Report_Problem/presentation/controler/report_Provider.dart';
import 'package:makarr/feature/profile/domain/entities/user_nav.dart';

class ReportProblem extends ConsumerStatefulWidget {
  const ReportProblem({super.key});

  @override
  ConsumerState<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends ConsumerState<ReportProblem> {
  late final ImageNotifier imageProvider;
  late final LocationNotifier locationProvider;
  late final Reportnotifire reportProvider;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _des = TextEditingController();
  final TextEditingController _title = TextEditingController();
  @override
  void initState() {
    super.initState();
    reportProvider = ref.read(reportNotifireProvider.notifier);
    locationProvider = ref.read(locationNotifierProvider.notifier);
    imageProvider = ref.read(imageNotifierProvider.notifier);
  }

  @override
  void dispose() {
    _des.dispose();
    _title.dispose();
    super.dispose();
  }

  void _submit(UserNav user) async {
    final bool isValid = _formkey.currentState!.validate();
    final location = ref.read(locationNotifierProvider);
    final images = ref.read(imageNotifierProvider);
    if (!isValid) return;
    if (location.value == null || location.value!.isEmpty) {
      Fluttertoast.showToast(msg: "you have to insert Location");
      return;
    }
    if (images.value == null || images.value!.isEmpty) {
      Fluttertoast.showToast(msg: "you have to insert Images");
      return;
    }
    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd').format(now);
    final isDone = await reportProvider.setReport(
      Report(
        userId: user.id,
        userName: '${user.fname} ${user.lname}',
        userprofile: user.imagUrl,
        titel: _title.text,
        discreption: _des.text,
        date: formatted,
        lat: location.value!["lat"].toString(),
        lng: location.value!["lng"].toString(),
        address: location.value!["formatted"],
        images: images.value!,
      ),
    );
    if (isDone) {
      _des.text = "";
      _title.text = "";
      locationProvider.emptyState();
      imageProvider.emptyState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifireProvider);
    final report = ref.watch(reportNotifireProvider);

    return report.when(
      data: (data) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 16,
            vertical: 50,
          ),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              UserCardInfo(
                name: "${user.value!.fname} ${user.value!.lname}",
                imageUrl: user.value!.imagUrl,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _title,
                      decoration: InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "You have to insert title ";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _des,
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Describe the issue...",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Describtion can not be empty";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const LocationComponent(),
              const SizedBox(height: 12),

              const ImageContainer(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: .spaceEvenly,

                children: [
                  CustomElevatedbutton(
                    label: 'Photo',
                    leadIcon: Icons.photo_library_outlined,
                    fun: imageProvider.pickImage,
                  ),
                  CoustomElevatedbutton(
                    label: "Get Current location",
                    fun: locationProvider.getCurrentLocation,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              PrimaryButton(
                label: "Send Reporet",
                fun: () => _submit(user.value!),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text("Just Seconde..."),
        ],
      ),
    );
  }
}
