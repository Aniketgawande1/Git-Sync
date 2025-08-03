#!/bin/bash
# Release script for Git-Sync
# This script helps you create a new release with proper versioning

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🚀 Git-Sync Release Creator${NC}"
echo "================================"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: Not in a git repository${NC}"
    exit 1
fi

# Check if working directory is clean
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}❌ Error: Working directory is not clean${NC}"
    echo "Please commit your changes first"
    exit 1
fi

# Get current version from setup.py or ask user
echo -e "${YELLOW}📋 Current version information:${NC}"
if [ -f "setup.py" ]; then
    CURRENT_VERSION=$(grep "version=" setup.py | cut -d"'" -f2)
    echo "Setup.py version: $CURRENT_VERSION"
fi

# Get the last git tag
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "No tags found")
echo "Last git tag: $LAST_TAG"

echo ""
echo -e "${YELLOW}🏷️  What version do you want to release?${NC}"
echo "Examples: v1.0.0, v1.1.0, v2.0.0-beta"
read -p "Enter version (with 'v' prefix): " VERSION

# Validate version format
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9]+)?$ ]]; then
    echo -e "${RED}❌ Invalid version format. Use format: v1.0.0${NC}"
    exit 1
fi

# Confirm release
echo ""
echo -e "${YELLOW}📝 Release Summary:${NC}"
echo "Version: $VERSION"
echo "Branch: $(git branch --show-current)"
echo "Commit: $(git rev-parse --short HEAD)"
echo ""
read -p "Continue with release? (y/N): " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ Release cancelled${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}🔨 Creating release...${NC}"

# Update version in setup.py if it exists
if [ -f "setup.py" ]; then
    VERSION_NUMBER=${VERSION#v}  # Remove 'v' prefix
    echo -e "${BLUE}📝 Updating setup.py version to $VERSION_NUMBER${NC}"
    sed -i "s/version='[^']*'/version='$VERSION_NUMBER'/" setup.py
    git add setup.py
fi

# Create release commit
echo -e "${BLUE}📝 Creating release commit${NC}"
git commit -m "🚀 Release $VERSION" || echo "Nothing to commit"

# Create and push tag
echo -e "${BLUE}🏷️  Creating git tag: $VERSION${NC}"
git tag -a "$VERSION" -m "Release $VERSION"

echo -e "${BLUE}⬆️  Pushing to origin${NC}"
git push origin $(git branch --show-current)
git push origin "$VERSION"

echo ""
echo -e "${GREEN}✅ Release $VERSION created successfully!${NC}"
echo ""
echo -e "${YELLOW}📋 Next steps:${NC}"
echo "1. 🤖 GitHub Actions will automatically build binaries"
echo "2. 📦 Binaries will be attached to the release"
echo "3. 🔗 Users can download from: https://github.com/Aniketgawande1/Git-Sync/releases/tag/$VERSION"
echo ""
echo -e "${BLUE}🔗 View release: https://github.com/Aniketgawande1/Git-Sync/releases${NC}"

# Optional: Open release page
read -p "Open release page in browser? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v xdg-open > /dev/null; then
        xdg-open "https://github.com/Aniketgawande1/Git-Sync/releases"
    elif command -v open > /dev/null; then
        open "https://github.com/Aniketgawande1/Git-Sync/releases"
    else
        echo "Please visit: https://github.com/Aniketgawande1/Git-Sync/releases"
    fi
fi

echo -e "${GREEN}🎉 Release process complete!${NC}"
