import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/file_item.dart';
import '../providers/file_browser_provider.dart';
import '../providers/file_operations_provider.dart';
import '../providers/selection_provider.dart';
import '../providers/view_mode_provider.dart';
import '../providers/providers.dart';
import '../widgets/breadcrumb_navigation.dart';
import '../widgets/file_grid_item.dart';
import '../widgets/file_list_item.dart';
import '../widgets/search_bar.dart' as search_widget;
import '../widgets/selection_toolbar.dart';

/// Main file browser page that displays files and directories.
///
/// This page shows the current directory contents in either grid or list view,
/// supports file operations, and handles navigation.
class FileBrowserPage extends ConsumerStatefulWidget {
  /// Creates a new [FileBrowserPage] instance.
  const FileBrowserPage({super.key});

  @override
  ConsumerState<FileBrowserPage> createState() => _FileBrowserPageState();
}

class _FileBrowserPageState extends ConsumerState<FileBrowserPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialDirectory();
    });
  }

  /// Loads the initial directory (root directories).
  Future<void> _loadInitialDirectory() async {
    try {
      // Get root directories from repository
      final repository = ref.read(fileRepositoryProvider);
      final rootDirectories = await repository.getRootDirectories();
      
      if (rootDirectories.isNotEmpty) {
        // Navigate to the first available root directory
        final notifier = ref.read(fileBrowserProvider.notifier);
        await notifier.navigateToDirectory(rootDirectories.first);
      } else {
        // No root directories available, show error
        final notifier = ref.read(fileBrowserProvider.notifier);
        await notifier.navigateToDirectory('');
        // Set error state
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No accessible directories found. Please grant storage permissions.'),
            ),
          );
        }
      }
    } catch (e) {
      // Error loading root directories
      final notifier = ref.read(fileBrowserProvider.notifier);
      await notifier.navigateToDirectory('');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading directories: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileBrowserState = ref.watch(fileBrowserProvider);
    final selectionState = ref.watch(selectionProvider);
    final viewModeState = ref.watch(viewModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Local File Manager'),
        actions: [
          IconButton(
            icon: Icon(
              viewModeState.mode == ViewMode.grid
                  ? Icons.view_list
                  : Icons.view_module,
            ),
            onPressed: () {
              ref.read(viewModeProvider.notifier).toggleViewMode();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const search_widget.SearchBar(),
          BreadcrumbNavigation(currentPath: fileBrowserState.currentPath),
          Expanded(
            child: _buildFileList(fileBrowserState, viewModeState.mode),
          ),
          if (selectionState.isSelectionMode)
            SelectionToolbar(
              selectedCount: selectionState.selectionCount,
            ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Builds the file list based on view mode.
  Widget _buildFileList(FileBrowserState state, ViewMode mode) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return _buildErrorWidget(state.error!, state.currentPath);
    }

    // Get parent path and create items list with ".." if needed
    final notifier = ref.read(fileBrowserProvider.notifier);
    final parentPath = notifier.getParentPath(state.currentPath);
    final List<FileItem> items = List.from(state.items);

    // Prepend ".." item if parent directory exists
    if (parentPath != null) {
      final parentItem = FileItem.directory(
        name: '..',
        path: parentPath,
        modifiedDate: DateTime.now(),
      );
      items.insert(0, parentItem);
    }

    if (items.isEmpty) {
      return const Center(
        child: Text('No files or directories found'),
      );
    }

    if (mode == ViewMode.grid) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FileGridItem(
            fileItem: items[index],
            onTap: (fileItem) {
              _handleItemTap(fileItem);
            },
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return FileListItem(
            fileItem: items[index],
            onTap: (fileItem) {
              _handleItemTap(fileItem);
            },
          );
        },
      );
    }
  }

  /// Handles tap on a file or directory item.
  void _handleItemTap(FileItem fileItem) {
    if (fileItem.name == '..' && fileItem.isDirectory) {
      // Navigate to parent directory
      final notifier = ref.read(fileBrowserProvider.notifier);
      notifier.navigateToDirectory(fileItem.path);
    } else if (fileItem.isDirectory) {
      // Navigate to subdirectory
      final notifier = ref.read(fileBrowserProvider.notifier);
      notifier.navigateToDirectory(fileItem.path);
    } else {
      // TODO: Open/preview file
    }
  }

  /// Builds the error widget with retry functionality.
  Widget _buildErrorWidget(String error, String currentPath) {
    final isPermissionError = _isPermissionError(error);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPermissionError ? Icons.lock_outline : Icons.error_outline,
              size: 64,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              isPermissionError
                  ? 'Access Denied'
                  : 'Error Loading Directory',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              _getUserFriendlyErrorMessage(error),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                final notifier = ref.read(fileBrowserProvider.notifier);
                notifier.refresh();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            if (isPermissionError) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  // Navigate back to parent if possible
                  final notifier = ref.read(fileBrowserProvider.notifier);
                  final parentPath = notifier.getParentPath(currentPath);
                  if (parentPath != null) {
                    notifier.navigateToDirectory(parentPath);
                  }
                },
                child: const Text('Go Back'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Checks if the error is permission-related.
  bool _isPermissionError(String error) {
    final lowerError = error.toLowerCase();
    return lowerError.contains('permission denied') ||
        lowerError.contains('access denied') ||
        lowerError.contains('errno = 13') ||
        lowerError.contains('protected by the system');
  }

  /// Gets a user-friendly error message from the error string.
  String _getUserFriendlyErrorMessage(String error) {
    if (_isPermissionError(error)) {
      return 'This directory is protected by the system and cannot be accessed. '
          'Some directories require special permissions that are not available to regular apps.';
    }
    
    // Extract the meaningful part of the error message
    if (error.contains('Directory does not exist')) {
      return 'The directory no longer exists or has been moved.';
    }
    
    if (error.contains('Failed to list files')) {
      return 'Unable to read the contents of this directory. '
          'It may be corrupted or inaccessible.';
    }
    
    // Return a sanitized version of the error
    return error.replaceAll('Exception: ', '').replaceAll('Failed to list files: ', '');
  }

  /// Builds the floating action button.
  Widget? _buildFloatingActionButton() {
    final selectionState = ref.watch(selectionProvider);
    final operationsState = ref.watch(fileOperationsProvider);

    if (selectionState.isSelectionMode) {
      return null;
    }

    if (operationsState.hasCopiedFile) {
      return FloatingActionButton(
        onPressed: () {
          // TODO: Implement paste operation
        },
        child: const Icon(Icons.paste),
      );
    }

    return FloatingActionButton(
      onPressed: () {
        // TODO: Implement create folder dialog
      },
      child: const Icon(Icons.create_new_folder),
    );
  }
}

