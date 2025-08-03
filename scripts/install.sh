#!/bin/bash
# Git-Sync Installer Script
# Automatically downloads the correct binary for your platform

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO="Aniketgawande1/Git-Sync"
INSTALL_DIR="$HOME/.local/bin"

echo -e "${BLUE}🔄 Git-Sync Installer${NC}"
echo "======================"

# Detect platform
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Normalize architecture
case $ARCH in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64|arm64)
        ARCH="arm64"
        ;;
    i386|i686)
        ARCH="386"
        ;;
esac

# Set binary name
if [[ "$OS" == "darwin" ]]; then
    BINARY_NAME="git-sync-darwin-${ARCH}"
elif [[ "$OS" == "linux" ]]; then
    BINARY_NAME="git-sync-linux-${ARCH}"
else
    echo -e "${RED}❌ Unsupported platform: $OS${NC}"
    echo "Please download manually from: https://github.com/$REPO/releases"
    exit 1
fi

echo -e "${BLUE}🖥️  Detected platform: $OS-$ARCH${NC}"
echo -e "${BLUE}📦 Binary: $BINARY_NAME${NC}"

# Create install directory
mkdir -p "$INSTALL_DIR"

# Download URL
DOWNLOAD_URL="https://github.com/$REPO/releases/latest/download/$BINARY_NAME"
LOCAL_PATH="$INSTALL_DIR/git-sync"

echo -e "${BLUE}⬇️  Downloading from GitHub...${NC}"
echo "URL: $DOWNLOAD_URL"

# Download with curl or wget
if command -v curl > /dev/null 2>&1; then
    curl -L -o "$LOCAL_PATH" "$DOWNLOAD_URL"
elif command -v wget > /dev/null 2>&1; then
    wget -O "$LOCAL_PATH" "$DOWNLOAD_URL"
else
    echo -e "${RED}❌ Error: Neither curl nor wget found${NC}"
    echo "Please install curl or wget, or download manually"
    exit 1
fi

# Make executable
chmod +x "$LOCAL_PATH"

# Check if installed correctly
if [ -x "$LOCAL_PATH" ]; then
    echo -e "${GREEN}✅ Git-Sync installed successfully!${NC}"
    echo -e "${GREEN}📍 Location: $LOCAL_PATH${NC}"
    
    # Check if directory is in PATH
    if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then
        echo -e "${GREEN}🎉 You can now run: git-sync --help${NC}"
    else
        echo -e "${YELLOW}⚠️  Note: $INSTALL_DIR is not in your PATH${NC}"
        echo "Add this to your shell profile (.bashrc, .zshrc, etc.):"
        echo "export PATH=\"\$PATH:$INSTALL_DIR\""
        echo ""
        echo "Or run directly:"
        echo "$LOCAL_PATH --help"
    fi
    
    # Test the installation
    echo ""
    echo -e "${BLUE}🧪 Testing installation...${NC}"
    if "$LOCAL_PATH" --help > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Installation test passed!${NC}"
        
        # Show quick usage
        echo ""
        echo -e "${YELLOW}🚀 Quick start:${NC}"
        echo "git-sync sys health          # Check system resources"
        echo "git-sync git auto-commit --message \"hello\"  # Auto-commit"
        echo "git-sync --help              # Show all commands"
    else
        echo -e "${RED}❌ Installation test failed${NC}"
        echo "The binary was downloaded but doesn't seem to work"
    fi
else
    echo -e "${RED}❌ Installation failed${NC}"
    echo "Could not download or make executable"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
