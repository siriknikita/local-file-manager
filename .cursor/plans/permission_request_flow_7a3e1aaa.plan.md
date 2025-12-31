---
name: Permission Request Flow
overview: Implement a permission request dialog that appears when the app launches if storage permissions are not granted. The dialog will explain why permissions are needed and provide a button to grant them, following standard mobile app patterns.
todos: []
---

# Permission Request Flow Implementation

## Overview

Add a permission request dialog that appears on app launch when storage permissions are not granted. The dialog will explain why permissions are needed and provide a button to request them, following standard mobile app patterns.

## Architecture

The implementation will follow the existing clean architecture pattern:

```javascript
lib/
  domain/
    usecases/
      check_permissions.dart (new)
      request_permissions.dart (new)
  data/
    services/
      permission_service.dart (new)
  presentation/
    widgets/
      permission_dialog.dart (new)
    pages/
      home_page.dart (update)
```



## Implementation Details

### 1. Permission Service (`lib/data/services/permission_service.dart`)

Create a platform-agnostic service that wraps `permission_handler`:

- Check storage permissions status

- Request storage permissions

- Handle platform-specific permission types:

- Android: `Permission.storage` (or `Permission.manageExternalStorage` for Android 11+)

- iOS: No runtime permissions needed (uses UIDocumentPicker)
- Web: No permissions needed

### 2. Use Cases

**Check Permissions Use Case** (`lib/domain/usecases/check_permissions.dart`):

- Check if required permissions are granted
- Return boolean result

**Request Permissions Use Case** (`lib/domain/usecases/request_permissions.dart`):

- Request permissions from the user

- Return permission status result

### 3. Permission Dialog Widget (`lib/presentation/widgets/permission_dialog.dart`)

Create a Material Design dialog that:

- Shows an explanation of why permissions are needed

- Displays a prominent "Allow" or "Grant Permissions" button
- Handles the permission request when button is clicked

- Shows appropriate messaging based on permission status

- Can be dismissed (but will reappear if permissions not granted)

### 4. Update HomePage (`lib/presentation/pages/home_page.dart`)

Modify the initialization flow to:

- Check permissions on app launch

- Show permission dialog if permissions not granted

- Navigate to file browser only after permissions are granted (or user dismisses)

- Handle permission denial gracefully with retry option

## Platform-Specific Considerations

### Android

- Request `Permission.storage` for Android 9 and below

- For Android 11+, may need `Permission.manageExternalStorage` (requires special handling)
- Handle permission denial with explanation

### iOS

- No runtime permissions needed for file access (uses UIDocumentPicker)

- Permission dialog may not be necessary, but can check for Photos permission if needed in future

- For now, iOS can skip permission check

### Web

- No permissions needed

- Skip permission check

## User Flow

1. App launches → HomePage loads
2. HomePage checks permissions
3. If not granted → Show permission dialog

4. User clicks "Allow" button → Request permissions

5. If granted → Navigate to FileBrowserPage

6. If denied → Show message with retry option

7. If already granted → Navigate directly to FileBrowserPage

## Files to Create

- `lib/data/services/permission_service.dart` - Platform-agnostic permission service

- `lib/domain/usecases/check_permissions.dart` - Check permissions use case

- `lib/domain/usecases/request_permissions.dart` - Request permissions use case

- `lib/presentation/widgets/permission_dialog.dart` - Permission request dialog widget

## Files to Update

- `lib/presentation/pages/home_page.dart` - Add permission checking and dialog display logic

## Testing Considerations

- Test on Android device/emulator with different Android versions

- Test permission denial flow

- Test permission grant flow

- Verify dialog appears on first launch