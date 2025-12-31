# Setup Guide

This guide will help you set up the Local File Manager project for development.

## Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Android Studio / Xcode (for platform-specific development)
- Git

## Installation Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd local-file-manager
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Verify Installation

```bash
flutter doctor
```

Ensure all required components are installed and configured.

### 4. Run the App

For Android:
```bash
flutter run
```

For iOS:
```bash
flutter run
```

For Web (development only):
```bash
flutter run -d chrome
```

## Development Setup

### IDE Configuration

Recommended IDEs:
- **VS Code** with Flutter extensions
- **Android Studio** with Flutter plugin
- **IntelliJ IDEA** with Flutter plugin

### Code Formatting

Format code before committing:
```bash
./scripts/format.sh
```

### Linting

Run linter to check code quality:
```bash
./scripts/lint.sh
```

## Project Structure

```
lib/
├── presentation/    # UI layer
├── domain/         # Business logic
└── data/          # Data layer

docs/              # Documentation
scripts/           # Build and utility scripts
test/              # Tests
```

## Next Steps

- Read the [Architecture Overview](../architecture/clean_architecture.md)
- Check [Building Guide](building.md) for build instructions
- Review [Testing Guide](testing.md) for testing setup

