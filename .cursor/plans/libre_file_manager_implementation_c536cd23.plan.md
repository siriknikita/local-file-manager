---
name: Local File Manager Implementation
overview: Implement a complete Flutter file manager app following Clean Architecture with Riverpod state management, platform-specific file access (Android SAF, iOS Document Picker), and all core features including browsing, operations, search, ZIP support, and storage info.
todos:
  - id: init_project
    content: Initialize Flutter project and configure pubspec.yaml with all required dependencies
    status: pending
  - id: create_structure
    content: Create Clean Architecture directory structure (presentation, domain, data layers)
    status: pending
    dependencies:
      - init_project
  - id: configure_linting
    content: Create strict analysis_options.yaml with all linter rules enabled
    status: pending
    dependencies:
      - init_project
  - id: platform_abstraction
    content: Implement platform abstraction layer (PlatformFileService interface and Android/iOS/Web implementations)
    status: pending
    dependencies:
      - create_structure
  - id: domain_layer
    content: Create domain entities, repository interfaces, and all use cases
    status: pending
    dependencies:
      - create_structure
  - id: data_layer
    content: Implement data layer with repository implementation and data sources
    status: pending
    dependencies:
      - platform_abstraction
      - domain_layer
  - id: riverpod_providers
    content: Create all Riverpod providers for state management (file browser, operations, selection, search, storage, view mode)
    status: pending
    dependencies:
      - data_layer
  - id: ui_pages
    content: Implement main UI pages (home, file browser, preview)
    status: pending
    dependencies:
      - riverpod_providers
  - id: ui_widgets
    content: Create all reusable UI widgets (file items, breadcrumbs, context menus, toolbars, etc.)
    status: pending
    dependencies:
      - ui_pages
  - id: file_operations
    content: Implement all file operations (create, rename, delete, copy, move) with error handling
    status: pending
    dependencies:
      - ui_widgets
  - id: search_filtering
    content: Implement search and filtering functionality with recursive search
    status: pending
    dependencies:
      - file_operations
  - id: zip_support
    content: Implement ZIP creation and extraction with progress tracking
    status: pending
    dependencies:
      - file_operations
  - id: storage_info
    content: Implement storage info calculation and display
    status: pending
    dependencies:
      - file_operations
  - id: platform_config
    content: Configure Android (SAF) and iOS (Document Picker) platform-specific settings
    status: pending
    dependencies:
      - platform_abstraction
  - id: error_handling
    content: Implement comprehensive error handling with user-friendly messages
    status: pending
    dependencies:
      - ui_widgets
  - id: scripts
    content: Create all shell scripts for run, build, lint, and format operations
    status: pending
    dependencies:
      - init_project
  - id: test_structure
    content: Create test directory structure (unit, integration, e2e)
    status: pending
    dependencies:
      - init_project
  - id: documentation
    content: Create docs/ folder structure, write all documentation files with mermaid diagrams, create .cursorrules file, and update README.md
    status: pending
    dependencies:
      - init_project
  - id: code_documentation
    content: Add comprehensive Dart doc comments to all public classes, methods, and properties throughout the codebase
    status: pending
    dependencies:
      - platform_abstraction
      - domain_layer
      - data_layer
      - riverpod_providers
      - ui_pages
      - ui_widgets
  - id: final_cleanup
    content: Remove TODOs, verify no commented code, run linting, ensure compilation success, verify all documentation is up-to-date
    status: pending
    dependencies:
      - storage_info
      - zip_support
      - search_filtering
      - error_handling
      - platform_config
      - code_documentation
      - documentation
---

# Local File Manager - Implementation Plan

## Architecture Overview

The app follows Clean Architecture with three layers:

```javascript
lib/
├── presentation/          # UI layer
│   ├── pages/            # Screen widgets
│   ├── widgets/          # Reusable UI components
│   └── providers/        # Riverpod providers
├── domain/               # Business logic layer
│   ├── entities/         # Data models
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business logic
└── data/                 # Data layer
    ├── repositories/     # Repository implementations
    ├── datasources/      # Platform-specific data sources
    └── platform/         # Platform abstraction
```

Documentation structure:

