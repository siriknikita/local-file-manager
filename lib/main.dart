import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/pages/home_page.dart';

/// Main entry point of the Local File Manager application.
void main() {
  runApp(
    const ProviderScope(
      child: LocalFileManagerApp(),
    ),
  );
}

/// Root widget of the Local File Manager application.
class LocalFileManagerApp extends StatelessWidget {
  /// Creates a new [LocalFileManagerApp] instance.
  const LocalFileManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local File Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
