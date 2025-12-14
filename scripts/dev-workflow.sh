#!/bin/bash

# Development workflow script for PaperMC
# Usage: ./scripts/dev-workflow.sh [command]

set -e

COMMAND=${1:-"help"}

case $COMMAND in
    "build")
        echo "Building Paper project..."
        ./gradlew build
        ;;
    "build-server")
        echo "Building Paper server..."
        ./gradlew :paper-server:build
        ;;
    "patch")
        echo "Creating patch from current changes..."
        if [ -z "$(git status --porcelain)" ]; then
            echo "No changes to patch"
            exit 1
        fi
        
        # Create a temporary commit
        git add .
        git commit -m "TEMP: Development changes $(date +%Y%m%d_%H%M%S)"
        
        # Create patch from the temp commit
        ./scripts/make-patch.sh HEAD~1..HEAD patches/dev-$(date +%Y%m%d_%H%M%S)
        
        # Reset to remove the temp commit but keep changes
        git reset HEAD~1
        echo "Patch created in patches/dev-$(date +%Y%m%d_%H%M%S)/"
        ;;
    "test")
        echo "Running tests..."
        ./gradlew test
        ;;
    "clean")
        echo "Cleaning build..."
        ./gradlew clean
        ;;
    "status")
        echo "=== Git Status ==="
        git status
        echo ""
        echo "=== Recent Patches ==="
        ls -la patches/*.patch 2>/dev/null | tail -5 || echo "No patches found"
        ;;
    "setup")
        echo "Setting up development environment..."
        
        # Configure git if needed
        if [ -z "$(git config user.name)" ]; then
            echo "Please set your git name:"
            read -p "Git name: " git_name
            git config user.name "$git_name"
        fi
        
        if [ -z "$(git config user.email)" ]; then
            echo "Please set your git email:"
            read -p "Git email: " git_email
            git config user.email "$git_email"
        fi
        
        echo "Development environment configured!"
        ;;
    "help"|*)
        echo "PaperMC Development Workflow"
        echo ""
        echo "Commands:"
        echo "  build         - Build entire project"
        echo "  build-server  - Build only server"
        echo "  patch         - Create patch from current changes"
        echo "  test          - Run tests"
        echo "  clean         - Clean build artifacts"
        echo "  status        - Show git status and recent patches"
        echo "  setup         - Configure development environment"
        echo "  help          - Show this help"
        echo ""
        echo "Example workflow:"
        echo "  1. Edit source code"
        echo "  2. ./scripts/dev-workflow.sh build"
        echo "  3. ./scripts/dev-workflow.sh test"
        echo "  4. ./scripts/dev-workflow.sh patch"
        ;;
esac
