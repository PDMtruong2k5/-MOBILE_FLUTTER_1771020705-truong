#!/bin/bash

# Build script for Vercel deployment
echo "Installing Flutter dependencies..."
flutter pub get

echo "Building Flutter Web..."
flutter build web --release --web-renderer canvaskit

echo "Build completed successfully!"
