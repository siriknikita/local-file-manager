import '../entities/file_item.dart';
import '../repositories/file_repository.dart';

/// Use case for searching files by name.
///
/// This use case searches for files matching a query string,
/// optionally searching recursively in subdirectories.
class SearchFiles {
  /// Creates a new [SearchFiles] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const SearchFiles(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the search files operation.
  ///
  /// [query] The search query (filename pattern). Case-insensitive matching.
  /// [rootPath] The root path to search from.
  /// [recursive] Whether to search recursively in subdirectories. Defaults to true.
  ///
  /// Returns a list of [FileItem] objects matching the query.
  /// Throws [Exception] if the search fails.
  Future<List<FileItem>> call({
    required String query,
    required String rootPath,
    bool recursive = true,
  }) {
    return repository.searchFiles(
      query: query,
      rootPath: rootPath,
      recursive: recursive,
    );
  }
}

