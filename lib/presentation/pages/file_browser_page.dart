import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      return Center(
        child: Text('Error: ${state.error}'),
      );
    }

    if (state.items.isEmpty) {
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
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          return FileGridItem(fileItem: state.items[index]);
        },
      );
    } else {
      return ListView.builder(
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          return FileListItem(fileItem: state.items[index]);
        },
      );
    }
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

