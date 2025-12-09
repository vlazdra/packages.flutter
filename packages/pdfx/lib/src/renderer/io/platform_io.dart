import 'package:pdfx/src/renderer/io/platform_method_channel.dart';
import 'package:pdfx/src/renderer/io/platform_pigeon.dart';
import 'package:universal_platform/universal_platform.dart';

/// Determines whether to use Pigeon-based communication.
/// iOS, macOS, and Android use Pigeon; Windows uses MethodChannel.
final _usePigeon = UniversalPlatform.isIOS ||
    UniversalPlatform.isMacOS ||
    UniversalPlatform.isAndroid;

/// Creates the appropriate platform instance for IO platforms.
/// Uses Pigeon on iOS/macOS/Android, MethodChannel on Windows.
dynamic createPlatformInstance() =>
    _usePigeon ? PdfxPlatformPigeon() : PdfxPlatformMethodChannel();

