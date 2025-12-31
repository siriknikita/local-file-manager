import '../repositories/file_repository.dart';

/// Use case for creating a new folder/directory.
///
/// This use case creates a new directory at the specified path.
class CreateFolder {
  /// Creates a new [CreateFolder] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const CreateFolder(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the create folder operation.
  ///
  /// [path] The full path where the directory should be created.
  ///
  /// Returns the path of the created directory.
  /// Throws [Exception] if the directory cannot be created.
  Future<String> call(String path) {
    return repository.createDirectory(path);
  }
}

