import '../repositories/file_repository.dart';

/// Use case for renaming a file or directory.
///
/// This use case renames a file or directory to a new name.
class RenameFile {
  /// Creates a new [RenameFile] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const RenameFile(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the rename file operation.
  ///
  /// [path] The current path of the file or directory.
  /// [newName] The new name for the file or directory (without path).
  ///
  /// Returns the new path of the renamed file/directory.
  /// Throws [Exception] if renaming fails.
  Future<String> call(String path, String newName) {
    return repository.renameFile(path, newName);
  }
}

