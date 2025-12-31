import 'package:flutter_riverpod/flutter_riverpod.dart';

/// View mode for displaying files (grid or list).
enum ViewMode {
  /// Grid view mode.
  grid,

  /// List view mode.
  list,
}

/// State for view mode.
class ViewModeState {
  /// The current view mode.
  final ViewMode mode;

  /// Creates a new [ViewModeState] instance.
  const ViewModeState({this.mode = ViewMode.list});

  /// Creates a copy of this state with updated values.
  ViewModeState copyWith({ViewMode? mode}) {
    return ViewModeState(mode: mode ?? this.mode);
  }
}

/// Provider for view mode state.
final viewModeProvider =
    StateNotifierProvider<ViewModeNotifier, ViewModeState>((ref) {
  return ViewModeNotifier();
});

/// Notifier for managing view mode state.
class ViewModeNotifier extends StateNotifier<ViewModeState> {
  /// Creates a new [ViewModeNotifier] instance.
  ViewModeNotifier() : super(const ViewModeState());

  /// Toggles between grid and list view.
  void toggleViewMode() {
    state = state.copyWith(
      mode: state.mode == ViewMode.grid ? ViewMode.list : ViewMode.grid,
    );
  }

  /// Sets the view mode.
  ///
  /// [mode] The view mode to set.
  void setViewMode(ViewMode mode) {
    state = state.copyWith(mode: mode);
  }
}

