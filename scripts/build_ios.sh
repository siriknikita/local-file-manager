#!/bin/bash

# Script to build iOS app for Local File Manager

set -e

echo "Building iOS app for Local File Manager..."
flutter build ios --release

echo "iOS app built successfully"

