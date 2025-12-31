import 'package:local_file_manager/domain/entities/file_item.dart';
import 'package:local_file_manager/domain/entities/storage_info.dart';
import 'package:local_file_manager/data/platform/platform_file_service.dart';

/// Data source for local file operations.
///
/// This data source wraps the platform file service and provides
/// additional functionality like search and storage info calculation.
class LocalFileDataSource {
  /// Creates a new [LocalFileDataSource] instance.
  ///
  /// [platformService] The platform-specific file service to use.
  const LocalFileDataSource(this.platformService);

  /// The platform file service instance.
  final PlatformFileService platformService;

  /// Gets the root directories available for browsing.
  Future<List<String>> getRootDirectories() {
    return platformService.getRootDirectories();
  }

  /// Lists all files and directories in the specified path.
  Future<List<FileItem>> listFiles(String path) {
    return platformService.listFiles(path);
  }

  /// Creates a new directory at the specified path.
  Future<String> createDirectory(String path) {
    return platformService.createDirectory(path);
  }

  /// Deletes a file or directory at the specified path.
  Future<void> deleteFile(String path) {
    return platformService.deleteFile(path);
  }

  /// Copies a file or directory from source to destination.
  Future<String> copyFile(String source, String dest) {
    return platformService.copyFile(source, dest);
  }

  /// Moves a file or directory from source to destination.
  Future<String> moveFile(String source, String dest) {
    return platformService.moveFile(source, dest);
  }

  /// Renames a file or directory.
  Future<String> renameFile(String path, String newName) {
    return platformService.renameFile(path, newName);
  }

  /// Gets detailed information about a file or directory.
  Future<FileItem> getFileInfo(String path) {
    return platformService.getFileInfo(path);
  }

  /// Calculates the total size of a directory and all its contents.
  Future<int> calculateDirectorySize(String path) {
    return platformService.calculateDirectorySize(path);
  }

  /// Searches for files matching the given query.
  ///
  /// This method performs a recursive search through directories
  /// to find files matching the query string (case-insensitive).
  Future<List<FileItem>> searchFiles({
    required String query,
    required String rootPath,
    bool recursive = true,
  }) async {
    final List<FileItem> results = [];
    final String lowerQuery = query.toLowerCase();

    await _searchRecursive(
      rootPath,
      lowerQuery,
      recursive,
      results,
    );

    return results;
  }

  /// Recursively searches for files matching the query.
  Future<void> _searchRecursive(
    String path,
    String query,
    bool recursive,
    List<FileItem> results,
  ) async {
    try {
      final List<FileItem> items = await platformService.listFiles(path);

      for (final FileItem item in items) {
        if (item.name.toLowerCase().contains(query)) {
          results.add(item);
        }

        if (recursive && item.isDirectory) {
          await _searchRecursive(item.path, query, recursive, results);
        }
      }
    } catch (e) {
      // Silently skip directories that can't be accessed
      // This is expected behavior for permission-restricted directories
    }
  }

  /// Gets storage information for the device.
  ///
  /// This method calculates total, used, and free storage space.
  /// The implementation is platform-specific.
  Future<StorageInfo> getStorageInfo() async {
    // This is a simplified implementation
    // In a real app, you would use platform-specific APIs to get storage info
    // For now, we'll return a placeholder
    // Android: Use StatFs or StorageManager
    // iOS: Use NSFileManager attributesOfFileSystemForPath
    throw UnimplementedError(
      'Storage info calculation requires platform-specific implementation',
    );
  }

  /// Checks if a path exists and is accessible.
  Future<bool> pathExists(String path) {
    return platformService.pathExists(path);
  }

  /// Opens a file using the platform's default application.
  Future<void> openFile(String path) {
    return platformService.openFile(path);
  }
}

