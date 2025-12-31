import '../entities/file_item.dart';
import '../repositories/file_repository.dart';

/// Use case for browsing a directory and listing its contents.
///
/// This use case retrieves all files and directories in a given path,
/// sorted with directories first, then files, both alphabetically.
class BrowseDirectory {
  /// Creates a new [BrowseDirectory] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const BrowseDirectory(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the browse directory operation.
  ///
  /// [path] The directory path to browse.
  ///
  /// Returns a list of [FileItem] objects representing the contents of the directory.
  /// Throws [Exception] if the path doesn't exist or access is denied.
  Future<List<FileItem>> call(String path) {
    return repository.listFiles(path);
  }
}

