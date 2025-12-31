# Android Platform Documentation

This document describes Android-specific implementation details for Local File Manager.

## Storage Access Framework (SAF)

Local File Manager uses SAF for accessing files on Android 10+ (API 29+). This is required due to scoped storage restrictions.

### Implementation

The `AndroidFileService` class implements file operations using:
- Standard file I/O for app-specific directories
- SAF for external storage access
- Permission handling for legacy storage access

### Permissions

Required permissions in `AndroidManifest.xml`:
- `READ_EXTERNAL_STORAGE` (for Android 9 and below)
- `WRITE_EXTERNAL_STORAGE` (for Android 9 and below)
- `MANAGE_EXTERNAL_STORAGE` (for Android 11+)

### Minimum SDK

- **Minimum SDK**: 28 (Android 9)
- **Target SDK**: Latest stable

### File Access

1. **App-specific directories**: Always accessible
2. **External storage**: Requires SAF or user permission
3. **Media files**: Accessible via MediaStore

### Limitations

- Cannot access files outside user-selected directories without SAF
- Root access not supported
- Some system directories are restricted

## Build Configuration

See `android/app/build.gradle.kts` for build configuration:
- `minSdk = 28`
- `targetSdk = flutter.targetSdkVersion`

## Testing on Android

Use Android emulator or physical device:
```bash
flutter run
```

For release builds:
```bash
./scripts/build_android.sh
```

