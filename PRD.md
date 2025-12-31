# Product Requirements Document (PRD)
## Project: Libre File Manager
## Version: 1.0.0
## Author: Nikita S.

---

## 1. Vision & Purpose

Libre File Manager is a **fully free, clean, lightweight, no-ads, no-tracking, no-restrictions** file manager built for:
- Android (Redmi Note 8 Pro and above)
- iOS (within Apple sandbox constraints)
- Flutter Web (development & inspection)

The application is built **only for personal and family use**, prioritizing:
- Simplicity
- Transparency
- Performance
- Longevity
- Zero monetization

---

## 2. Core Principles

- No ads
- No telemetry
- No analytics
- No paid features
- No dark patterns
- No unnecessary permissions
- Respect OS security models
- Deterministic, predictable UI

---

## 3. Supported Platforms

### 3.1 Android
- Minimum SDK: Android 9 (API 28)
- Target SDK: Latest stable
- Storage access via:
  - Storage Access Framework (SAF)
  - Scoped Storage
- No root access required

### 3.2 iOS
- iOS 15+
- File access limited to:
  - App sandbox
  - Files app via UIDocumentPicker
- No jailbreak required

### 3.3 Web (Development Only)
- Chrome / Chromium
- Used for:
  - UI inspection
  - Cursor agent adaptation
  - Rapid iteration

---

## 4. Functional Requirements

### 4.1 File Browsing
- Browse directories
- List files with:
  - Name
  - Type
  - Size
  - Modified date
- Grid & list views

### 4.2 File Operations
- Create folder
- Rename
- Delete (with confirmation)
- Copy
- Move
- Multi-select operations

### 4.3 File Opening & Preview
- Open images
- Open text files
- Open PDFs
- Delegate unsupported formats to OS

### 4.4 Search
- Filename search
- Filter by type
- Case-insensitive
- Recursive

### 4.5 Storage Info
- Total storage
- Used storage
- Free storage
- Directory size calculation (async)

### 4.6 Compression
- ZIP creation
- ZIP extraction

### 4.7 Sharing
- Native OS share sheet
- Multiple files supported

---

## 5. Non-Functional Requirements

- Cold start < 500ms on Redmi Note 8 Pro
- Memory usage < 150MB
- Smooth scrolling for 10k+ files
- No background services
- Offline-only by default

---

## 6. Technical Stack

### 6.1 Language & Framework
- Flutter (Dart 3+)

### 6.2 State Management
- Riverpod (preferred)
- Immutable state

### 6.3 Platform APIs
- Android:
  - SAF
  - MediaStore
- iOS:
  - UIDocumentPicker
  - NSFileCoordinator

### 6.4 Packages
- file_picker
- path_provider
- permission_handler
- flutter_archive
- intl
- mime

---

## 7. Architecture

### 7.1 Clean Architecture

```

presentation/  
pages/  
widgets/  
controllers/

domain/  
entities/  
usecases/

data/  
repositories/  
datasources/  
platform/

```

### 7.2 Platform Abstraction
- PlatformFileService (interface)
- AndroidFileService
- IOSFileService
- WebFileService (limited)

---

## 8. UI / UX Design

### 8.1 Design Language
- Minimalist
- Material 3 (Android)
- Cupertino-aware (iOS)
- Neutral color palette

### 8.2 Navigation
- Root folder screen
- Breadcrumb navigation
- Back gesture support

### 8.3 Interactions
- Tap: open
- Long press: select
- Floating Action Button:
  - Create folder
  - Paste
- Context menu per file

---

## 9. User Flow

### 9.1 First Launch
1. App opens
2. Permission explanation screen
3. User selects root directory
4. File browser opens

### 9.2 Browsing
1. User navigates folders
2. Scrolls file list
3. Opens or selects files

### 9.3 Operations
1. Long-press to select
2. Toolbar appears
3. Action executed
4. Snackbar feedback

---

## 10. Error Handling

- Permission denied → explanation screen
- File operation failure → user-friendly message
- Corrupt ZIP → safe abort

---

## 11. Scripts & Tooling

### 11.1 Run
- flutter run
- flutter run -d chrome

### 11.2 Build
- flutter build apk
- flutter build appbundle
- flutter build ios

### 11.3 Linting
- flutter analyze

### 11.4 Formatting
- dart format .

### 11.5 Future Testing
- flutter test
- integration_test
- patrol (e2e)

---

## 12. Out of Scope (v1)
- Cloud sync
- Encryption
- Root features
- Media playback
- Network transfers

---

## 13. Success Criteria

- Replaces default file manager for daily use
- No crashes in normal usage
- Clear, predictable behavior
- Zero external dependencies at runtime
