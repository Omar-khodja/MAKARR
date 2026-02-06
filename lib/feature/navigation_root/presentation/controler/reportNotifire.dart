import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:makarr/core/error/failure.dart';
import 'package:makarr/feature/navigation_root/domain/usecase/set_report_usecase.dart';
import 'package:makarr/feature/navigation_root/presentation/controler/navigation_provider.dart';

class ReportNotifireState {
  ReportNotifireState({
    required this.position,
    this.imageFile = const [],
    this.video,
    this.isLoading = false,
    this.error,
    this.isGettingLocation = false
  });
  final bool isLoading;
  final bool isGettingLocation;
  final String? error;
  final Map<String, dynamic> position;
  final List<File> imageFile;
  final String? video;
  ReportNotifireState copyWith({
    Map<String, dynamic>? position,
    bool? isLoading,
    String? error,
    List<File>? imageFile,
    String? video,
    bool? isGettingLocation

  }) {
    return ReportNotifireState(
      position: position ?? this.position,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      imageFile: imageFile ?? this.imageFile,
      video: video ?? this.video,
      isGettingLocation: isGettingLocation ?? this.isGettingLocation
    );
  }
}

class Reportnotifire extends StateNotifier<ReportNotifireState> {
  Reportnotifire({required this.setReport})
    : super(ReportNotifireState(position: {}));
  final SetReportUsecase setReport;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> gerCurrentLocation() async {
    state = state.copyWith(isGettingLocation: true);
    final Either<Failure, Map<String, dynamic>> result = await setReport
        .getCurrentLocation();
    result.fold(
      (l) => state = state.copyWith(error: l.message, isGettingLocation: false),
      (r) => state = state.copyWith(isGettingLocation: false, position: r, error: null),
    );
  }

  Future<void> pickImage() async {
    final xFiles = await _imagePicker.pickMultiImage(
      limit: 4,
      imageQuality: 80,
    );
    final totalImages = state.imageFile.length + xFiles.length;
    if (totalImages > 4) {
      state = state.copyWith(error: "You can only pick 4 images");
      return;
    }
    final newImages = xFiles.map((e) => File(e.path)).toList();
    state = state.copyWith(
      imageFile: [...state.imageFile, ...newImages],
      error: null,
    );
  }

  Future<void> deleteImage(File image) async {
    final images = state.imageFile;
    images.remove(image);
    state = state.copyWith(imageFile: images);
  }

  Future<void> pickVideo() async {
    final xFile = await _imagePicker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 60),
    );
    if (xFile != null) {
      state = state.copyWith(video: xFile.path);
    }
  }

  Future<void> deleteVideo() async {
    state = state.copyWith(video: null);
  }
}

final reportNotifireProvider =
    StateNotifierProvider<Reportnotifire, ReportNotifireState>(
      (ref) => Reportnotifire(setReport: ref.read(setReportUsecaseProvider)),
    );
