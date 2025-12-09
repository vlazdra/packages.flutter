import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:pdfx/src/renderer/interfaces/platform.dart';
import 'package:pdfx/src/renderer/web/pdfjs.dart';
import 'platform.dart';

class PdfxPlugin {
  static void registerWith(Registrar registrar) {
    // Only register the web platform if pdf.js is available
    // Otherwise, the stub implementation will be used via the platform selector
    if (checkPdfjsLibInstallation()) {
      PdfxPlatform.instance = PdfxWeb();
    }
    // If pdf.js is not installed, we don't set the instance
    // and the default stub adapter will be used instead
  }
}
