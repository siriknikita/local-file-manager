# Repository API

The `FileRepository` interface defines the contract for file operations in the domain layer.

## Interface

```dart
abstract class FileRepository {
  Future<List<String>> getRootDirectories();
  Future<List<FileItem>> listFiles(String path);
  Future<String> createDirectory(String path);
  Future<void> deleteFile(String path);
  Future<String> copyFile(String source, String dest);
  Future<String> moveFile(String source, String dest);
  Future<String> renameFile(String path, String newName);
  Future<FileItem> getFileInfo(String path);
  Future<int> calculateDirectorySize(String path);
  Future<StorageInfo> getStorageInfo();
  Future<List<FileItem>> searchFiles({
    required String query,
    required String rootPath,
    bool recursive = true,
  });
  Future<bool> pathExists(String path);
  Future<void> openFile(String path);
}
```

## Methods

All methods follow the same pattern as `PlatformFileService`, with the addition of:

### getStorageInfo()
Gets storage information for the device.

**Returns**: `Future<StorageInfo>` - Storage information with total, used, and free space

**Throws**: `Exception` if storage information cannot be retrieved

### searchFiles()
Searches for files matching the given query.

**Parameters**:
- `query` (String): The search query (filename pattern)
- `rootPath` (String): The root path to search from
- `recursive` (bool): Whether to search recursively (default: true)

**Returns**: `Future<List<FileItem>>` - List of matching files

**Throws**: `Exception` if the search fails

## Implementation

The `FileRepositoryImpl` class implements this interface using `LocalFileDataSource`, which in turn uses platform-specific services.

