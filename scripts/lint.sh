#!/bin/bash

# Script to run linting for Local File Manager

set -e

echo "Running Flutter analyzer..."
flutter analyze

echo "Linting complete"

