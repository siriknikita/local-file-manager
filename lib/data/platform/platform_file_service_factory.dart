import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'android_file_service.dart';
import 'ios_file_service.dart';
import 'platform_file_service.dart';
import 'web_file_service.dart';

/// Factory for creating platform-specific [PlatformFileService] implementations.
///
/// This factory returns the appropriate file service implementation
/// based on the current platform (Android, iOS, or Web).
class PlatformFileServiceFactory {
  /// Creates a new [PlatformFileService] instance for the current platform.
  ///
  /// Returns:
  /// - [AndroidFileService] on Android
  /// - [IOSFileService] on iOS
  /// - [WebFileService] on Web
  ///
  /// Throws [UnsupportedError] if the platform is not supported.
  static PlatformFileService create() {
    if (kIsWeb) {
      return const WebFileService();
    } else if (Platform.isAndroid) {
      return const AndroidFileService();
    } else if (Platform.isIOS) {
      return const IOSFileService();
    } else {
      // Desktop platforms are not yet supported
      throw UnsupportedError(
        'Desktop platforms are not yet supported. Use Android, iOS, or Web.',
      );
    }
  }
}

