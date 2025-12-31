import '../entities/storage_info.dart';
import '../repositories/file_repository.dart';

/// Use case for getting storage information.
///
/// This use case retrieves storage information including total,
/// used, and free storage space.
class GetStorageInfo {
  /// Creates a new [GetStorageInfo] use case.
  ///
  /// [repository] The file repository to use for file operations.
  const GetStorageInfo(this.repository);

  /// The file repository instance.
  final FileRepository repository;

  /// Executes the get storage info operation.
  ///
  /// Returns a [StorageInfo] object with total, used, and free storage.
  /// Throws [Exception] if storage information cannot be retrieved.
  Future<StorageInfo> call() {
    return repository.getStorageInfo();
  }
}

