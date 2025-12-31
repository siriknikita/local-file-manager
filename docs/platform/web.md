# Web Platform Documentation

This document describes web platform limitations and usage for Local File Manager.

## Limitations

Web browsers have severe restrictions on file system access:

- **No direct file system access**: Browsers cannot access the local file system directly
- **Limited functionality**: Most file operations are not available
- **UI inspection only**: Web platform is primarily for UI development and inspection

## Implementation

The `WebFileService` class provides stub implementations:
- All methods throw `UnimplementedError` except basic checks
- Returns empty lists for directory operations
- Used for UI development and testing

## Use Cases

Web platform is useful for:
1. **UI Development**: Rapid iteration on UI components
2. **Layout Testing**: Testing responsive layouts
3. **Cursor Agent Adaptation**: Testing with AI coding assistants
4. **Cross-platform Development**: Ensuring UI works across platforms

## Running on Web

```bash
./scripts/run_web.sh
```

Or:
```bash
flutter run -d chrome
```

## Future Considerations

If web file access becomes available (e.g., File System Access API), the implementation can be extended. Currently, web support is limited to UI inspection.

