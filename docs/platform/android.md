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
- `READ_EXTERNAL_STORAGE` (for Android 9-10, maxSdkVersion="32")
- `WRITE_EXTERNAL_STORAGE` (for Android 9-10, maxSdkVersion="32")
- `MANAGE_EXTERNAL_STORAGE` (for Android 11+)

**Permission Request Behavior:**

- **Android 9-10 (API 28-29)**: 
  - Uses `Permission.storage` which covers both READ and WRITE
  - Can be requested programmatically via standard permission dialog
  - Permissions appear in app settings after granting

- **Android 11+ (API 30+)**:
  - Uses `MANAGE_EXTERNAL_STORAGE` permission
  - **Cannot be requested programmatically** - must be enabled manually in system settings
  - App automatically detects Android 11+ and guides users to Settings > Apps > [App Name] > Permissions
  - Users must enable "Allow access to manage all files" toggle
  - App checks permission status after user returns from settings

**Permission Service:**
- Location: `lib/data/services/permission_service.dart`
- Automatically detects Android version and uses appropriate permission flow
- Provides methods to check permission status, request permissions, and open settings

### Minimum SDK

- **Minimum SDK**: 28 (Android 9)
- **Target SDK**: Latest stable

### File Access

1. **App-specific directories**: Always accessible (no permissions needed)
2. **External storage**: 
   - Android 9-10: Requires `READ_EXTERNAL_STORAGE` and `WRITE_EXTERNAL_STORAGE` permissions
   - Android 11+: Requires `MANAGE_EXTERNAL_STORAGE` permission (enabled in system settings)
3. **Media files**: Accessible via MediaStore (with appropriate permissions)
4. **Root directory access**: App uses `getRootDirectories()` to get accessible directories instead of accessing '/' directly

**Root Directories:**
- App-specific documents directory
- External storage directory (if available)
- Downloads directory (if available)
- Additional directories via Storage Access Framework (SAF)

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

