import 'dart:typed_data';
import 'dart:ui';

import 'package:pdfx/src/renderer/interfaces/document.dart';
import 'package:pdfx/src/renderer/interfaces/page.dart';

/// Stub implementation of [PdfPage] for unsupported platforms.
class PdfPageStub extends PdfPage {
  PdfPageStub({
    required super.document,
    required super.pageNumber,
  }) : super(
          id: 'stub-page-$pageNumber',
          width: 0,
          height: 0,
          autoCloseAndroid: false,
        );

  @override
  Future<PdfPageImage?> render({
    required double width,
    required double height,
    PdfPageImageFormat format = PdfPageImageFormat.jpeg,
    String? backgroundColor,
    Rect? cropRect,
    int quality = 100,
    bool forPrint = false,
    bool removeTempFile = true,
  }) async {
    if (document.isClosed) {
      throw PdfDocumentAlreadyClosedException();
    }
    if (isClosed) {
      throw PdfPageAlreadyClosedException();
    }
    // Return a stub image with empty bytes
    return PdfPageImageStub(
      pageNumber: pageNumber,
      width: width.toInt(),
      height: height.toInt(),
      format: format,
      quality: quality,
    );
  }

  @override
  Future<PdfPageTexture> createTexture() async {
    return PdfPageTextureStub(
      pageId: id,
      pageNumber: pageNumber,
    );
  }

  @override
  Future<void> close() async {
    isClosed = true;
  }

  @override
  bool operator ==(Object other) =>
      other is PdfPageStub &&
      other.document.hashCode == document.hashCode &&
      other.pageNumber == pageNumber;

  @override
  int get hashCode => document.hashCode ^ pageNumber;
}

/// Stub implementation of [PdfPageImage] for unsupported platforms.
class PdfPageImageStub extends PdfPageImage {
  PdfPageImageStub({
    required super.pageNumber,
    required int width,
    required int height,
    required super.format,
    required super.quality,
  }) : super(
          id: 'stub-image-$pageNumber',
          width: width,
          height: height,
          bytes: Uint8List(0),
        );

  @override
  bool operator ==(Object other) =>
      other is PdfPageImageStub && other.pageNumber == pageNumber;

  @override
  int get hashCode => pageNumber;
}

/// Stub implementation of [PdfPageTexture] for unsupported platforms.
class PdfPageTextureStub extends PdfPageTexture {
  static int _idCounter = 0;

  PdfPageTextureStub({
    required super.pageId,
    required super.pageNumber,
  }) : super(id: ++_idCounter);

  @override
  int? get textureWidth => null;

  @override
  int? get textureHeight => null;

  @override
  bool get hasUpdatedTexture => false;

  @override
  Future<void> dispose() async {}

  @override
  Future<bool> updateRect({
    required String documentId,
    int destinationX = 0,
    int destinationY = 0,
    int? width,
    int? height,
    int sourceX = 0,
    int sourceY = 0,
    int? textureWidth,
    int? textureHeight,
    double? fullWidth,
    double? fullHeight,
    String? backgroundColor,
    bool allowAntiAliasing = true,
  }) async {
    return false;
  }

  @override
  bool operator ==(Object other) =>
      other is PdfPageTextureStub &&
      other.id == id &&
      other.pageId == pageId &&
      other.pageNumber == pageNumber;

  @override
  int get hashCode => id ^ pageNumber;
}

