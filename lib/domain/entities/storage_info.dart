/// Represents storage information for a device or directory.
///
/// This entity contains information about total, used, and free storage
/// space, as well as the size of a specific directory if applicable.
class StorageInfo {
  /// Total storage space in bytes.
  final int totalBytes;

  /// Used storage space in bytes.
  final int usedBytes;

  /// Free storage space in bytes.
  final int freeBytes;

  /// The size of a specific directory in bytes, if calculated.
  final int? directorySizeBytes;

  /// Creates a new [StorageInfo] instance.
  ///
  /// [totalBytes] Total storage space in bytes.
  /// [usedBytes] Used storage space in bytes.
  /// [freeBytes] Free storage space in bytes.
  /// [directorySizeBytes] Optional directory size in bytes.
  const StorageInfo({
    required this.totalBytes,
    required this.usedBytes,
    required this.freeBytes,
    this.directorySizeBytes,
  });

  /// Gets the total storage space in gigabytes.
  double get totalGB => totalBytes / (1024 * 1024 * 1024);

  /// Gets the used storage space in gigabytes.
  double get usedGB => usedBytes / (1024 * 1024 * 1024);

  /// Gets the free storage space in gigabytes.
  double get freeGB => freeBytes / (1024 * 1024 * 1024);

  /// Gets the directory size in gigabytes, if available.
  double? get directorySizeGB =>
      directorySizeBytes != null
          ? directorySizeBytes! / (1024 * 1024 * 1024)
          : null;

  /// Gets the percentage of storage used (0.0 to 1.0).
  double get usedPercentage => totalBytes > 0 ? usedBytes / totalBytes : 0.0;

  /// Gets the percentage of storage free (0.0 to 1.0).
  double get freePercentage => totalBytes > 0 ? freeBytes / totalBytes : 0.0;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StorageInfo &&
        other.totalBytes == totalBytes &&
        other.usedBytes == usedBytes &&
        other.freeBytes == freeBytes &&
        other.directorySizeBytes == directorySizeBytes;
  }

  @override
  int get hashCode {
    return Object.hash(
      totalBytes,
      usedBytes,
      freeBytes,
      directorySizeBytes,
    );
  }

  @override
  String toString() {
    return 'StorageInfo(total: ${totalGB.toStringAsFixed(2)} GB, '
        'used: ${usedGB.toStringAsFixed(2)} GB, '
        'free: ${freeGB.toStringAsFixed(2)} GB, '
        'directorySize: ${directorySizeGB?.toStringAsFixed(2) ?? 'N/A'} GB)';
  }
}

