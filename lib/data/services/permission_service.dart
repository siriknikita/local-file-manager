import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

/// Service for handling platform-specific permissions.
///
/// This service provides a platform-agnostic interface for checking
/// and requesting permissions needed by the file manager app.
class PermissionService {
  /// Creates a new [PermissionService] instance.
  const PermissionService();

  /// Checks if the device is running Android 11 or above (API 30+).
  Future<bool> _isAndroid11OrAbove() async {
    if (!Platform.isAndroid) return false;
    // Android 11 is API level 30
    // Check if manageExternalStorage permission is available
    try {
      await Permission.manageExternalStorage.status;
      // If we can check the status without error, we're on Android 11+
      return true;
    } catch (e) {
      // If checking fails, we're likely on Android 10 or below
      return false;
    }
  }

  /// Checks if storage permissions are granted.
  ///
  /// Returns true if permissions are granted, false otherwise.
  /// On iOS and Web, this always returns true as no runtime permissions are needed.
  Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      final isAndroid11Plus = await _isAndroid11OrAbove();
      
      if (isAndroid11Plus) {
        // Android 11+: Check MANAGE_EXTERNAL_STORAGE
        final status = await Permission.manageExternalStorage.status;
        return status.isGranted;
      } else {
        // Android 9-10: Check both READ and WRITE permissions
        final readStatus = await Permission.storage.status;
        // For Android 9-10, storage permission covers both read and write
        return readStatus.isGranted;
      }
    } else if (Platform.isIOS) {
      // iOS doesn't require runtime permissions for file access
      // Uses UIDocumentPicker which handles permissions internally
      return true;
    } else {
      // Web and other platforms don't need permissions
      return true;
    }
  }

  /// Requests storage permissions from the user.
  ///
  /// Returns true if permissions were granted, false otherwise.
  /// On iOS and Web, this always returns true as no runtime permissions are needed.
  /// 
  /// Note: For Android 11+, MANAGE_EXTERNAL_STORAGE cannot be requested
  /// programmatically. This method will return false and the user must be
  /// guided to system settings to enable it manually.
  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      final isAndroid11Plus = await _isAndroid11OrAbove();
      
      if (isAndroid11Plus) {
        // Android 11+: MANAGE_EXTERNAL_STORAGE cannot be requested programmatically
        // The user must enable it manually in system settings
        // We can only check the status, not request it
        final status = await Permission.manageExternalStorage.status;
        return status.isGranted;
      } else {
        // Android 9-10: Request storage permission (covers both read and write)
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      // iOS doesn't require runtime permissions for file access
      return true;
    } else {
      // Web and other platforms don't need permissions
      return true;
    }
  }

  /// Checks if permissions are permanently denied (user selected "Don't ask again").
  ///
  /// Returns true if permissions are permanently denied, false otherwise.
  Future<bool> isPermissionPermanentlyDenied() async {
    if (Platform.isAndroid) {
      final isAndroid11Plus = await _isAndroid11OrAbove();
      
      if (isAndroid11Plus) {
        final status = await Permission.manageExternalStorage.status;
        return status.isPermanentlyDenied || status.isDenied;
      } else {
        final status = await Permission.storage.status;
        return status.isPermanentlyDenied;
      }
    }
    return false;
  }

  /// Checks if we need to guide the user to settings (Android 11+).
  ///
  /// Returns true if the user needs to enable MANAGE_EXTERNAL_STORAGE in settings.
  Future<bool> needsSettingsAccess() async {
    if (Platform.isAndroid) {
      final isAndroid11Plus = await _isAndroid11OrAbove();
      if (isAndroid11Plus) {
        final status = await Permission.manageExternalStorage.status;
        // If not granted, user needs to go to settings
        return !status.isGranted;
      }
    }
    return false;
  }

  /// Opens the app settings so the user can manually grant permissions.
  Future<bool> openSettings() async {
    return openAppSettings();
  }

  /// Opens the system settings for managing all files access (Android 11+).
  ///
  /// This opens the specific settings page where users can enable
  /// "Allow access to manage all files" for the app.
  Future<bool> openManageAllFilesSettings() async {
    if (Platform.isAndroid) {
      final isAndroid11Plus = await _isAndroid11OrAbove();
      if (isAndroid11Plus) {
        // Open the manage all files settings page
        return openAppSettings();
      }
    }
    return false;
  }
}

