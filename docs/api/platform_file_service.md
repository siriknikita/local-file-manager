# Platform File Service API

The `PlatformFileService` interface provides a unified API for file operations across different platforms.

## Interface

```dart
abstract class PlatformFileService {
  Future<List<String>> getRootDirectories();
  Future<List<FileItem>> listFiles(String path);
  Future<String> createDirectory(String path);
  Future<void> deleteFile(String path);
  Future<String> copyFile(String source, String dest);
  Future<String> moveFile(String source, String dest);
  Future<String> renameFile(String path, String newName);
  Future<FileItem> getFileInfo(String path);
  Future<int> calculateDirectorySize(String path);
  Future<bool> pathExists(String path);
  Future<void> openFile(String path);
}
```

## Methods

### getRootDirectories()
Returns a list of root directory paths available for browsing.

**Returns**: `Future<List<String>>` - List of root directory paths

**Throws**: `Exception` if access is denied or unavailable

### listFiles(String path)
Lists all files and directories in the specified path.

**Parameters**:
- `path` (String): The directory path to list contents from

**Returns**: `Future<List<FileItem>>` - List of files and directories

**Throws**: `Exception` if the path doesn't exist or access is denied

### createDirectory(String path)
Creates a new directory at the specified path.

**Parameters**:
- `path` (String): The full path where the directory should be created

**Returns**: `Future<String>` - Path of the created directory

**Throws**: `Exception` if the directory cannot be created

### deleteFile(String path)
Deletes a file or directory at the specified path.

**Parameters**:
- `path` (String): The path of the file or directory to delete

**Throws**: `Exception` if deletion fails or access is denied

### copyFile(String source, String dest)
Copies a file or directory from source to destination.

**Parameters**:
- `source` (String): The path of the source file or directory
- `dest` (String): The destination path

**Returns**: `Future<String>` - Path of the copied file/directory

**Throws**: `Exception` if the copy operation fails

### moveFile(String source, String dest)
Moves a file or directory from source to destination.

**Parameters**:
- `source` (String): The path of the source file or directory
- `dest` (String): The destination path

**Returns**: `Future<String>` - Path of the moved file/directory

**Throws**: `Exception` if the move operation fails

### renameFile(String path, String newName)
Renames a file or directory.

**Parameters**:
- `path` (String): The current path of the file or directory
- `newName` (String): The new name (without path)

**Returns**: `Future<String>` - New path of the renamed file/directory

**Throws**: `Exception` if renaming fails

### getFileInfo(String path)
Gets detailed information about a file or directory.

**Parameters**:
- `path` (String): The path of the file or directory

**Returns**: `Future<FileItem>` - File information

**Throws**: `Exception` if the path doesn't exist or access is denied

### calculateDirectorySize(String path)
Calculates the total size of a directory and all its contents.

**Parameters**:
- `path` (String): The path of the directory

**Returns**: `Future<int>` - Total size in bytes

**Throws**: `Exception` if the path doesn't exist or access is denied

### pathExists(String path)
Checks if a path exists and is accessible.

**Parameters**:
- `path` (String): The path to check

**Returns**: `Future<bool>` - True if path exists, false otherwise

### openFile(String path)
Opens a file using the platform's default application.

**Parameters**:
- `path` (String): The path of the file to open

**Throws**: `Exception` if the file cannot be opened

