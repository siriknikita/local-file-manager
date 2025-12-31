import '../repositories/file_repository.dart';

/// Use case for copying a file or directory.
///
/// This use case copies a file or directory from source to destination.
/// For directories, this will copy all contents recursively.
class CopyFile {
  /// Creates a new [CopyFile] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const CopyFile(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the copy file operation.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be copied.
  ///
  /// Returns the path of the copied file/directory.
  /// Throws [Exception] if the copy operation fails.
  Future<String> call(String source, String dest) {
    return repository.copyFile(source, dest);
  }
}

