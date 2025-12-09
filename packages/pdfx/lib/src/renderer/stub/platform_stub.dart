import 'dart:async';
import 'dart:typed_data';

import 'package:pdfx/src/renderer/interfaces/document.dart';
import 'package:pdfx/src/renderer/stub/document_stub.dart';

/// Stub implementation of PdfxPlatform for unsupported platforms.
/// Returns empty/no-op documents silently.
class PdfxPlatformStub {
  /// Returns a stub document with 0 pages.
  Future<PdfDocument> openFile(String filePath, {String? password}) async {
    return PdfDocumentStub.empty('file:$filePath');
  }

  /// Returns a stub document with 0 pages.
  Future<PdfDocument> openAsset(String name, {String? password}) async {
    return PdfDocumentStub.empty('asset:$name');
  }

  /// Returns a stub document with 0 pages.
  Future<PdfDocument> openData(FutureOr<Uint8List> data,
      {String? password}) async {
    return PdfDocumentStub.empty('memory:binary');
  }
}

/// Creates a stub platform instance.
/// This is called from platform_selector.dart when no supported platform is available.
/// Returns dynamic to match the IO platform selector signature.
dynamic createPlatformInstance() => PdfxPlatformStub();

