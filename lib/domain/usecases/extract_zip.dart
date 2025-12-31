import '../repositories/file_repository.dart';

/// Use case for extracting a ZIP archive.
///
/// This use case extracts the contents of a ZIP archive to a destination directory.
class ExtractZip {
  /// Creates a new [ExtractZip] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const ExtractZip(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the extract ZIP operation.
  ///
  /// [zipPath] The path of the ZIP file to extract.
  /// [destPath] The destination directory where files should be extracted.
  ///
  /// Returns the path of the destination directory.
  /// Throws [Exception] if the extraction fails.
  Future<String> call({
    required String zipPath,
    required String destPath,
  }) {
    // Note: ZIP extraction will be implemented in the repository
    // using the flutter_archive package
    throw UnimplementedError('ZIP extraction will be implemented in repository');
  }
}