```javascript
docs/
├── architecture/         # Architecture documentation
│   ├── clean_architecture.md
│   ├── data_flow.md
│   └── platform_abstraction.md
├── api/                 # API documentation
│   ├── platform_file_service.md
│   ├── repository_api.md
│   └── usecases.md
├── guides/              # Developer guides
│   ├── setup.md
│   ├── building.md
│   ├── testing.md
│   └── contributing.md
├── platform/           # Platform-specific docs
│   ├── android.md
│   ├── ios.md
│   └── web.md
└── features/           # Feature documentation
    ├── file_operations.md
    ├── search.md
    ├── zip_support.md
    └── storage_info.md
```



## Implementation Steps

### 1. Project Initialization

- Initialize Flutter project with `flutter create`
- Configure `pubspec.yaml` with required dependencies:
- `flutter_riverpod` (state management)
- `file_picker` (file selection)
- `path_provider` (paths)
- `permission_handler` (permissions)
- `flutter_archive` (ZIP operations)
- `intl` (formatting)
- `mime` (MIME types)
- `share_plus` (sharing)
- Create directory structure matching Clean Architecture
- Create `docs/` folder structure with sub-folders:
- `docs/architecture/`
- `docs/api/`
- `docs/guides/`
- `docs/platform/`
- `docs/features/`
- Create `.cursor/rules/documentation.mdc` file with frontmatter and documentation maintenance rules
- Add `.gitignore` for Flutter

### 2. Analysis & Linting Configuration

- Create strict `analysis_options.yaml` with:
- All linter rules enabled
- Strict type checking
- No warnings allowed
- Configure IDE settings

### 3. Platform Abstraction Layer

**Files:**

- `lib/data/platform/platform_file_service.dart` - Abstract interface
- `lib/data/platform/android_file_service.dart` - Android SAF implementation
- `lib/data/platform/ios_file_service.dart` - iOS Document Picker implementation
- `lib/data/platform/web_file_service.dart` - Web stub implementation

**Implementation:**

- Define `PlatformFileService` interface with methods:
- `getRootDirectories()`
- `listFiles(String path)`
- `createDirectory(String path)`
- `deleteFile(String path)`
- `copyFile(String source, String dest)`
- `moveFile(String source, String dest)`
- `renameFile(String path, String newName)`
- `getFileInfo(String path)`
- `calculateDirectorySize(String path)`
- Implement platform-specific services using SAF (Android) and UIDocumentPicker (iOS)
- Create factory to return correct service based on platform
- Add comprehensive Dart doc comments to all public methods
- Document platform-specific behaviors and limitations

**Documentation:**

- Create `docs/api/platform_file_service.md` with interface documentation
- Create `docs/platform/android.md`, `docs/platform/ios.md`, `docs/platform/web.md` with platform-specific details
- Add mermaid diagram in `docs/architecture/platform_abstraction.md` showing platform service selection flow

### 4. Domain Layer

**Entities:**

- `lib/domain/entities/file_item.dart` - File model with name, path, size, type, modified date
- `lib/domain/entities/storage_info.dart` - Storage statistics model
- Add Dart doc comments to all entity classes and properties

**Repository Interface:**

- `lib/domain/repositories/file_repository.dart` - Abstract repository interface
- Document all repository methods with Dart doc comments

**Use Cases:**

- `lib/domain/usecases/browse_directory.dart`
- `lib/domain/usecases/create_folder.dart`
- `lib/domain/usecases/delete_file.dart`
- `lib/domain/usecases/copy_file.dart`
- `lib/domain/usecases/move_file.dart`
- `lib/domain/usecases/rename_file.dart`
- `lib/domain/usecases/search_files.dart`
- `lib/domain/usecases/get_storage_info.dart`
- `lib/domain/usecases/create_zip.dart`
- `lib/domain/usecases/extract_zip.dart`
- Add comprehensive Dart doc comments to all use cases

**Documentation:**

- Create `docs/api/repository_api.md` with repository interface documentation
- Create `docs/api/usecases.md` with all use cases documented
- Add mermaid sequence diagrams in `docs/architecture/data_flow.md` showing use case execution flow

### 5. Data Layer

**Repository Implementation:**

- `lib/data/repositories/file_repository_impl.dart` - Implements domain repository, uses platform services

**Data Sources:**

- `lib/data/datasources/local_file_datasource.dart` - Wraps platform services

