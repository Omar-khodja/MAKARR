import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdfviewer extends StatelessWidget {
  const Pdfviewer({super.key, this.file, this.pdfUrl});
  final File? file;
  final String? pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: file != null
          ? SfPdfViewer.file(file!)
          : Center(child: SfPdfViewer.network(pdfUrl!)),
    );
  }
}
