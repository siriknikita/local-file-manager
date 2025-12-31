# Contributing Guide

Thank you for your interest in contributing to Local File Manager!

## Code Style

- Follow Dart style guide
- Use `dart format` before committing
- Run `flutter analyze` to check for issues
- Write comprehensive Dart doc comments

## Development Workflow

1. **Create a branch** for your changes
2. **Make changes** following the architecture
3. **Write tests** for new functionality
4. **Update documentation** as needed
5. **Run linting and tests** before committing
6. **Submit a pull request** with description

## Architecture Guidelines

- **Presentation Layer**: UI components and state management only
- **Domain Layer**: Business logic, no platform dependencies
- **Data Layer**: Platform-specific implementations

## Documentation

When adding new features:
1. Update relevant API documentation
2. Add architecture diagrams if needed
3. Update user guides if applicable
4. Keep code comments up-to-date

## Testing Requirements

- New features must include unit tests
- Integration tests for file operations
- Update existing tests if breaking changes

## Commit Messages

Use clear, descriptive commit messages:
```
feat: Add ZIP extraction support
fix: Resolve file copy issue on Android
docs: Update API documentation
```

## Code Review

All changes require code review. Be open to feedback and suggestions.

