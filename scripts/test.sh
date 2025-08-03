#!/bin/bash
# Test script for Git-Sync
# Runs basic tests to ensure everything is working

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🧪 Git-Sync Test Suite${NC}"
echo "======================="

# Test 1: Python CLI
echo -e "${BLUE}Test 1: Python CLI${NC}"
if python cli.py --help > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Python CLI works${NC}"
else
    echo -e "${RED}❌ Python CLI failed${NC}"
    exit 1
fi

# Test 2: System health command
echo -e "${BLUE}Test 2: System health command${NC}"
if python cli.py sys health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ System health command works${NC}"
else
    echo -e "${RED}❌ System health command failed${NC}"
    exit 1
fi

# Test 3: Check if executable exists
echo -e "${BLUE}Test 3: Executable binary${NC}"
if [ -f "dist/git-sync" ] || [ -f "dist/git-sync-linux-amd64" ]; then
    # Find the executable
    EXECUTABLE=$(find dist/ -name "git-sync*" -type f | head -1)
    if [ -n "$EXECUTABLE" ]; then
        echo "Found executable: $EXECUTABLE"
        
        # Test executable
        if "$EXECUTABLE" --help > /dev/null 2>&1; then
            echo -e "${GREEN}✅ Executable binary works${NC}"
        else
            echo -e "${RED}❌ Executable binary failed${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠️  No executable found (run ./build.sh to create one)${NC}"
    fi
else
    echo -e "${YELLOW}⚠️  No executable found (run ./build.sh to create one)${NC}"
fi

# Test 4: Check required files
echo -e "${BLUE}Test 4: Required files${NC}"
REQUIRED_FILES=("cli.py" "chunks/__init__.py" "chunks/git_sync.py" "chunks/sys_check.py" "requirements.txt" "setup.py")

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
    else
        echo -e "${RED}❌ $file missing${NC}"
        exit 1
    fi
done

# Test 5: Import test
echo -e "${BLUE}Test 5: Module imports${NC}"
if python -c "from chunks import git_sync, sys_check; print('Imports OK')" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Module imports work${NC}"
else
    echo -e "${RED}❌ Module imports failed${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}🎉 All tests passed!${NC}"
echo ""
echo -e "${YELLOW}📋 Summary:${NC}"
echo "- Python CLI: Working"
echo "- Commands: Working"
echo "- File structure: Complete"
echo "- Module imports: Working"

if [ -f "dist/git-sync"* ]; then
    echo "- Binary executable: Available"
else
    echo "- Binary executable: Run './scripts/build.sh' to create"
fi

echo ""
echo -e "${BLUE}🚀 Ready for release!${NC}"