### 6. State Management (Riverpod)

**Providers:**

- `lib/presentation/providers/file_browser_provider.dart` - Current directory state
- `lib/presentation/providers/file_operations_provider.dart` - Copy/paste state
- `lib/presentation/providers/selection_provider.dart` - Multi-select state
- `lib/presentation/providers/search_provider.dart` - Search state
- `lib/presentation/providers/storage_provider.dart` - Storage info state
- `lib/presentation/providers/view_mode_provider.dart` - Grid/list view toggle

### 7. UI Components

**Pages:**

- `lib/presentation/pages/home_page.dart` - Root screen with permission handling
- `lib/presentation/pages/file_browser_page.dart` - Main file browser
- `lib/presentation/pages/preview_page.dart` - File preview (images, text, PDFs)

**Widgets:**

- `lib/presentation/widgets/file_list_item.dart` - List view item
- `lib/presentation/widgets/file_grid_item.dart` - Grid view item
- `lib/presentation/widgets/breadcrumb_navigation.dart` - Path navigation
- `lib/presentation/widgets/file_context_menu.dart` - Long-press menu
- `lib/presentation/widgets/selection_toolbar.dart` - Multi-select actions
- `lib/presentation/widgets/storage_info_card.dart` - Storage statistics
- `lib/presentation/widgets/search_bar.dart` - Search input
- `lib/presentation/widgets/empty_state.dart` - Empty directory state
- `lib/presentation/widgets/loading_indicator.dart` - Loading states
- `lib/presentation/widgets/error_widget.dart` - Error display

### 8. File Operations Implementation

- Implement all CRUD operations with proper error handling
- Add confirmation dialogs for destructive actions
- Implement copy/paste clipboard mechanism
- Add progress indicators for long operations
- Handle permission errors gracefully
- Add Dart doc comments to all operation methods

**Documentation:**

- Create `docs/features/file_operations.md` with operation flow diagrams
- Add mermaid sequence diagrams showing file operation workflows

### 9. Search & Filtering

- Implement recursive filename search
- Add type filtering (images, documents, etc.)
- Case-insensitive matching
- Debounced search input
- Search results highlighting
- Add Dart doc comments to search algorithms

**Documentation:**

- Create `docs/features/search.md` with search algorithm documentation
- Add mermaid flowchart showing search process

### 10. ZIP Support

- Implement ZIP creation from selected files
- Implement ZIP extraction
- Progress tracking for large archives
- Error handling for corrupt files

### 11. Storage Info

- Calculate total/used/free storage
- Async directory size calculation
- Cache results for performance
- Update on file operations

### 12. Platform Configuration

**Android:**

- `android/app/src/main/AndroidManifest.xml` - Permissions and SAF configuration
- `android/app/build.gradle` - SDK versions (min 28, target latest)
- Configure SAF intents

**iOS:**

- `ios/Runner/Info.plist` - Document picker configuration
- `ios/Runner/AppDelegate.swift` - Document picker setup
- Configure UIDocumentPicker entitlements

**Web:**

- `web/index.html` - Basic HTML structure
- Limited functionality (UI inspection only)

### 13. Error Handling

- Create error types enum
- User-friendly error messages
- Permission denial handling
- File operation failure recovery
- Network error handling (for future)

### 14. Scripts

Create shell scripts in `scripts/`:

- `scripts/run.sh` - Run on connected device/emulator
- `scripts/run_web.sh` - Run on web
- `scripts/build_android.sh` - Build APK
- `scripts/build_android_bundle.sh` - Build App Bundle
- `scripts/build_ios.sh` - Build iOS
- `scripts/lint.sh` - Run flutter analyze
- `scripts/format.sh` - Format code with dart format

### 15. Test Structure

Create test directories:

- `test/unit/` - Unit tests for use cases and repositories
- `test/integration/` - Integration tests for file operations
- `test/e2e/` - End-to-end tests (structure only, tests to be added later)

### 16. Documentation Structure

**Create `docs/` folder with sub-folders:**

