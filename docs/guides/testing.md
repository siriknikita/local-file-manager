# Testing Guide

This guide explains the testing structure and how to run tests for Local File Manager.

## Test Structure

```
test/
├── unit/          # Unit tests for use cases and repositories
├── integration/   # Integration tests for file operations
└── e2e/           # End-to-end tests (structure only)
```

## Running Tests

### Run All Tests

```bash
flutter test
```

### Run Specific Test Files

```bash
flutter test test/unit/browse_directory_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

## Unit Tests

Unit tests test individual components in isolation.

### Example: Use Case Test

```dart
void main() {
  test('BrowseDirectory should return file list', () async {
    // Arrange
    final mockRepository = MockFileRepository();
    final useCase = BrowseDirectory(mockRepository);
    
    // Act
    final result = await useCase('/test/path');
    
    // Assert
    expect(result, isA<List<FileItem>>());
  });
}
```

## Integration Tests

Integration tests verify that multiple components work together.

### Example: File Operation Test

```dart
void main() {
  testWidgets('File browser displays files', (tester) async {
    // Build app and trigger file loading
    await tester.pumpWidget(const LocalFileManagerApp());
    
    // Verify files are displayed
    expect(find.text('file.txt'), findsOneWidget);
  });
}
```

## E2E Tests

End-to-end tests verify complete user flows. These will be implemented using `patrol` or similar tools.

## Test Coverage

Aim for:
- 80%+ coverage for domain layer
- 70%+ coverage for data layer
- 60%+ coverage for presentation layer

## Best Practices

1. **Isolation**: Each test should be independent
2. **Mocking**: Use mocks for external dependencies
3. **Naming**: Use descriptive test names
4. **Structure**: Follow Arrange-Act-Assert pattern
5. **Coverage**: Focus on business logic coverage

