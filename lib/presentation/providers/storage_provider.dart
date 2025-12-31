import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/storage_info.dart';
import '../../domain/usecases/get_storage_info.dart';
import 'providers.dart';

/// State for storage information.
class StorageState {
  /// The storage information.
  final StorageInfo? storageInfo;

  /// Whether storage info is being loaded.
  final bool isLoading;

  /// Error message if loading failed.
  final String? error;

  /// Creates a new [StorageState] instance.
  const StorageState({
    this.storageInfo,
    this.isLoading = false,
    this.error,
  });

  /// Creates a copy of this state with updated values.
  StorageState copyWith({
    StorageInfo? storageInfo,
    bool? isLoading,
    String? error,
  }) {
    return StorageState(
      storageInfo: storageInfo ?? this.storageInfo,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for the get storage info use case.
final getStorageInfoProvider = Provider<GetStorageInfo>((ref) {
  final repository = ref.watch(fileRepositoryProvider);
  return GetStorageInfo(repository);
});

/// Provider for storage state.
final storageProvider =
    StateNotifierProvider<StorageNotifier, StorageState>((ref) {
  final getStorageInfo = ref.watch(getStorageInfoProvider);
  return StorageNotifier(getStorageInfo);
});

/// Notifier for managing storage state.
class StorageNotifier extends StateNotifier<StorageState> {
  /// Creates a new [StorageNotifier] instance.
  ///
  /// [getStorageInfo] The use case for getting storage info.
  StorageNotifier(this._getStorageInfo) : super(const StorageState());

  /// The get storage info use case.
  final GetStorageInfo _getStorageInfo;

  /// Loads storage information.
  Future<void> loadStorageInfo() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final StorageInfo storageInfo = await _getStorageInfo();
      state = state.copyWith(
        storageInfo: storageInfo,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refreshes storage information.
  Future<void> refresh() async {
    await loadStorageInfo();
  }
}

