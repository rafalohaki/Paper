#!/bin/bash

# Script to create patches from Paper project
# Usage: ./scripts/make-patch.sh [commit-range] [output-dir]

set -e

DEFAULT_OUTPUT_DIR="patches"
COMMIT_RANGE=${1:-"HEAD~1..HEAD"}
OUTPUT_DIR=${2:-$DEFAULT_OUTPUT_DIR}

echo "Creating patches from commit range: $COMMIT_RANGE"
echo "Output directory: $OUTPUT_DIR"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Generate patches
git format-patch --output-directory="$OUTPUT_DIR" $COMMIT_RANGE

echo "Patches created in $OUTPUT_DIR/"
ls -la "$OUTPUT_DIR"/*.patch 2>/dev/null || echo "No patches found"
