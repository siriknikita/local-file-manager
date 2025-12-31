import 'dart:io';

import 'package:flutter/material.dart';

/// Dialog widget for requesting storage permissions.
///
/// This dialog explains why permissions are needed and provides
/// a button to request them from the user.
class PermissionDialog extends StatelessWidget {
  /// Creates a new [PermissionDialog] instance.
  ///
  /// [onRequestPermission] Callback when the user taps the "Allow" button.
  /// [onDismiss] Optional callback when the dialog is dismissed.
  /// [isAndroid11Plus] Whether this is Android 11+ which requires special handling.
  const PermissionDialog({
    required this.onRequestPermission,
    this.onDismiss,
    this.isAndroid11Plus = false,
    super.key,
  });

  /// Callback when the user taps the "Allow" button.
  final VoidCallback onRequestPermission;

  /// Optional callback when the dialog is dismissed.
  final VoidCallback? onDismiss;

  /// Whether this is Android 11+ which requires special handling.
  final bool isAndroid11Plus;

  /// Shows the permission dialog.
  ///
  /// [context] The build context.
  /// [onRequestPermission] Callback when the user taps the "Allow" button.
  /// [onDismiss] Optional callback when the dialog is dismissed.
  /// [isAndroid11Plus] Whether this is Android 11+ which requires special handling.
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onRequestPermission,
    VoidCallback? onDismiss,
    bool isAndroid11Plus = false,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionDialog(
        onRequestPermission: onRequestPermission,
        onDismiss: onDismiss,
        isAndroid11Plus: isAndroid11Plus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Storage Permission Required'),
      content: Text(
        isAndroid11Plus
            ? 'Local File Manager needs access to manage all files on your device. '
                'On Android 11+, you need to enable "Allow access to manage all files" '
                'in the system settings. Tap "Open Settings" to continue.'
            : 'Local File Manager needs access to your device storage to browse, '
                'manage, and organize your files. Please grant storage permission to continue.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDismiss?.call();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onRequestPermission();
          },
          child: Text(isAndroid11Plus ? 'Open Settings' : 'Allow'),
        ),
      ],
    );
  }
}

/// Dialog widget for when permissions are permanently denied.
///
/// This dialog appears when the user has permanently denied permissions
/// and provides an option to open app settings.
class PermissionDeniedDialog extends StatelessWidget {
  /// Creates a new [PermissionDeniedDialog] instance.
  ///
  /// [onOpenSettings] Callback when the user taps the "Open Settings" button.
  /// [onDismiss] Optional callback when the dialog is dismissed.
  /// [isAndroid11Plus] Whether this is Android 11+ which requires special handling.
  const PermissionDeniedDialog({
    required this.onOpenSettings,
    this.onDismiss,
    this.isAndroid11Plus = false,
    super.key,
  });

  /// Callback when the user taps the "Open Settings" button.
  final VoidCallback onOpenSettings;

  /// Optional callback when the dialog is dismissed.
  final VoidCallback? onDismiss;

  /// Whether this is Android 11+ which requires special handling.
  final bool isAndroid11Plus;

  /// Shows the permission denied dialog.
  ///
  /// [context] The build context.
  /// [onOpenSettings] Callback when the user taps the "Open Settings" button.
  /// [onDismiss] Optional callback when the dialog is dismissed.
  /// [isAndroid11Plus] Whether this is Android 11+ which requires special handling.
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onOpenSettings,
    VoidCallback? onDismiss,
    bool isAndroid11Plus = false,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionDeniedDialog(
        onOpenSettings: onOpenSettings,
        onDismiss: onDismiss,
        isAndroid11Plus: isAndroid11Plus,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Permission Required'),
      content: Text(
        isAndroid11Plus
            ? 'To use Local File Manager, you need to enable "Allow access to manage all files" '
                'in the system settings. This permission cannot be granted through the app. '
                'Please open settings and enable it manually.'
            : 'Storage permission has been denied. To use Local File Manager, '
                'please grant storage permission in the app settings.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDismiss?.call();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onOpenSettings();
          },
          child: const Text('Open Settings'),
        ),
      ],
    );
  }
}

