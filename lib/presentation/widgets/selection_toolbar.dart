import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selection_provider.dart';

/// Toolbar that appears when files are selected.
///
/// Provides actions for selected files (delete, copy, move, share, etc.).
class SelectionToolbar extends ConsumerWidget {
  /// Creates a new [SelectionToolbar] instance.
  ///
  /// [selectedCount] The number of selected files.
  const SelectionToolbar({
    required this.selectedCount,
    super.key,
  });

  /// The number of selected files.
  final int selectedCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$selectedCount selected'),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  // TODO: Copy selected files
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // TODO: Delete selected files with confirmation
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // TODO: Share selected files
                },
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  ref.read(selectionProvider.notifier).toggleSelectionMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

