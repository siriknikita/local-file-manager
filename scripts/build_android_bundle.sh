#!/bin/bash

# Script to build Android App Bundle for Local File Manager

set -e

echo "Building Android App Bundle for Local File Manager..."
flutter build appbundle --release

echo "App Bundle built successfully at build/app/outputs/bundle/release/app-release.aab"

