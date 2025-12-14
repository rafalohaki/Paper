#!/bin/bash

# Clean patch creation - no temp commits, simple naming
# Usage: ./scripts/clean-patch.sh [patch-name]

set -e

PATCH_NAME=${1:-"feature-$(date +%Y%m%d_%H%M%S)"}
PATCH_FILE="patches/$PATCH_NAME.patch"

echo "Creating clean patch: $PATCH_FILE"

# Create patches directory if it doesn't exist
mkdir -p patches

# Check if there are changes
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to patch"
    exit 1
fi

# Create patch from current working directory changes
git diff --no-color > "$PATCH_FILE"

echo "Clean patch created: $PATCH_FILE"
echo "Size: $(wc -l < "$PATCH_FILE") lines"
echo ""
echo "To apply this patch later:"
echo "  git apply $PATCH_FILE"
