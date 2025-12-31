import 'package:flutter/material.dart';

import '../../domain/entities/file_item.dart';

/// Widget for displaying a file item in list view.
class FileListItem extends StatelessWidget {
  /// Creates a new [FileListItem] instance.
  ///
  /// [fileItem] The file item to display.
  const FileListItem({
    required this.fileItem,
    super.key,
  });

  /// The file item to display.
  final FileItem fileItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        fileItem.isDirectory ? Icons.folder : Icons.insert_drive_file,
      ),
      title: Text(fileItem.name),
      subtitle: Text(
        fileItem.isDirectory
            ? 'Directory'
            : '${_formatFileSize(fileItem.size)} • ${_formatDate(fileItem.modifiedDate)}',
      ),
      onTap: () {
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
    );
  }

  /// Formats file size in human-readable format.
  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Formats date in human-readable format.
  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

