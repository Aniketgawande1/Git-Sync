#!/bin/bash
# Build script for creating git-sync binaries

set -e

echo "🔨 Building git-sync standalone executable"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get platform info
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Normalize architecture names
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

# Set executable name
if [ "$OS" = "windows" ] || [ "$OS" = "mingw"* ] || [ "$OS" = "cygwin"* ]; then
    EXECUTABLE_NAME="git-sync-${OS}-${ARCH}.exe"
else
    EXECUTABLE_NAME="git-sync-${OS}-${ARCH}"
fi

echo -e "${BLUE}Platform: $OS-$ARCH${NC}"
echo -e "${BLUE}Output: $EXECUTABLE_NAME${NC}"

# Install PyInstaller if not present
if ! command -v pyinstaller &> /dev/null; then
    echo -e "${BLUE}Installing PyInstaller...${NC}"
    pip install pyinstaller
fi

# Clean previous builds
echo -e "${BLUE}Cleaning previous builds...${NC}"
rm -rf ../build/ ../dist/

# Build the executable
echo -e "${BLUE}Building executable...${NC}"

# Update the spec file with the correct name
sed -i "s/name='git-sync'/name='$EXECUTABLE_NAME'/" ../config/git-sync.spec

pyinstaller ../config/git-sync.spec --clean

# Restore the original spec file name
sed -i "s/name='$EXECUTABLE_NAME'/name='git-sync'/" ../config/git-sync.spec

# Check if build was successful
if [ -f "../dist/$EXECUTABLE_NAME" ]; then
    SIZE=$(du -h "../dist/$EXECUTABLE_NAME" | cut -f1)
    echo -e "${GREEN}✅ Build successful!${NC}"
    echo -e "${GREEN}📁 Location: dist/$EXECUTABLE_NAME${NC}"
    echo -e "${GREEN}📊 Size: $SIZE${NC}"
    
    # Test the executable
    echo -e "${BLUE}Testing executable...${NC}"
    if ../dist/$EXECUTABLE_NAME --help > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Executable test passed!${NC}"
    else
        echo -e "${RED}❌ Executable test failed!${NC}"
        exit 1
    fi
else
    echo -e "${RED}❌ Build failed!${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 Build complete!${NC}"
