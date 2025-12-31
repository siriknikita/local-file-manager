import '../repositories/file_repository.dart';

/// Use case for creating a ZIP archive from selected files.
///
/// This use case creates a ZIP archive containing the specified files.
class CreateZip {
  /// Creates a new [CreateZip] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const CreateZip(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the create ZIP operation.
  ///
  /// [filePaths] List of file/directory paths to include in the ZIP.
  /// [zipPath] The destination path for the ZIP file.
  ///
  /// Returns the path of the created ZIP file.
  /// Throws [Exception] if the ZIP creation fails.
  Future<String> call({
    required List<String> filePaths,
    required String zipPath,
  }) {
    // Note: ZIP creation will be implemented in the repository
    // using the flutter_archive package
    throw UnimplementedError('ZIP creation will be implemented in repository');
  }
}

