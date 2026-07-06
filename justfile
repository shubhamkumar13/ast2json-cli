# justfile

# Default version (used locally)
version := "v0.1.0"

# Check if required tools are installed
check:
    @echo "Checking dependencies..."
    @command -v uv >/dev/null 2>&1 || (echo "❌ 'uv' not found." && exit 1)
    @command -v gh >/dev/null 2>&1 || (echo "❌ 'gh' not found." && exit 1)
    @command -v just >/dev/null 2>&1 || (echo "❌ 'just' not found." && exit 1)
    @echo "✅ All dependencies met."

# Build the binary
build-cli:
    uv run --with pyinstaller pyinstaller --noconfirm main.py

# Create archive for release
archive: build-cli
    @echo "Creating release archive..."
    tar -czf your-cli-linux-x86_64.tar.gz -C dist main/

# Publish to GitHub Releases
publish: check archive
    @echo "Creating GitHub release {{ version }}..."
    gh release create {{ version }} \
        your-cli-linux-x86_64.tar.gz \
        --title "{{ version }}" \
        --notes "Release {{ version }}"

# Clean build artifacts
clean-cli:
    rm -rf build dist main.spec your-cli-linux-x86_64.tar.gz