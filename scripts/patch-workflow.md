# Patch Creation Workflow

## Development Workflow

### Quick Start - Edit → Build → Patch

1. **Edit source code** in `paper-server/src/main/java/` or other modules
2. **Build the project:**
   ```bash
   ./scripts/dev-workflow.sh build
   ```
3. **Create patch from changes:**
   ```bash
   ./scripts/dev-workflow.sh patch
   ```

### One-Command Operations

```bash
# Full development cycle
./scripts/dev-workflow.sh build && ./scripts/dev-workflow.sh patch

# Quick patch from current changes (no commit needed)
./scripts/quick-patch.sh my-feature-name
```

### Traditional Patch Creation

1. **Create patches from commits:**
   ```bash
   ./scripts/make-patch.sh
   ```

2. **Create patches from specific range:**
   ```bash
   ./scripts/make-patch.sh HEAD~5..HEAD
   ```

3. **Apply patches:**
   ```bash
   ./scripts/apply-patch.sh patches/
   ```

## Git Commands for Patch Management

### Create patches manually
```bash
# From last commit
git format-patch -1

# From commit range
git format-patch HEAD~3..HEAD

# From specific commit
git format-patch <commit-hash>
```

### Apply patches
```bash
# Check patch first
git apply --check patch-file.patch

# Apply patch
git apply patch-file.patch

# Apply and commit
git am patch-file.patch
```

### Export patches
```bash
# Create patches directory with custom output
git format-patch --output-directory=my-patches HEAD~5..HEAD
```

## Best Practices

1. **Always test patches** before applying to important branches
2. **Use descriptive commit messages** - they become patch filenames
3. **Keep patches organized** in separate directories by feature/bugfix
4. **Backup important branches** before applying patches

## PaperMC Specific Notes

- Paper uses a complex build system
- Test patches in a clean environment first
- Some changes may require rebuilding the project
