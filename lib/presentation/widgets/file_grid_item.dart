import 'package:flutter/material.dart';

import '../../domain/entities/file_item.dart';

/// Widget for displaying a file item in grid view.
class FileGridItem extends StatelessWidget {
  /// Creates a new [FileGridItem] instance.
  ///
  /// [fileItem] The file item to display.
  /// [onTap] Callback when the item is tapped.
  const FileGridItem({
    required this.fileItem,
    this.onTap,
    super.key,
  });

  /// The file item to display.
  final FileItem fileItem;

  /// Callback when the item is tapped.
  final void Function(FileItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap != null
            ? () => onTap!(fileItem)
            : () {
                // TODO: Handle file/directory tap
                if (fileItem.isDirectory) {
                  // Navigate to directory
                } else {
                  // Open/preview file
                }
              },
        onLongPress: () {
          // TODO: Show context menu or enter selection mode
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              fileItem.name == '..'
                  ? Icons.folder_outlined
                  : fileItem.isDirectory
                      ? Icons.folder
                      : Icons.insert_drive_file,
              size: 48,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                fileItem.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

