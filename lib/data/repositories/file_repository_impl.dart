import '../../domain/entities/file_item.dart';
import '../../domain/entities/storage_info.dart';
import '../../domain/repositories/file_repository.dart';
import '../datasources/local_file_datasource.dart';

/// Implementation of [FileRepository] using [LocalFileDataSource].
///
/// This repository implementation provides file operations by delegating
/// to the local file data source, which in turn uses platform-specific services.
class FileRepositoryImpl implements FileRepository {
  /// Creates a new [FileRepositoryImpl] instance.
  ///
  /// [dataSource] The local file data source to use.
  const FileRepositoryImpl(this.dataSource);

  /// The local file data source instance.
  final LocalFileDataSource dataSource;

  @override
  Future<List<String>> getRootDirectories() {
    return dataSource.getRootDirectories();
  }

  @override
  Future<List<FileItem>> listFiles(String path) {
    return dataSource.listFiles(path);
  }

  @override
  Future<String> createDirectory(String path) {
    return dataSource.createDirectory(path);
  }

  @override
  Future<void> deleteFile(String path) {
    return dataSource.deleteFile(path);
  }

  @override
  Future<String> copyFile(String source, String dest) {
    return dataSource.copyFile(source, dest);
  }

  @override
  Future<String> moveFile(String source, String dest) {
    return dataSource.moveFile(source, dest);
  }

  @override
  Future<String> renameFile(String path, String newName) {
    return dataSource.renameFile(path, newName);
  }

  @override
  Future<FileItem> getFileInfo(String path) {
    return dataSource.getFileInfo(path);
  }

  @override
  Future<int> calculateDirectorySize(String path) {
    return dataSource.calculateDirectorySize(path);
  }

  @override
  Future<StorageInfo> getStorageInfo() {
    return dataSource.getStorageInfo();
  }

  @override
  Future<List<FileItem>> searchFiles({
    required String query,
    required String rootPath,
    bool recursive = true,
  }) {
    return dataSource.searchFiles(
      query: query,
      rootPath: rootPath,
      recursive: recursive,
    );
  }

  @override
  Future<bool> pathExists(String path) {
    return dataSource.pathExists(path);
  }

  @override
  Future<void> openFile(String path) {
    return dataSource.openFile(path);
  }
}

