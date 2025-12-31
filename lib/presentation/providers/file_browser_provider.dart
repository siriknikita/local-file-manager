import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/file_item.dart';
import '../../domain/usecases/browse_directory.dart';
import 'providers.dart';

/// State for the current directory being browsed.
class FileBrowserState {
  /// The current directory path.
  final String currentPath;

  /// The list of files and directories in the current directory.
  final List<FileItem> items;

  /// Whether the directory is currently being loaded.
  final bool isLoading;

  /// Error message if loading failed.
  final String? error;

  /// Creates a new [FileBrowserState] instance.
  const FileBrowserState({
    required this.currentPath,
    required this.items,
    this.isLoading = false,
    this.error,
  });

  /// Creates a copy of this state with updated values.
  FileBrowserState copyWith({
    String? currentPath,
    List<FileItem>? items,
    bool? isLoading,
    String? error,
  }) {
    return FileBrowserState(
      currentPath: currentPath ?? this.currentPath,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for the browse directory use case.
final browseDirectoryProvider = Provider<BrowseDirectory>((ref) {
  final repository = ref.watch(fileRepositoryProvider);
  return BrowseDirectory(repository);
});

/// Provider for the file browser state.
final fileBrowserProvider =
    StateNotifierProvider<FileBrowserNotifier, FileBrowserState>((ref) {
  final browseDirectory = ref.watch(browseDirectoryProvider);
  return FileBrowserNotifier(browseDirectory);
});

/// Notifier for managing file browser state.
class FileBrowserNotifier extends StateNotifier<FileBrowserState> {
  /// Creates a new [FileBrowserNotifier] instance.
  ///
  /// [browseDirectory] The use case for browsing directories.
  FileBrowserNotifier(this._browseDirectory)
      : super(
          const FileBrowserState(
            currentPath: '',
            items: [],
          ),
        );

  /// The browse directory use case.
  final BrowseDirectory _browseDirectory;

  /// Navigates to a directory and loads its contents.
  ///
  /// [path] The path of the directory to navigate to.
  Future<void> navigateToDirectory(String path) async {
    state = state.copyWith(
      currentPath: path,
      isLoading: true,
      error: null,
    );

    try {
      final List<FileItem> items = await _browseDirectory(path);
      state = state.copyWith(
        items: items,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refreshes the current directory.
  Future<void> refresh() async {
    if (state.currentPath.isNotEmpty) {
      await navigateToDirectory(state.currentPath);
    }
  }
}

