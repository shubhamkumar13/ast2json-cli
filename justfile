# justfile
set shell := ["bash", "-cu"]

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
    uv python install 3.12
    uv run --link-mode=copy --python 3.12  --with typer --with ast2json --with pyinstaller pyinstaller --noconfirm main.py

# Create archive for release
archive: build-cli
    @echo "Creating release archive..."
    tar -czf ast2json-cli.tar.gz -C dist main/

# Publish to GitHub Releases
publish *version : check archive
    @echo "Creating GitHub release {{ version }}..."
    gh release create {{ version }} \
        ast2json-cli.tar.gz \
        --title "{{ version }}" \
        --notes "Release {{ version }}"

# Clean build artifacts
clean-cli:
    rm -rf build dist main.spec ast2json-cli.tar.gz