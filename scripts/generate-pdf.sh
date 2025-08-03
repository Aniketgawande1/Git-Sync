#!/bin/bash
# PDF Generation Script for Git-Sync Documentation
# Converts Markdown files to PDF using pandoc

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}📄 Git-Sync PDF Generator${NC}"
echo "============================"

# Check if pandoc is installed
if ! command -v pandoc &> /dev/null; then
    echo -e "${RED}❌ Error: pandoc is not installed${NC}"
    echo ""
    echo "Install pandoc:"
    echo "  Ubuntu/Debian: sudo apt install pandoc texlive-latex-base"
    echo "  macOS: brew install pandoc basictex"
    echo "  Windows: choco install pandoc miktex"
    exit 1
fi

# Check if LaTeX is available (for better PDF output)
if ! command -v pdflatex &> /dev/null; then
    echo -e "${YELLOW}⚠️  Warning: LaTeX not found. Using basic PDF generation.${NC}"
    PDF_ENGINE="--pdf-engine=wkhtmltopdf"
    
    # Check if wkhtmltopdf is available
    if ! command -v wkhtmltopdf &> /dev/null; then
        echo -e "${RED}❌ Error: Neither LaTeX nor wkhtmltopdf found${NC}"
        echo ""
        echo "Install one of:"
        echo "  LaTeX: sudo apt install texlive-latex-base"
        echo "  wkhtmltopdf: sudo apt install wkhtmltopdf"
        exit 1
    fi
else
    PDF_ENGINE="--pdf-engine=pdflatex"
fi

# Create docs directory
mkdir -p docs/

# PDF Generation Function
generate_pdf() {
    local input_file=$1
    local output_name=$2
    local title=$3
    
    echo -e "${BLUE}📝 Generating: $output_name${NC}"
    
    pandoc "$input_file" \
        -o "docs/$output_name" \
        $PDF_ENGINE \
        --variable geometry=margin=1in \
        --variable fontsize=11pt \
        --variable documentclass=article \
        --variable colorlinks=true \
        --variable linkcolor=blue \
        --variable urlcolor=blue \
        --variable toccolor=gray \
        --toc \
        --toc-depth=2 \
        --metadata title="$title" \
        --metadata author="Aniket Gawande" \
        --metadata date="$(date '+%B %d, %Y')" \
        2>/dev/null || {
            echo -e "${RED}❌ Failed to generate $output_name${NC}"
            return 1
        }
    
    echo -e "${GREEN}✅ Generated: docs/$output_name${NC}"
}

# Generate individual PDFs
echo -e "${BLUE}📚 Generating individual documentation PDFs...${NC}"

# Main README
if [ -f "README.md" ]; then
    generate_pdf "README.md" "Git-Sync-README.pdf" "Git-Sync: Standalone CLI Tool"
fi

# Quick Setup Guide
if [ -f "QUICK_SETUP.md" ]; then
    generate_pdf "QUICK_SETUP.md" "Git-Sync-Quick-Setup.pdf" "Git-Sync Quick Setup Guide"
fi

# Technical Guide
if [ -f "BINARY_DISTRIBUTION.md" ]; then
    generate_pdf "BINARY_DISTRIBUTION.md" "Git-Sync-Technical-Guide.pdf" "Git-Sync Binary Distribution Guide"
fi

# File Guide
if [ -f "FILE_GUIDE.md" ]; then
    generate_pdf "FILE_GUIDE.md" "Git-Sync-File-Guide.pdf" "Git-Sync Complete File Guide"
fi

# Project Report
if [ -f "PROJECT_REPORT.md" ]; then
    generate_pdf "PROJECT_REPORT.md" "Git-Sync-Project-Report.pdf" "Git-Sync Complete Project Report"
fi

# Generate combined documentation
echo ""
echo -e "${BLUE}📖 Generating combined documentation...${NC}"

# Create combined markdown file
cat > docs/COMBINED_DOCS.md << 'EOF'
# Git-Sync: Complete Documentation

## Table of Contents
1. [Main Documentation](#main-documentation)
2. [Quick Setup Guide](#quick-setup-guide)
3. [Technical Distribution Guide](#technical-distribution-guide)
4. [File Guide](#file-guide)
5. [Complete Project Report](#complete-project-report)

---

# Main Documentation
EOF

if [ -f "README.md" ]; then
    echo "" >> docs/COMBINED_DOCS.md
    cat README.md >> docs/COMBINED_DOCS.md
    echo -e "\n\n---\n" >> docs/COMBINED_DOCS.md
fi

echo "# Quick Setup Guide" >> docs/COMBINED_DOCS.md
if [ -f "QUICK_SETUP.md" ]; then
    echo "" >> docs/COMBINED_DOCS.md
    cat QUICK_SETUP.md >> docs/COMBINED_DOCS.md
    echo -e "\n\n---\n" >> docs/COMBINED_DOCS.md
fi

echo "# Technical Distribution Guide" >> docs/COMBINED_DOCS.md
if [ -f "BINARY_DISTRIBUTION.md" ]; then
    echo "" >> docs/COMBINED_DOCS.md
    cat BINARY_DISTRIBUTION.md >> docs/COMBINED_DOCS.md
    echo -e "\n\n---\n" >> docs/COMBINED_DOCS.md
fi

echo "# File Guide" >> docs/COMBINED_DOCS.md
if [ -f "FILE_GUIDE.md" ]; then
    echo "" >> docs/COMBINED_DOCS.md
    cat FILE_GUIDE.md >> docs/COMBINED_DOCS.md
    echo -e "\n\n---\n" >> docs/COMBINED_DOCS.md
fi

echo "# Complete Project Report" >> docs/COMBINED_DOCS.md
if [ -f "PROJECT_REPORT.md" ]; then
    echo "" >> docs/COMBINED_DOCS.md
    cat PROJECT_REPORT.md >> docs/COMBINED_DOCS.md
fi

# Generate combined PDF
generate_pdf "docs/COMBINED_DOCS.md" "Git-Sync-Complete-Documentation.pdf" "Git-Sync: Complete Documentation"

# Clean up temporary file
rm docs/COMBINED_DOCS.md

# Generate file sizes report
echo ""
echo -e "${BLUE}📊 Generated PDF files:${NC}"
echo "========================"
for pdf in docs/*.pdf; do
    if [ -f "$pdf" ]; then
        size=$(du -h "$pdf" | cut -f1)
        echo -e "${GREEN}📄 $(basename "$pdf"): $size${NC}"
    fi
done

echo ""
echo -e "${GREEN}🎉 PDF generation complete!${NC}"
echo -e "${YELLOW}📁 All PDFs saved in: docs/${NC}"
echo ""
echo -e "${BLUE}💡 Usage:${NC}"
echo "  View PDFs: ls docs/"
echo "  Open PDF: open docs/Git-Sync-Complete-Documentation.pdf"
echo "  Share: Upload docs/ folder to your preferred platform"

# Optional: Open the combined PDF
read -p "Open combined documentation PDF? (y/N): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v xdg-open > /dev/null; then
        xdg-open "docs/Git-Sync-Complete-Documentation.pdf"
    elif command -v open > /dev/null; then
        open "docs/Git-Sync-Complete-Documentation.pdf"
    else
        echo "Please open: docs/Git-Sync-Complete-Documentation.pdf"
    fi
fi
