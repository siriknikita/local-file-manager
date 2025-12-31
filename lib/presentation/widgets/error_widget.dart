import 'package:flutter/material.dart';

/// Widget for displaying error messages.
///
/// Shows an error message with an optional retry action.
class ErrorWidget extends StatelessWidget {
  /// Creates a new [ErrorWidget] instance.
  ///
  /// [message] The error message to display.
  /// [onRetry] Optional callback for retry action.
  const ErrorWidget({
    required this.message,
    this.onRetry,
    super.key,
  });

  /// The error message to display.
  final String message;

  /// Optional callback for retry action.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.red,
                ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}

