#!/usr/bin/env bash

# Set the Flutter binary path (adjust this if Flutter is not in your PATH)
FLUTTER="flutter"

# Get the current operating system
OS=$(uname)

# Remove previous coverage data
rm -rf coverage
rm -rf test/.test_coverage.dart
rm -rf coverage/lcov.info

# Run tests with coverage
"$FLUTTER" test --coverage

# Remove .g. files from coverage
if command -v lcov &> /dev/null; then
    lcov --remove coverage/lcov.info '**/*.g.dart' '**/*.freezed.dart' -o coverage/lcov.info
else
    echo "lcov is not installed. Skipping removal of .g. files from coverage."
fi

# Generate coverage report
if command -v genhtml &> /dev/null; then
    genhtml coverage/lcov.info -o coverage/html
else
    echo "genhtml is not installed. Skipping generation of coverage report."
fi

# Open coverage report based on the operating system
case "$OS" in
    Darwin)
        open coverage/html/index.html
        ;;
    Linux)
        if command -v xdg-open &> /dev/null; then
            xdg-open coverage/html/index.html
        else
            echo "xdg-open is not installed. Please manually open coverage/html/index.html in a web browser."
        fi
        ;;
    *)
        echo "Unsupported operating system. Please manually open coverage/html/index.html in a web browser."
        ;;
esac