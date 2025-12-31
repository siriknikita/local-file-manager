import 'package:local_file_manager/domain/entities/file_item.dart';

/// Abstract interface for platform-specific file operations.
///
/// This interface provides a unified API for file operations across
/// different platforms (Android, iOS, Web). Each platform implements
/// this interface using platform-specific APIs:
/// - Android: Storage Access Framework (SAF)
/// - iOS: UIDocumentPicker and NSFileCoordinator
/// - Web: Limited functionality for UI inspection
abstract class PlatformFileService {
  /// Gets the root directories available for browsing.
  ///
  /// Returns a list of root directory paths that the user can access.
  /// On Android, this uses SAF to get accessible storage roots.
  /// On iOS, this returns the app sandbox and any document picker locations.
  /// On Web, returns empty list.
  ///
  /// Returns a list of root directory paths.
  /// Throws [PlatformException] if access is denied or unavailable.
  Future<List<String>> getRootDirectories();

  /// Lists all files and directories in the specified path.
  ///
  /// [path] The directory path to list contents from.
  ///
  /// Returns a list of [FileItem] objects representing files and directories.
  /// Directories are sorted first, then files, both alphabetically.
  /// Throws [PlatformException] if the path doesn't exist or access is denied.
  Future<List<FileItem>> listFiles(String path);

  /// Creates a new directory at the specified path.
  ///
  /// [path] The full path where the directory should be created.
  ///
  /// Returns the path of the created directory.
  /// Throws [PlatformException] if the directory cannot be created.
  Future<String> createDirectory(String path);

  /// Deletes a file or directory at the specified path.
  ///
  /// [path] The path of the file or directory to delete.
  ///
  /// Throws [PlatformException] if deletion fails or access is denied.
  Future<void> deleteFile(String path);

  /// Copies a file or directory from source to destination.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be copied.
  ///
  /// Returns the path of the copied file/directory.
  /// Throws [PlatformException] if the copy operation fails.
  Future<String> copyFile(String source, String dest);

  /// Moves a file or directory from source to destination.
  ///
  /// [source] The path of the source file or directory.
  /// [dest] The destination path where the file/directory should be moved.
  ///
  /// Returns the path of the moved file/directory.
  /// Throws [PlatformException] if the move operation fails.
  Future<String> moveFile(String source, String dest);

  /// Renames a file or directory.
  ///
  /// [path] The current path of the file or directory.
  /// [newName] The new name for the file or directory (without path).
  ///
  /// Returns the new path of the renamed file/directory.
  /// Throws [PlatformException] if renaming fails.
  Future<String> renameFile(String path, String newName);

  /// Gets detailed information about a file or directory.
  ///
  /// [path] The path of the file or directory.
  ///
  /// Returns a [FileItem] with complete information about the file/directory.
  /// Throws [PlatformException] if the path doesn't exist or access is denied.
  Future<FileItem> getFileInfo(String path);

  /// Calculates the total size of a directory and all its contents.
  ///
  /// [path] The path of the directory to calculate size for.
  ///
  /// Returns the total size in bytes.
  /// Throws [PlatformException] if the path doesn't exist or access is denied.
  Future<int> calculateDirectorySize(String path);

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
  /// Throws [PlatformException] if the file cannot be opened.
  Future<void> openFile(String path);
}

