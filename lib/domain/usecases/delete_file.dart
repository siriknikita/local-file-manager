import '../repositories/file_repository.dart';

/// Use case for deleting a file or directory.
///
/// This use case deletes a file or directory at the specified path.
/// For directories, this will delete all contents recursively.
class DeleteFile {
  /// Creates a new [DeleteFile] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const DeleteFile(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the delete file operation.
  ///
  /// [path] The path of the file or directory to delete.
  ///
  /// Throws [Exception] if deletion fails or access is denied.
  Future<void> call(String path) {
    return repository.deleteFile(path);
  }
}

