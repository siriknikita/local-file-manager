import '../entities/file_item.dart';
import '../entities/storage_info.dart';

/// Repository interface for file operations.
///
/// This abstract repository defines the contract for file operations
/// that can be implemented by different data sources. It provides
/// a clean separation between domain logic and data access.
abstract class FileRepository {
  /// Gets the root directories available for browsing.
  ///
  /// Returns a list of root directory paths.
  /// Throws [Exception] if access is denied or unavailable.
  Future<List<String>> getRootDirectories();

  /// Lists all files and directories in the specified path.
  ///
  /// [path] The directory path to list contents from.
  ///
  /// Returns a list of [FileItem] objects representing files and directories.
  /// Throws [Exception] if the path doesn't exist or access is denied.
  Future<List<FileItem>> listFiles(String path);

  /// Creates a new directory at the specified path.
  ///
  /// [path] The full path where the directory should be created.
  ///
  /// Returns the path of the created directory.
  /// Throws [Exception] if the directory cannot be created.
  Future<String> createDirectory(String path);

  /// Deletes a file or directory at the specified path.
  ///
  /// [path] The path of the file or directory to delete.
  ///
  /// Throws [Exception] if deletion fails or access is denied.
  Future<void> deleteFile(String path);

  /// Copies a file or directory from source to destination.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be copied.
  ///
  /// Returns the path of the copied file/directory.
  /// Throws [Exception] if the copy operation fails.
  Future<String> copyFile(String source, String dest);

  /// Moves a file or directory from source to destination.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be moved.
  ///
  /// Returns the path of the moved file/directory.
  /// Throws [Exception] if the move operation fails.
  Future<String> moveFile(String source, String dest);

  /// Renames a file or directory.
  ///
  /// [path] The current path of the file or directory.
  /// [newName] The new name for the file or directory (without path).
  ///
  /// Returns the new path of the renamed file/directory.
  /// Throws [Exception] if renaming fails.
  Future<String> renameFile(String path, String newName);

  /// Gets detailed information about a file or directory.
  ///
  /// [path] The path of the file or directory.
  ///
  /// Returns a [FileItem] with complete information about the file/directory.
  /// Throws [Exception] if the path doesn't exist or access is denied.
  Future<FileItem> getFileInfo(String path);

  /// Calculates the total size of a directory and all its contents.
  ///
  /// [path] The path of the directory to calculate size for.
  ///
  /// Returns the total size in bytes.
  /// Throws [Exception] if the path doesn't exist or access is denied.
  Future<int> calculateDirectorySize(String path);

  /// Gets storage information for the device.
  ///
  /// Returns a [StorageInfo] object with total, used, and free storage.
  /// Throws [Exception] if storage information cannot be retrieved.
  Future<StorageInfo> getStorageInfo();

  /// Searches for files matching the given query.
  ///
  /// [query] The search query (filename pattern).
  /// [rootPath] The root path to search from.
  /// [recursive] Whether to search recursively in subdirectories.
  ///
  /// Returns a list of [FileItem] objects matching the query.
  /// Throws [Exception] if the search fails.
  Future<List<FileItem>> searchFiles({
    required String query,
    required String rootPath,
    bool recursive = true,
  });

  /// Checks if a path exists and is accessible.
  ///
  /// [path] The path to check.
  ///
  /// Returns true if the path exists and is accessible, false otherwise.
  Future<bool> pathExists(String path);

  /// Opens a file using the platform's default application.
  ///
  /// [path] The path of the file to open.
  ///
  /// Throws [Exception] if the file cannot be opened.
  Future<void> openFile(String path);
}

