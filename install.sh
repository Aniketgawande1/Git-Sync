#!/bin/bash

# Git-Sync Installation Script
# This script downloads and installs Git-Sync CLI tool

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Python is installed
check_python() {
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is not installed. Please install Python 3.6+ and try again."
        exit 1
    fi
    
    python_version=$(python3 -c "import sys; print('.'.join(map(str, sys.version_info[:2])))")
    print_status "Found Python $python_version"
}

# Check if Git is installed
check_git() {
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed. Please install Git and try again."
        exit 1
    fi
    
    git_version=$(git --version | cut -d' ' -f3)
    print_status "Found Git $git_version"
}

# Check if pip is installed
check_pip() {
    if ! command -v pip3 &> /dev/null; then
        print_error "pip3 is not installed. Please install pip3 and try again."
        exit 1
    fi
    
    print_status "Found pip3"
}

# Main installation function
install_git_sync() {
    print_status "Starting Git-Sync installation..."
    
    # Check prerequisites
    check_python
    check_git
    check_pip
    
    # Create temporary directory
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    print_status "Downloading Git-Sync from GitHub..."
    
    # Download the latest release
    if command -v curl &> /dev/null; then
        curl -sSL https://github.com/Aniketgawande1/Git-Sync/archive/main.zip -o git-sync.zip
    elif command -v wget &> /dev/null; then
        wget -q https://github.com/Aniketgawande1/Git-Sync/archive/main.zip -O git-sync.zip
    else
        print_error "Neither curl nor wget is available. Please install one of them and try again."
        exit 1
    fi
    
    # Extract the archive
    print_status "Extracting archive..."
    if command -v unzip &> /dev/null; then
        unzip -q git-sync.zip
    else
        print_error "unzip is not available. Please install unzip and try again."
        exit 1
    fi
    
    # Navigate to extracted directory
    cd Git-Sync-main
    
    # Install the package
    print_status "Installing Git-Sync..."
    pip3 install --user -e .
    
    # Check if installation was successful
    if command -v git-sync &> /dev/null; then
        print_success "Git-Sync installed successfully!"
        print_status "You can now use 'git-sync --help' to get started."
    else
        print_warning "Installation completed, but 'git-sync' command not found in PATH."
        print_status "You may need to add ~/.local/bin to your PATH:"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
        echo "Add this line to your ~/.bashrc or ~/.zshrc file."
    fi
    
    # Cleanup
    cd /
    rm -rf "$temp_dir"
    
    print_success "Installation complete!"
    
    # Show usage example
    echo ""
    echo "Quick Start:"
    echo "1. Create a config.yaml file:"
    echo "   repos:"
    echo "     - path: \"/path/to/your/repo\""
    echo "       upstream: \"https://github.com/upstream/repo.git\""
    echo "       branch: \"main\""
    echo "       auto_push: false"
    echo ""
    echo "2. Run: git-sync --config config.yaml"
}

# Show help
show_help() {
    echo "Git-Sync Installation Script"
    echo ""
    echo "Usage:"
    echo "  $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -v, --version  Show version information"
    echo ""
    echo "This script will:"
    echo "  1. Check for Python 3.6+, Git, and pip3"
    echo "  2. Download Git-Sync from GitHub"
    echo "  3. Install it using pip3"
    echo ""
    echo "For manual installation:"
    echo "  git clone https://github.com/Aniketgawande1/Git-Sync.git"
    echo "  cd Git-Sync"
    echo "  pip3 install -e ."
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    -v|--version)
        echo "Git-Sync Installer v1.0.0"
        exit 0
        ;;
    "")
        install_git_sync
        ;;
    *)
        print_error "Unknown option: $1"
        echo "Use -h or --help for usage information."
        exit 1
        ;;
esac
