import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for file operations (copy/paste).
class FileOperationsState {
  /// The path of the file/directory that was copied.
  final String? copiedPath;

  /// Whether a file operation is in progress.
  final bool isOperationInProgress;

  /// Creates a new [FileOperationsState] instance.
  const FileOperationsState({
    this.copiedPath,
    this.isOperationInProgress = false,
  });

  /// Whether there is a file copied and ready to paste.
  bool get hasCopiedFile => copiedPath != null;

  /// Creates a copy of this state with updated values.
  FileOperationsState copyWith({
    String? copiedPath,
    bool? isOperationInProgress,
  }) {
    return FileOperationsState(
      copiedPath: copiedPath ?? this.copiedPath,
      isOperationInProgress: isOperationInProgress ?? this.isOperationInProgress,
    );
  }
}

/// Provider for file operations state.
final fileOperationsProvider =
    StateNotifierProvider<FileOperationsNotifier, FileOperationsState>((ref) {
  return FileOperationsNotifier();
});

/// Notifier for managing file operations state.
class FileOperationsNotifier extends StateNotifier<FileOperationsState> {
  /// Creates a new [FileOperationsNotifier] instance.
  FileOperationsNotifier() : super(const FileOperationsState());

  /// Copies a file/directory to the clipboard.
  ///
  /// [path] The path of the file/directory to copy.
  void copyFile(String path) {
    state = state.copyWith(copiedPath: path);
  }

  /// Clears the copied file.
  void clearCopiedFile() {
    state = state.copyWith(copiedPath: null);
  }

  /// Sets the operation in progress state.
  void setOperationInProgress(bool inProgress) {
    state = state.copyWith(isOperationInProgress: inProgress);
  }
}

