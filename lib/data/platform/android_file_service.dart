import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:local_file_manager/domain/entities/file_item.dart';
import 'package:local_file_manager/data/platform/platform_file_service.dart';

/// Android implementation of [PlatformFileService] using Storage Access Framework (SAF).
///
/// This implementation uses SAF for accessing files on Android, which is required
/// for Android 10+ (API 29+) due to scoped storage restrictions.
class AndroidFileService implements PlatformFileService {
  /// Creates a new [AndroidFileService] instance.
  const AndroidFileService();

  @override
  Future<List<String>> getRootDirectories() async {
    try {
      final List<String> roots = [];

      // Get app-specific directories
      final Directory? appDir = await getApplicationDocumentsDirectory();
      if (appDir != null) {
        roots.add(appDir.path);
      }

      final Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        roots.add(externalDir.path);
      }

      // Get external storage directories
      final Directory? downloadsDir = await getDownloadsDirectory();
      if (downloadsDir != null) {
        roots.add(downloadsDir.path);
      }

      // Request SAF access for additional directories
      // Note: This requires user interaction via file picker
      return roots;
    } catch (e) {
      throw Exception('Failed to get root directories: $e');
    }
  }

  @override
  Future<List<FileItem>> listFiles(String path) async {
    try {
      final Directory dir = Directory(path);
      if (!await dir.exists()) {
        throw Exception('Directory does not exist: $path');
      }

      // Check if directory is accessible before attempting to list
      if (!await _isDirectoryAccessible(dir)) {
        throw Exception(
          'Permission denied: Cannot access directory "$path". This directory may be protected by the system.',
        );
      }

      final List<FileItem> items = [];

      // Use async list() instead of listSync() for better error handling
      try {
        await for (final FileSystemEntity entity in dir.list()) {
          try {
            final FileStat stat = await entity.stat();
            final bool isDirectory = stat.type == FileSystemEntityType.directory;

            items.add(
              isDirectory
                  ? FileItem.directory(
                      name: entity.path.split('/').last,
                      path: entity.path,
                      modifiedDate: stat.modified,
                    )
                  : FileItem.file(
                      name: entity.path.split('/').last,
                      path: entity.path,
                      size: stat.size,
                      mimeType: _getMimeType(entity.path),
                      modifiedDate: stat.modified,
                    ),
            );
          } on FileSystemException catch (e) {
            // Skip individual items that can't be accessed
            // This allows listing to continue even if some items are inaccessible
            if (e.osError?.errorCode == 13) {
              // Permission denied for this specific item, skip it
              continue;
            }
            // Re-throw other file system exceptions
            rethrow;
          } catch (e) {
            // Skip items that cause other errors during stat
            continue;
          }
        }
      } on FileSystemException catch (e) {
        // Handle permission errors at the directory level
        if (e.osError?.errorCode == 13) {
          throw Exception(
            'Permission denied: Cannot list contents of "$path". This directory may be protected by the system.',
          );
        }
        // Re-throw other file system exceptions with context
        throw Exception('Failed to list files in "$path": ${e.message}');
      }

      // Sort: directories first, then files, both alphabetically
      items.sort((a, b) {
        if (a.isDirectory && !b.isDirectory) return -1;
        if (!a.isDirectory && b.isDirectory) return 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return items;
    } on Exception {
      // Re-throw our custom exceptions as-is
      rethrow;
    } catch (e) {
      throw Exception('Failed to list files in "$path": $e');
    }
  }

  @override
  Future<String> createDirectory(String path) async {
    try {
      final Directory dir = Directory(path);
      if (await dir.exists()) {
        throw Exception('Directory already exists: $path');
      }

      await dir.create(recursive: true);
      return path;
    } catch (e) {
      throw Exception('Failed to create directory: $e');
    }
  }

  @override
  Future<void> deleteFile(String path) async {
    try {
      final File file = File(path);
      final Directory dir = Directory(path);
      
      if (await file.exists()) {
        await file.delete();
      } else if (await dir.exists()) {
        await dir.delete(recursive: true);
      } else {
        throw Exception('File or directory does not exist: $path');
      }
    } catch (e) {
      throw Exception('Failed to delete file: $e');
    }
  }

  @override
  Future<String> copyFile(String source, String dest) async {
    try {
      final File sourceFile = File(source);
      final Directory sourceDir = Directory(source);
      
      if (await sourceDir.exists()) {
        // Copy directory recursively
        await _copyDirectory(sourceDir, Directory(dest));
        return dest;
      } else if (await sourceFile.exists()) {
        // Copy file
        final File destFile = File(dest);
        await sourceFile.copy(destFile.path);
        return dest;
      } else {
        throw Exception('Source does not exist: $source');
      }
    } catch (e) {
      throw Exception('Failed to copy file: $e');
    }
  }

  @override
  Future<String> moveFile(String source, String dest) async {
    try {
      final File sourceFile = File(source);
      final Directory sourceDir = Directory(source);
      
      if (await sourceDir.exists()) {
        await sourceDir.rename(dest);
        return dest;
      } else if (await sourceFile.exists()) {
        await sourceFile.rename(dest);
        return dest;
      } else {
        throw Exception('Source does not exist: $source');
      }
    } catch (e) {
      throw Exception('Failed to move file: $e');
    }
  }

  @override
  Future<String> renameFile(String path, String newName) async {
    try {
      final File file = File(path);
      final Directory dir = Directory(path);
      
      final String parentPath = path.substring(0, path.lastIndexOf('/'));
      final String newPath = '$parentPath/$newName';
      
      if (await dir.exists()) {
        await dir.rename(newPath);
        return newPath;
      } else if (await file.exists()) {
        await file.rename(newPath);
        return newPath;
      } else {
        throw Exception('File or directory does not exist: $path');
      }
    } catch (e) {
      throw Exception('Failed to rename file: $e');
    }
  }

  @override
  Future<FileItem> getFileInfo(String path) async {
    try {
      final File file = File(path);
      final Directory dir = Directory(path);
      
      if (await dir.exists()) {
        final FileStat stat = await dir.stat();
        return FileItem.directory(
          name: path.split('/').last,
          path: path,
          modifiedDate: stat.modified,
        );
      } else if (await file.exists()) {
        final FileStat stat = await file.stat();
        return FileItem.file(
          name: path.split('/').last,
          path: path,
          size: stat.size,
          mimeType: _getMimeType(path),
          modifiedDate: stat.modified,
        );
      } else {
        throw Exception('File or directory does not exist: $path');
      }
    } catch (e) {
      throw Exception('Failed to get file info: $e');
    }
  }

  @override
  Future<int> calculateDirectorySize(String path) async {
    try {
      final Directory dir = Directory(path);
      if (!await dir.exists()) {
        throw Exception('Directory does not exist: $path');
      }

      int totalSize = 0;
      await for (final FileSystemEntity entity in dir.list(recursive: true)) {
        if (entity is File) {
          final FileStat stat = await entity.stat();
          totalSize += stat.size;
        }
      }

      return totalSize;
    } catch (e) {
      throw Exception('Failed to calculate directory size: $e');
    }
  }

  @override
  Future<bool> pathExists(String path) async {
    try {
      final File file = File(path);
      final Directory dir = Directory(path);
      return await file.exists() || await dir.exists();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> openFile(String path) async {
    // On Android, we delegate to the system to open files
    // This would typically use an Intent to open the file
    // For now, we'll throw an exception indicating this needs platform-specific implementation
    throw UnimplementedError(
      'Opening files on Android requires platform-specific implementation using Intents',
    );
  }

  /// Copies a directory recursively.
  Future<void> _copyDirectory(Directory source, Directory destination) async {
    await destination.create(recursive: true);

    await for (final FileSystemEntity entity in source.list()) {
      if (entity is Directory) {
        await _copyDirectory(
          entity,
          Directory('${destination.path}/${entity.path.split('/').last}'),
        );
      } else if (entity is File) {
        await entity.copy('${destination.path}/${entity.path.split('/').last}');
      }
    }
  }

  /// Checks if a directory is accessible for reading.
  ///
  /// Returns true if the directory can be accessed, false otherwise.
  /// This method attempts to check directory accessibility by trying
  /// to stat the directory and checking for permission errors.
  Future<bool> _isDirectoryAccessible(Directory dir) async {
    try {
      if (!await dir.exists()) {
        return false;
      }

      // Try to stat the directory to check if we have read access
      try {
        await dir.stat();
        // If stat succeeds, the directory is at least partially accessible
        // We'll let the actual list() call handle any remaining permission issues
        return true;
      } on FileSystemException catch (e) {
        // Check if it's a permission error (errno 13)
        if (e.osError?.errorCode == 13) {
          return false;
        }
        // Other file system errors might be transient, assume accessible
        // The actual list() call will handle these more precisely
        return true;
      }
    } catch (e) {
      // If any unexpected error occurs, assume not accessible
      return false;
    }
  }

  /// Gets the MIME type for a file based on its extension.
  String? _getMimeType(String path) {
    final String extension = path.split('.').last.toLowerCase();
    final Map<String, String> mimeTypes = {
      'txt': 'text/plain',
      'pdf': 'application/pdf',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
      'gif': 'image/gif',
      'zip': 'application/zip',
      'mp4': 'video/mp4',
      'mp3': 'audio/mpeg',
    };
    return mimeTypes[extension];
  }
}

