import 'package:flutter/material.dart';

/// Widget for displaying loading indicator.
///
/// A simple centered circular progress indicator.
class LoadingIndicator extends StatelessWidget {
  /// Creates a new [LoadingIndicator] instance.
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

