#!/bin/bash

# Quick patch creation from current uncommitted changes
# Usage: ./scripts/quick-patch.sh [patch-name]

set -e

PATCH_NAME=${1:-"quick-fix-$(date +%Y%m%d_%H%M%S)"}
PATCH_DIR="patches"
PATCH_FILE="$PATCH_DIR/$PATCH_NAME.patch"

echo "Creating quick patch: $PATCH_FILE"

# Create patches directory if it doesn't exist
mkdir -p "$PATCH_DIR"

# Check if there are changes
if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to patch"
    exit 1
fi

# Create patch from current working directory changes
git diff --no-index /dev/null /dev/null 2>/dev/null || true

# Stage all changes temporarily
git add .

# Create patch from staged changes
git diff --cached --no-color > "$PATCH_FILE"

# Unstage changes
git reset

echo "Patch created: $PATCH_FILE"
echo "Size: $(wc -l < "$PATCH_FILE") lines"
echo ""
echo "To apply this patch later:"
echo "  git apply $PATCH_FILE"
