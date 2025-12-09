import 'dart:async';
import 'dart:typed_data';

import 'package:pdfx/src/renderer/interfaces/document.dart';
import 'package:pdfx/src/renderer/platform_selector.dart' as platform_selector;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Abstraction layer to isolate [PdfDocument] implementation
/// from the public interface.
abstract class PdfxPlatform extends PlatformInterface {
  /// Constructs a PdfxPlatform.
  PdfxPlatform() : super(token: _token);

  static final Object _token = Object();

  static PdfxPlatform? _instance;

  /// The default instance of [PdfxPlatform] to use.
  ///
  /// Defaults to the platform-specific implementation selected via
  /// conditional imports (Pigeon on iOS/macOS/Android, MethodChannel on
  /// Windows, or Stub on unsupported platforms).
  static PdfxPlatform get instance {
    if (_instance == null) {
      final platformInstance = platform_selector.createPlatformInstance();
      if (platformInstance is PdfxPlatform) {
        _instance = platformInstance;
      } else {
        // Wrap stub in adapter
        _instance = _PdfxPlatformStubAdapter(platformInstance);
      }
    }
    return _instance!;
  }

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PdfxPlatform] when they register themselves.
  static set instance(PdfxPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<PdfDocument> openFile(String filePath, {String? password});

  Future<PdfDocument> openAsset(String name, {String? password});

  Future<PdfDocument> openData(FutureOr<Uint8List> data, {String? password});
}

/// Adapter that wraps the stub implementation for unsupported platforms.
/// This avoids circular imports by not requiring the stub to extend PdfxPlatform.
class _PdfxPlatformStubAdapter extends PdfxPlatform {
  _PdfxPlatformStubAdapter(this._stub);

  final dynamic _stub;

  @override
  Future<PdfDocument> openFile(String filePath, {String? password}) =>
      _stub.openFile(filePath, password: password);

  @override
  Future<PdfDocument> openAsset(String name, {String? password}) =>
      _stub.openAsset(name, password: password);

  @override
  Future<PdfDocument> openData(FutureOr<Uint8List> data, {String? password}) =>
      _stub.openData(data, password: password);
}

class PdfNotSupportException implements Exception {
  PdfNotSupportException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}
