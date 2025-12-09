import 'package:pdfx/src/renderer/interfaces/document.dart';
import 'package:pdfx/src/renderer/interfaces/page.dart';
import 'package:pdfx/src/renderer/stub/page_stub.dart';

/// Stub implementation of [PdfDocument] for unsupported platforms.
/// Returns empty/no-op results silently.
class PdfDocumentStub extends PdfDocument {
  PdfDocumentStub._({
    required super.sourceName,
    required super.id,
    required super.pagesCount,
  });

  /// Creates a stub document with 0 pages.
  factory PdfDocumentStub.empty(String sourceName) => PdfDocumentStub._(
        sourceName: sourceName,
        id: 'stub-document',
        pagesCount: 0,
      );

  @override
  Future<void> close() async {
    isClosed = true;
  }

  @override
  Future<PdfPage> getPage(
    int pageNumber, {
    bool autoCloseAndroid = false,
  }) async {
    if (isClosed) {
      throw PdfDocumentAlreadyClosedException();
    }
    // Return a stub page even for invalid page numbers
    return PdfPageStub(
      document: this,
      pageNumber: pageNumber,
    );
  }

  @override
  bool operator ==(Object other) => other is PdfDocumentStub && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
