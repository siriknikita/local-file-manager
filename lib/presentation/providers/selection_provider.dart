import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State for file selection (multi-select mode).
class SelectionState {
  /// The set of selected file paths.
  final Set<String> selectedPaths;

  /// Whether selection mode is active.
  final bool isSelectionMode;

  /// Creates a new [SelectionState] instance.
  const SelectionState({
    this.selectedPaths = const {},
    this.isSelectionMode = false,
  });

  /// Whether any files are selected.
  bool get hasSelection => selectedPaths.isNotEmpty;

  /// The number of selected files.
  int get selectionCount => selectedPaths.length;

  /// Creates a copy of this state with updated values.
  SelectionState copyWith({
    Set<String>? selectedPaths,
    bool? isSelectionMode,
  }) {
    return SelectionState(
      selectedPaths: selectedPaths ?? this.selectedPaths,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
    );
  }
}

/// Provider for selection state.
final selectionProvider =
    StateNotifierProvider<SelectionNotifier, SelectionState>((ref) {
  return SelectionNotifier();
});

/// Notifier for managing selection state.
class SelectionNotifier extends StateNotifier<SelectionState> {
  /// Creates a new [SelectionNotifier] instance.
  SelectionNotifier() : super(const SelectionState());

  /// Toggles selection mode on/off.
  void toggleSelectionMode() {
    state = state.copyWith(
      isSelectionMode: !state.isSelectionMode,
      selectedPaths: state.isSelectionMode ? {} : state.selectedPaths,
    );
  }

  /// Toggles the selection of a file.
  ///
  /// [path] The path of the file to toggle selection for.
  void toggleSelection(String path) {
    final Set<String> newSelection = Set<String>.from(state.selectedPaths);
    if (newSelection.contains(path)) {
      newSelection.remove(path);
    } else {
      newSelection.add(path);
    }

    state = state.copyWith(selectedPaths: newSelection);
  }

  /// Selects a file.
  ///
  /// [path] The path of the file to select.
  void selectFile(String path) {
    final Set<String> newSelection = Set<String>.from(state.selectedPaths);
    newSelection.add(path);
    state = state.copyWith(selectedPaths: newSelection);
  }

  /// Deselects a file.
  ///
  /// [path] The path of the file to deselect.
  void deselectFile(String path) {
    final Set<String> newSelection = Set<String>.from(state.selectedPaths);
    newSelection.remove(path);
    state = state.copyWith(selectedPaths: newSelection);
  }

  /// Clears all selections.
  void clearSelection() {
    state = state.copyWith(selectedPaths: {});
  }

  /// Selects all files in the current directory.
  ///
  /// [paths] The list of all file paths in the current directory.
  void selectAll(List<String> paths) {
    state = state.copyWith(selectedPaths: paths.toSet());
  }
}

