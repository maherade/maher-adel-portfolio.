import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;

import 'package:unping_task/generated/assets.dart';

/// Downloads the CV PDF from assets.
/// On web: triggers a browser file download.
/// On other platforms: falls back to no-op (extend as needed).
Future<void> downloadCv() async {
  if (kIsWeb) {
    final data = await rootBundle.load('assets/files/maher_adel_flutter.pdf');
    final bytes = data.buffer.asUint8List();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', 'Maher_Adel_CV.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
