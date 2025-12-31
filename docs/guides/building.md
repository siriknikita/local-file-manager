# Building Guide

This guide explains how to build the Local File Manager app for different platforms.

## Android

### Build APK

```bash
./scripts/build_android.sh
```

The APK will be generated at:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Build App Bundle

```bash
./scripts/build_android_bundle.sh
```

The App Bundle will be generated at:
```
build/app/outputs/bundle/release/app-release.aab
```

### Requirements

- Android SDK with API 28+ (Android 9+)
- Java Development Kit (JDK) 17+

## iOS

### Build iOS App

```bash
./scripts/build_ios.sh
```

### Requirements

- macOS
- Xcode
- iOS 15+ deployment target
- Apple Developer account (for device deployment)

### Additional Steps

1. Open `ios/Runner.xcworkspace` in Xcode
2. Configure signing and capabilities
3. Build from Xcode or use Flutter CLI

## Web

Web builds are for development and UI inspection only. Full file system access is not available on web.

```bash
flutter build web
```

## Build Configuration

### Version Information

Version information is configured in `pubspec.yaml`:
```yaml
version: 1.0.0+1
```

### Release Builds

For release builds, ensure:
- Signing is configured (Android/iOS)
- ProGuard/R8 rules are set (Android)
- App icons and metadata are configured

## Troubleshooting

### Android Build Issues

- Ensure `minSdk` is set to 28 in `android/app/build.gradle.kts`
- Check that all dependencies are compatible
- Verify Android SDK is properly installed

### iOS Build Issues

- Ensure Xcode command line tools are installed
- Verify CocoaPods dependencies: `cd ios && pod install`
- Check signing and provisioning profiles

