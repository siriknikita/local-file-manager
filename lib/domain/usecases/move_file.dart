import '../repositories/file_repository.dart';

/// Use case for moving a file or directory.
///
/// This use case moves a file or directory from source to destination.
class MoveFile {
  /// Creates a new [MoveFile] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const MoveFile(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the move file operation.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be moved.
  ///
  /// Returns the path of the moved file/directory.
  /// Throws [Exception] if the move operation fails.
  Future<String> call(String source, String dest) {
    return repository.moveFile(source, dest);
  }
}

