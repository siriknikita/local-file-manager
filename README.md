# Local File Manager

A fully free, clean, lightweight file manager for Android and iOS with no ads, no tracking, and no restrictions.

## Features

- **File Browsing**: Navigate directories with grid and list views
- **File Operations**: Create, rename, delete, copy, and move files and folders
- **Search**: Recursive filename search with filtering
- **ZIP Support**: Create and extract ZIP archives
- **Storage Info**: View storage statistics and directory sizes
- **Multi-select**: Select multiple files for batch operations
- **File Preview**: Preview images, text files, and PDFs

## Architecture

Local File Manager follows Clean Architecture principles with three main layers:

- **Presentation**: UI components and state management (Riverpod)
- **Domain**: Business logic and use cases
- **Data**: Repository implementations and platform services

See [Architecture Documentation](docs/architecture/clean_architecture.md) for details.

## Requirements

- Flutter SDK (latest stable)
- Android: Minimum SDK 28 (Android 9+)
- iOS: iOS 15+

## Quick Start

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd local-file-manager

# Install dependencies
flutter pub get
```

### Run

```bash
# Run on connected device/emulator
./scripts/run.sh

# Run on web (development only)
./scripts/run_web.sh
```

### Build

```bash
# Build Android APK
./scripts/build_android.sh

# Build Android App Bundle
./scripts/build_android_bundle.sh

# Build iOS
./scripts/build_ios.sh
```

## Documentation

### Architecture
- [Clean Architecture Overview](docs/architecture/clean_architecture.md)
- [Data Flow](docs/architecture/data_flow.md)
- [Platform Abstraction](docs/architecture/platform_abstraction.md)

### API Documentation
- [Platform File Service](docs/api/platform_file_service.md)
- [Repository API](docs/api/repository_api.md)
- [Use Cases](docs/api/usecases.md)

### Guides
- [Setup Guide](docs/guides/setup.md)
- [Building Guide](docs/guides/building.md)
- [Testing Guide](docs/guides/testing.md)
- [Contributing Guide](docs/guides/contributing.md)

### Platform-Specific
- [Android](docs/platform/android.md)
- [iOS](docs/platform/ios.md)
- [Web](docs/platform/web.md)

### Features
- [File Operations](docs/features/file_operations.md)
- [Search](docs/features/search.md)
- [ZIP Support](docs/features/zip_support.md)
- [Storage Info](docs/features/storage_info.md)

## Development

### Code Quality

```bash
# Format code
./scripts/format.sh

# Run linter
./scripts/lint.sh
```

### Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Principles

- **No Ads**: Completely ad-free
- **No Tracking**: Zero analytics or telemetry
- **No Monetization**: Free and open
- **Privacy First**: Respects user privacy and OS security models
- **Clean Code**: Well-documented, maintainable codebase

## License

[Add your license here]

## Contributing

See [Contributing Guide](docs/guides/contributing.md) for details on how to contribute to this project.
