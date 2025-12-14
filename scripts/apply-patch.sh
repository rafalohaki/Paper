#!/bin/bash

# Script to apply patches to Paper project
# Usage: ./scripts/apply-patch.sh [patch-file-or-directory]

set -e

PATCH_SOURCE=${1:-"patches"}

if [ ! -e "$PATCH_SOURCE" ]; then
    echo "Error: $PATCH_SOURCE does not exist"
    echo "Usage: $0 [patch-file-or-directory]"
    exit 1
fi

echo "Applying patches from: $PATCH_SOURCE"

if [ -f "$PATCH_SOURCE" ]; then
    # Apply single patch file
    echo "Applying patch: $PATCH_SOURCE"
    git apply "$PATCH_SOURCE"
elif [ -d "$PATCH_SOURCE" ]; then
    # Apply all patches in directory
    echo "Applying all patches in directory: $PATCH_SOURCE"
    git apply "$PATCH_SOURCE"/*.patch
else
    echo "Error: $PATCH_SOURCE is neither a file nor a directory"
    exit 1
fi

echo "Patches applied successfully"
echo "Run 'git status' to see changes"
