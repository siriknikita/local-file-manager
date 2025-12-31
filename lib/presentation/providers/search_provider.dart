import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/file_item.dart';
import '../../domain/usecases/search_files.dart';
import 'providers.dart';

/// State for file search.
class SearchState {
  /// The current search query.
  final String query;

  /// The search results.
  final List<FileItem> results;

  /// Whether a search is in progress.
  final bool isSearching;

  /// Error message if search failed.
  final String? error;

  /// Creates a new [SearchState] instance.
  const SearchState({
    this.query = '',
    this.results = const [],
    this.isSearching = false,
    this.error,
  });

  /// Whether there are search results.
  bool get hasResults => results.isNotEmpty;

  /// Creates a copy of this state with updated values.
  SearchState copyWith({
    String? query,
    List<FileItem>? results,
    bool? isSearching,
    String? error,
  }) {
    return SearchState(
      query: query ?? this.query,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      error: error,
    );
  }
}

/// Provider for the search files use case.
final searchFilesProvider = Provider<SearchFiles>((ref) {
  final repository = ref.watch(fileRepositoryProvider);
  return SearchFiles(repository);
});

/// Provider for search state.
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final searchFiles = ref.watch(searchFilesProvider);
  return SearchNotifier(searchFiles);
});

/// Notifier for managing search state.
class SearchNotifier extends StateNotifier<SearchState> {
  /// Creates a new [SearchNotifier] instance.
  ///
  /// [searchFiles] The use case for searching files.
  SearchNotifier(this._searchFiles) : super(const SearchState());

  /// The search files use case.
  final SearchFiles _searchFiles;

  /// Performs a search with the given query.
  ///
  /// [query] The search query.
  /// [rootPath] The root path to search from.
  Future<void> search(String query, String rootPath) async {
    if (query.isEmpty) {
      state = state.copyWith(
        query: query,
        results: [],
        isSearching: false,
      );
      return;
    }

    state = state.copyWith(
      query: query,
      isSearching: true,
      error: null,
    );

    try {
      final List<FileItem> results = await _searchFiles(
        query: query,
        rootPath: rootPath,
        recursive: true,
      );

      state = state.copyWith(
        results: results,
        isSearching: false,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: e.toString(),
      );
    }
  }

  /// Clears the search query and results.
  void clearSearch() {
    state = const SearchState();
  }
}

