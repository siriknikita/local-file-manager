# iOS Platform Documentation

This document describes iOS-specific implementation details for Local File Manager.

## File Access

Local File Manager works within iOS sandbox constraints:

### App Sandbox
- Full access to app-specific directories
- Documents directory
- Temporary directory

### External Files
- Access via UIDocumentPicker
- User must select files/directories
- Access persists for selected locations

### Implementation

The `IOSFileService` class implements file operations using:
- NSFileManager for sandbox operations
- UIDocumentPicker for external file access
- NSFileCoordinator for file coordination

## Configuration

### Info.plist Settings

Required keys in `ios/Runner/Info.plist`:
- `UISupportsDocumentBrowser`: true
- `UIFileSharingEnabled`: true
- `LSSupportsOpeningDocumentsInPlace`: true

### Minimum iOS Version

- **Minimum iOS**: 15.0

## Limitations

- Cannot access files outside app sandbox without user selection
- No root access
- System directories are restricted
- File operations require proper permissions

## Build Configuration

iOS builds require:
- macOS
- Xcode
- Apple Developer account (for device deployment)

## Testing on iOS

Use iOS Simulator or physical device:
```bash
flutter run
```

For release builds:
```bash
./scripts/build_ios.sh
```