- `docs/architecture/` - Architecture documentation
- `clean_architecture.md` - Clean Architecture overview with mermaid diagrams
- `data_flow.md` - Data flow diagrams
- `platform_abstraction.md` - Platform abstraction layer documentation
- `docs/api/` - API documentation
- `platform_file_service.md` - Platform service interface documentation
- `repository_api.md` - Repository interface documentation
- `usecases.md` - Use cases documentation
- `docs/guides/` - User and developer guides
- `setup.md` - Setup instructions
- `building.md` - Build instructions for all platforms
- `testing.md` - Testing guide
- `contributing.md` - Contribution guidelines
- `docs/platform/` - Platform-specific documentation
- `android.md` - Android-specific implementation details
- `ios.md` - iOS-specific implementation details
- `web.md` - Web limitations and notes
- `docs/features/` - Feature documentation
- `file_operations.md` - File operations documentation
- `search.md` - Search functionality
- `zip_support.md` - ZIP operations
- `storage_info.md` - Storage calculation

**Documentation Requirements:**

- Use mermaid diagrams for architecture, data flow, and complex processes
- Keep documentation up-to-date with code changes
- Include code examples where applicable
- Document platform-specific behaviors

**Code Documentation:**

- Add Dart doc comments (`///`) to all public classes, methods, and properties
- Document complex algorithms and business logic
- Include parameter descriptions and return value documentation
- Add examples in doc comments where helpful

**Cursor Rules:**

- Create `.cursor/rules/documentation.mdc` file with frontmatter and rule: "Always update relevant documentation in `docs/` folder when making code changes. Use mermaid diagrams for architecture and data flow documentation when applicable."
- Format: `.mdc` file with frontmatter containing `alwaysApply: true` (or appropriate flag)

### 17. Final Configuration

- Ensure all imports are correct
- Remove any generated TODOs
- Verify no commented-out code
- Run initial linting pass
- Test compilation on all platforms

## Key Files to Create

### Core Platform Files

- `lib/data/platform/platform_file_service.dart`
- `lib/data/platform/android_file_service.dart`
- `lib/data/platform/ios_file_service.dart`
- `lib/data/platform/web_file_service.dart`

### Domain Files

- `lib/domain/entities/file_item.dart`
- `lib/domain/entities/storage_info.dart`
- `lib/domain/repositories/file_repository.dart`
- `lib/domain/usecases/*.dart` (10 use case files)

### Data Files

- `lib/data/repositories/file_repository_impl.dart`
- `lib/data/datasources/local_file_datasource.dart`

### Presentation Files

- `lib/presentation/pages/home_page.dart`
- `lib/presentation/pages/file_browser_page.dart`
- `lib/presentation/pages/preview_page.dart`
- `lib/presentation/widgets/*.dart` (10+ widget files)
- `lib/presentation/providers/*.dart` (6 provider files)

### Configuration Files

- `analysis_options.yaml`
- `.cursorrules` - Cursor rules for documentation maintenance
- `scripts/*.sh` (7 script files)
- Platform-specific configs (AndroidManifest.xml, Info.plist updates)

### Documentation Files

- `docs/architecture/clean_architecture.md` - Architecture overview with mermaid diagrams
- `docs/architecture/data_flow.md` - Data flow documentation
- `docs/architecture/platform_abstraction.md` - Platform abstraction documentation
- `docs/api/platform_file_service.md` - Platform service API
- `docs/api/repository_api.md` - Repository API
- `docs/api/usecases.md` - Use cases documentation
- `docs/guides/setup.md` - Setup guide
- `docs/guides/building.md` - Build guide
- `docs/guides/testing.md` - Testing guide
- `docs/guides/contributing.md` - Contribution guide
- `docs/platform/android.md` - Android documentation
- `docs/platform/ios.md` - iOS documentation
- `docs/platform/web.md` - Web documentation
- `docs/features/file_operations.md` - File operations documentation
- `docs/features/search.md` - Search documentation
- `docs/features/zip_support.md` - ZIP support documentation
- `docs/features/storage_info.md` - Storage info documentation

## Success Criteria

- Project compiles without errors
- All linter rules pass
- Clean Architecture separation maintained
- Platform-specific implementations work correctly
- No TODOs or placeholder code
- All public APIs documented with Dart doc comments
- Documentation folder structure complete with all required docs
- Mermaid diagrams included where applicable
- `.cursor/rules/documentation.mdc` file created with proper frontmatter format
- README.md updated with project overview and links to documentation