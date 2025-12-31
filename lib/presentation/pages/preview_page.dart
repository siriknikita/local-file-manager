import 'package:flutter/material.dart';

import '../../domain/entities/file_item.dart';

/// Page for previewing files (images, text, PDFs).
///
/// This page displays file previews based on the file type.
/// Unsupported formats are delegated to the OS default application.
class PreviewPage extends StatelessWidget {
  /// Creates a new [PreviewPage] instance.
  ///
  /// [fileItem] The file item to preview.
  const PreviewPage({
    required this.fileItem,
    super.key,
  });

  /// The file item to preview.
  final FileItem fileItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fileItem.name),
      ),
      body: _buildPreview(),
    );
  }

  /// Builds the preview widget based on file type.
  Widget _buildPreview() {
    if (fileItem.isDirectory) {
      return const Center(
        child: Text('Cannot preview directories'),
      );
    }

    final String? mimeType = fileItem.mimeType;

    if (mimeType == null) {
      return const Center(
        child: Text('Unknown file type'),
      );
    }

    if (mimeType.startsWith('image/')) {
      return _buildImagePreview();
    } else if (mimeType == 'text/plain' || mimeType.startsWith('text/')) {
      return _buildTextPreview();
    } else if (mimeType == 'application/pdf') {
      return _buildPdfPreview();
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Preview not available for this file type'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Open file with OS default application
              },
              child: const Text('Open with default app'),
            ),
          ],
        ),
      );
    }
  }

  /// Builds the image preview widget.
  Widget _buildImagePreview() {
    // TODO: Implement image preview using Image.file or similar
    return const Center(
      child: Text('Image preview not yet implemented'),
    );
  }

  /// Builds the text preview widget.
  Widget _buildTextPreview() {
    // TODO: Implement text file preview
    return const Center(
      child: Text('Text preview not yet implemented'),
    );
  }

  /// Builds the PDF preview widget.
  Widget _buildPdfPreview() {
    // TODO: Implement PDF preview using a PDF viewer package
    return const Center(
      child: Text('PDF preview not yet implemented'),
    );
  }
}

