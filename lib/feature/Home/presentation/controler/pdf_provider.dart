import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PdfNotifire extends StateNotifier<AsyncValue<File?>> {
  PdfNotifire() : super(const AsyncValue.data(null));
  Future<void> pickPdfFile() async {
    try {
      state = const AsyncValue.loading();
      final xFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      if (xFile == null) {
        state = const AsyncValue.data(null);
        return;
      }

      final file = File(xFile.files.first.path!);
      state = AsyncValue.data(file);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An error occurred while picking the PDF file.",
      );
    }
  }
   Future<void> removePdf() async {
    state = const AsyncValue.data(null);
  }
}
final pdfNotifireProvider = StateNotifierProvider((ref) => PdfNotifire(),);
