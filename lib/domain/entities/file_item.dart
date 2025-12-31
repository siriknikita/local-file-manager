/// Represents a file or directory in the file system.
///
/// This entity contains all information about a file or directory
/// including its name, path, size, type, and modification date.
class FileItem {
  /// The name of the file or directory.
  final String name;

  /// The full path of the file or directory.
  final String path;

  /// The size of the file in bytes. For directories, this is typically 0
  /// unless the size has been calculated.
  final int size;

  /// Whether this item is a directory.
  final bool isDirectory;

  /// The MIME type of the file, or null if unknown or if it's a directory.
  final String? mimeType;

  /// The date and time when the file was last modified.
  final DateTime modifiedDate;

  /// Creates a new [FileItem] instance.
  ///
  /// [name] The name of the file or directory.
  /// [path] The full path of the file or directory.
  /// [size] The size in bytes (0 for directories unless calculated).
  /// [isDirectory] Whether this item is a directory.
  /// [mimeType] The MIME type of the file, or null for directories.
  /// [modifiedDate] The last modification date and time.
  const FileItem({
    required this.name,
    required this.path,
    required this.size,
    required this.isDirectory,
    this.mimeType,
    required this.modifiedDate,
  });

  /// Creates a [FileItem] for a directory.
  ///
  /// [name] The name of the directory.
  /// [path] The full path of the directory.
  /// [modifiedDate] The last modification date and time.
  factory FileItem.directory({
    required String name,
    required String path,
    required DateTime modifiedDate,
  }) {
    return FileItem(
      name: name,
      path: path,
      size: 0,
      isDirectory: true,
      mimeType: null,
      modifiedDate: modifiedDate,
    );
  }

  /// Creates a [FileItem] for a file.
  ///
  /// [name] The name of the file.
  /// [path] The full path of the file.
  /// [size] The size in bytes.
  /// [mimeType] The MIME type of the file.
  /// [modifiedDate] The last modification date and time.
  factory FileItem.file({
    required String name,
    required String path,
    required int size,
    String? mimeType,
    required DateTime modifiedDate,
  }) {
    return FileItem(
      name: name,
      path: path,
      size: size,
      isDirectory: false,
      mimeType: mimeType,
      modifiedDate: modifiedDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileItem &&
        other.path == path &&
        other.name == name &&
        other.size == size &&
        other.isDirectory == isDirectory &&
        other.mimeType == mimeType &&
        other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return Object.hash(
      path,
      name,
      size,
      isDirectory,
      mimeType,
      modifiedDate,
    );
  }

  @override
  String toString() {
    return 'FileItem(name: $name, path: $path, size: $size, '
        'isDirectory: $isDirectory, mimeType: $mimeType, '
        'modifiedDate: $modifiedDate)';
  }
}

