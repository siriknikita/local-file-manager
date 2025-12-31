import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:local_file_manager/presentation/providers/providers.dart';
import 'package:local_file_manager/presentation/widgets/permission_dialog.dart';
import 'package:local_file_manager/presentation/pages/file_browser_page.dart';

/// Home page that handles initial setup and navigation to file browser.
///
/// This page checks for permissions and root directory access,
/// then navigates to the file browser once ready.
class HomePage extends ConsumerStatefulWidget {
  /// Creates a new [HomePage] instance.
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isInitializing = true;
  bool _hasCheckedPermissions = false;
  bool? _isAndroid11Plus;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  /// Checks if device is running Android 11+.
  Future<bool> _checkAndroidVersion() async {
    if (_isAndroid11Plus != null) return _isAndroid11Plus!;
    
    if (!Platform.isAndroid) {
      _isAndroid11Plus = false;
      return false;
    }

    // Check by trying to access manageExternalStorage permission
    // If we can check its status without error, we're on Android 11+
    try {
      final permissionService = ref.read(permissionServiceProvider);
      // Check if we need settings access (this will be true on Android 11+ if not granted)
      final needsSettings = await permissionService.needsSettingsAccess();
      // Also try to check the permission status directly
      final hasPermission = await permissionService.checkStoragePermission();
      // If needsSettings is true or we can check manageExternalStorage, we're on Android 11+
      _isAndroid11Plus = needsSettings || !hasPermission;
      return _isAndroid11Plus!;
    } catch (e) {
      // If checking fails, assume Android 10 or below
      _isAndroid11Plus = false;
      return false;
    }
  }

  /// Initializes the app by checking permissions and setting up root directory.
  Future<void> _initializeApp() async {
    if (!mounted) return;

    setState(() {
      _isInitializing = true;
    });

    // Check Android version first
    final isAndroid11Plus = await _checkAndroidVersion();

    // Check permissions
    final checkPermissions = ref.read(checkPermissionsProvider);
    final hasPermission = await checkPermissions();

    if (!mounted) return;

    setState(() {
      _hasCheckedPermissions = true;
      _isInitializing = false;
    });

    if (hasPermission) {
      // Permissions granted, navigate to file browser
      _navigateToFileBrowser();
    } else {
      // Permissions not granted, show permission dialog
      _showPermissionDialog(isAndroid11Plus);
    }
  }

  /// Shows the permission request dialog.
  void _showPermissionDialog(bool isAndroid11Plus) {
    if (!mounted) return;

    PermissionDialog.show(
      context,
      onRequestPermission: () => _requestPermissions(isAndroid11Plus),
      onDismiss: () => _checkPermanentlyDenied(isAndroid11Plus),
      isAndroid11Plus: isAndroid11Plus,
    );
  }

  /// Requests storage permissions from the user.
  Future<void> _requestPermissions(bool isAndroid11Plus) async {
    if (!mounted) return;

    if (isAndroid11Plus) {
      // Android 11+: Open settings directly since we can't request programmatically
      final permissionService = ref.read(permissionServiceProvider);
      await permissionService.openManageAllFilesSettings();
      // Wait a bit for the user to return from settings
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted) {
        await _initializeApp();
      }
      return;
    }

    // Android 9-10: Request permissions normally
    final requestPermissions = ref.read(requestPermissionsProvider);
    final granted = await requestPermissions();

    if (!mounted) return;

    if (granted) {
      // Permissions granted, navigate to file browser
      _navigateToFileBrowser();
    } else {
      // Permissions denied, check if permanently denied
      _checkPermanentlyDenied(isAndroid11Plus);
    }
  }

  /// Checks if permissions are permanently denied and shows appropriate dialog.
  Future<void> _checkPermanentlyDenied(bool isAndroid11Plus) async {
    if (!mounted) return;

    final permissionService = ref.read(permissionServiceProvider);
    final isPermanentlyDenied = await permissionService.isPermissionPermanentlyDenied();

    if (!mounted) return;

    if (isPermanentlyDenied || isAndroid11Plus) {
      // Show dialog to open settings
      PermissionDeniedDialog.show(
        context,
        onOpenSettings: () async {
          final permissionService = ref.read(permissionServiceProvider);
          if (isAndroid11Plus) {
            await permissionService.openManageAllFilesSettings();
          } else {
            await permissionService.openSettings();
          }
          // After returning from settings, check permissions again
          // Wait a bit for the user to return from settings
          await Future<void>.delayed(const Duration(seconds: 1));
          if (mounted) {
            await _initializeApp();
          }
        },
        onDismiss: () => _showPermissionDialog(isAndroid11Plus),
        isAndroid11Plus: isAndroid11Plus,
      );
    } else {
      // Not permanently denied, show permission dialog again
      _showPermissionDialog(isAndroid11Plus);
    }
  }

  /// Navigates to the file browser page.
  void _navigateToFileBrowser() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const FileBrowserPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If we haven't checked permissions yet, show loading
    if (!_hasCheckedPermissions || _isInitializing) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // After checking permissions, the dialog will be shown
    // This widget will remain visible until navigation happens
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

