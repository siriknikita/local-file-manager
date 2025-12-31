import 'package:flutter/material.dart';

/// Widget for displaying empty state.
///
/// Shown when a directory is empty or no search results are found.
class EmptyState extends StatelessWidget {
  /// Creates a new [EmptyState] instance.
  ///
  /// [message] The message to display.
  /// [icon] Optional icon to display.
  const EmptyState({
    required this.message,
    this.icon,
    super.key,
  });

  /// The message to display.
  final String message;

  /// Optional icon to display.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 64,
              color: Colors.grey,
            ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}

