#!/bin/bash

# Remove previous coverage data
rm -rf coverage
rm -rf test/.test_coverage.dart
rm -rf coverage/lcov.info

# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html

# Open coverage report (macOS)
open coverage/html/index.html

# For Linux, use:
# xdg-open coverage/html/index.html