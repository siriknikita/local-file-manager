#!/bin/bash

# Script to build Android APK for Local File Manager

set -e

echo "Building Android APK for Local File Manager..."
flutter build apk --release

# Create outputs directory if it doesn't exist
mkdir -p outputs

# Copy APK to outputs folder
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
OUTPUT_PATH="outputs/local-file-manager-release.apk"

if [ -f "$APK_PATH" ]; then
  cp "$APK_PATH" "$OUTPUT_PATH"
  echo "APK built successfully and copied to: $OUTPUT_PATH"
else
  echo "Error: APK not found at $APK_PATH"
  exit 1
fi

