# Use Cases Documentation

Use cases encapsulate business logic and coordinate between repositories and the presentation layer.

## Available Use Cases

### BrowseDirectory
Browses a directory and lists its contents.

**Usage**:
```dart
final useCase = BrowseDirectory(repository);
final files = await useCase('/path/to/directory');
```

### CreateFolder
Creates a new folder/directory.

**Usage**:
```dart
final useCase = CreateFolder(repository);
final path = await useCase('/path/to/new/folder');
```

### DeleteFile
Deletes a file or directory.

**Usage**:
```dart
final useCase = DeleteFile(repository);
await useCase('/path/to/file');
```

### CopyFile
Copies a file or directory.

**Usage**:
```dart
final useCase = CopyFile(repository);
final newPath = await useCase('/source/path', '/dest/path');
```

### MoveFile
Moves a file or directory.

**Usage**:
```dart
final useCase = MoveFile(repository);
final newPath = await useCase('/source/path', '/dest/path');
```

### RenameFile
Renames a file or directory.

**Usage**:
```dart
final useCase = RenameFile(repository);
final newPath = await useCase('/old/path', 'newName');
```

### SearchFiles
Searches for files by name.

**Usage**:
```dart
final useCase = SearchFiles(repository);
final results = await useCase(
  query: 'search term',
  rootPath: '/search/root',
  recursive: true,
);
```

### GetStorageInfo
Gets storage information.

**Usage**:
```dart
final useCase = GetStorageInfo(repository);
final info = await useCase();
```

### CreateZip
Creates a ZIP archive from selected files.

**Usage**:
```dart
final useCase = CreateZip(repository);
final zipPath = await useCase(
  filePaths: ['/file1', '/file2'],
  zipPath: '/output.zip',
);
```

### ExtractZip
Extracts a ZIP archive.

**Usage**:
```dart
final useCase = ExtractZip(repository);
final destPath = await useCase(
  zipPath: '/archive.zip',
  destPath: '/extract/to',
);
```

### CheckPermissions
Checks if storage permissions are granted.

**Usage**:
```dart
final useCase = CheckPermissions(permissionService);
final hasPermission = await useCase();
```

### RequestPermissions
Requests storage permissions from the user.

**Usage**:
```dart
final useCase = RequestPermissions(permissionService);
final granted = await useCase();
```

## Use Case Pattern

All use cases follow this pattern:
1. Accept a repository in the constructor
2. Provide a `call()` method that executes the use case
3. Return domain entities or throw exceptions
4. Are stateless and can be reused

