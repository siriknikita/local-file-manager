import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'file_browser_page.dart';

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
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  /// Initializes the app by checking permissions and setting up root directory.
  Future<void> _initializeApp() async {
    // TODO: Implement permission checking and root directory selection
    // For now, navigate directly to file browser
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const FileBrowserPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

