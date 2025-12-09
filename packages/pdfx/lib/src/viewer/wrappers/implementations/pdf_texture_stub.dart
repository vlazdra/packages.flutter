import 'package:flutter/widgets.dart';

/// Stub implementation of PdfTexture for unsupported platforms.
/// Returns an empty SizedBox instead of a Texture widget.
// ignore: non_constant_identifier_names
Widget PdfTexture({Key? key, required int textureId}) =>
    SizedBox.shrink(key: key);

