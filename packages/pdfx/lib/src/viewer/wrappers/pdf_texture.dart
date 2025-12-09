export 'implementations/pdf_texture_stub.dart'
    if (dart.library.io) 'implementations/pdf_texture_native.dart'
    if (dart.library.js_interop) 'implementations/pdf_texture_web.dart';
