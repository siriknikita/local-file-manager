import '../../../domain/entities/file_item.dart';
import 'platform_file_service.dart';

/// Web implementation of [PlatformFileService] with limited functionality.
///
/// This implementation provides stub functionality for web platform.
/// Web browsers have severe restrictions on file system access, so this
/// implementation is primarily for UI inspection and development purposes.
class WebFileService implements PlatformFileService {
  /// Creates a new [WebFileService] instance.
  const WebFileService();

  @override
  Future<List<String>> getRootDirectories() async {
    // Web browsers don't have access to the file system
    // Return empty list for web platform
    return <String>[];
  }

  @override
  Future<List<FileItem>> listFiles(String path) async {
    // Web browsers don't have access to the file system
    // Return empty list for web platform
    return <FileItem>[];
  }

  @override
  Future<String> createDirectory(String path) async {
    throw UnimplementedError(
      'Directory creation is not supported on web platform',
    );
  }

  @override
  Future<void> deleteFile(String path) async {
    throw UnimplementedError(
      'File deletion is not supported on web platform',
    );
  }

  @override
  Future<String> copyFile(String source, String dest) async {
    throw UnimplementedError(
      'File copying is not supported on web platform',
    );
  }

  @override
  Future<String> moveFile(String source, String dest) async {
    throw UnimplementedError(
      'File moving is not supported on web platform',
    );
  }

  @override
  Future<String> renameFile(String path, String newName) async {
    throw UnimplementedError(
      'File renaming is not supported on web platform',
    );
  }

  @override
  Future<FileItem> getFileInfo(String path) async {
    throw UnimplementedError(
      'File info retrieval is not supported on web platform',
    );
  }

  @override
  Future<int> calculateDirectorySize(String path) async {
    throw UnimplementedError(
      'Directory size calculation is not supported on web platform',
    );
  }

  @override
  Future<bool> pathExists(String path) async {
    // Web browsers don't have access to the file system
    return false;
  }

  @override
  Future<void> openFile(String path) async {
    throw UnimplementedError(
      'Opening files is not supported on web platform',
    );
  }
}

