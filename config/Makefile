# Makefile for building git-sync binaries

.PHONY: clean build install-deps help

# Default target
help:
	@echo "Available targets:"
	@echo "  build        - Build standalone executable"
	@echo "  install-deps - Install PyInstaller"
	@echo "  clean        - Clean build artifacts"
	@echo "  test         - Test the built executable"

# Install PyInstaller
install-deps:
	pip install pyinstaller

# Build standalone executable
build: install-deps
	@echo "Building git-sync executable..."
	pyinstaller git-sync.spec --clean
	@echo "✅ Build complete! Executable is in dist/"

# Clean build artifacts
clean:
	rm -rf build/ dist/ *.spec __pycache__/
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true

# Test the built executable
test:
	@if [ -f dist/git-sync ]; then \
		echo "Testing git-sync executable..."; \
		./dist/git-sync --help; \
	else \
		echo "❌ Executable not found. Run 'make build' first."; \
	fi
