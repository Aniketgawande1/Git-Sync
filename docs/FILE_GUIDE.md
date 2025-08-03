# 📁 File Structure Guide

Complete explanation of every file and folder in the Git-Sync project.

## 🏗️ Project Overview

```
Git-Sync/
├── 📄 Core Files
├── 📁 chunks/ (Feature Modules)
├── 📁 utils/ (Utilities)  
├── 📁 scripts/ (Automation)
├── 📁 docs/ (Documentation)
├── 📁 config/ (Build Config)
└── 📁 .github/ (CI/CD)
```

---

## 📄 Core Application Files

### `cli.py` - Main Entry Point
**Purpose**: Primary CLI interface that orchestrates all commands
**Size**: ~15 lines
**Key Functions**:
- Creates Typer app instance
- Registers command groups (`git`, `sys`)
- Handles global CLI options

```python
import typer
from chunks.git_sync import app as git_app
from chunks.sys_check import app as sys_app

app = typer.Typer()
app.add_typer(git_app, name="git")
app.add_typer(sys_app, name="sys")
```

### `requirements.txt` - Dependencies
**Purpose**: Python package dependencies
**Contents**:
```
typer[all]>=0.9.0
rich>=13.0.0
gitpython>=3.1.0
psutil>=5.9.0
```

### `setup.py` - Package Configuration
**Purpose**: Python package installation and distribution setup
**Key Features**:
- Entry point: `git-sync=cli:app`
- Console script registration
- Dependency management
- Package metadata

---

## 📁 chunks/ - Feature Modules

Modular architecture for different CLI functionalities.

### `__init__.py`
**Purpose**: Makes `chunks` a Python package
**Content**: Usually empty or package imports

### `git_sync.py` - Git Automation
**Purpose**: Git repository operations and automation
**Commands**:
- `auto-commit`: Stage all changes and commit with message
- `auto-push`: Push changes to remote repository
**Dependencies**: GitPython for Git operations
**Size**: ~20 lines

### `sys_check.py` - System Monitoring  
**Purpose**: System resource monitoring and health checks
**Commands**:
- `health`: Display CPU, memory, and disk usage
**Dependencies**: psutil for system information
**Size**: ~15 lines

### `api_tester.py` - API Testing (Future)
**Purpose**: HTTP API testing and monitoring utilities
**Status**: Placeholder for future development
**Planned Features**:
- Endpoint testing
- Response validation
- Performance monitoring

---

## 📁 utils/ - Utility Functions

Shared utilities used across different modules.

### `config.py` - Configuration Management
**Purpose**: Application configuration and settings
**Features**:
- User preferences
- Default values
- Configuration file handling
- Environment variable support

### `logger.py` - Logging System
**Purpose**: Centralized logging for debugging and monitoring
**Features**:
- Different log levels
- File and console output
- Formatted log messages
- Debug information

---

## 📁 scripts/ - Automation Scripts

Build, test, and release automation tools.

### `build.sh` - Binary Builder
**Purpose**: Creates standalone executables using PyInstaller
**Process**:
1. Detects platform (Linux/macOS/Windows)
2. Installs PyInstaller if needed
3. Cleans previous builds
4. Builds platform-specific binary
5. Tests the executable
**Output**: `dist/git-sync-[platform]-[arch]`

### `test.sh` - Test Suite
**Purpose**: Automated testing to ensure quality
**Tests**:
1. Python CLI functionality
2. System health command
3. Binary executable validation
4. Required files verification
5. Module import testing

### `release.sh` - Release Management
**Purpose**: Automates version releases
**Process**:
1. Validates git repository
2. Prompts for version number
3. Creates git tag
4. Pushes to GitHub
5. Triggers CI/CD pipeline

### `install.sh` - User Installation
**Purpose**: One-line installation script for end users
**Features**:
- Platform detection
- Binary download
- Permission setting
- PATH installation
- Verification

### `generate-pdf.sh` - Documentation Generator
**Purpose**: Converts Markdown docs to PDF
**Requirements**: pandoc, LaTeX
**Output**: Professional PDF documentation

---

## 📁 docs/ - Documentation

Complete project documentation in Markdown format.

### `README.md` - Main Documentation
**Purpose**: Primary project information for GitHub
**Sections**:
- Quick start guide
- Usage examples
- Installation instructions
- Development setup

### `PROJECT_REPORT.md` - Complete Analysis
**Purpose**: Comprehensive project documentation
**Content**: Architecture, features, workflows, technical specs
**Length**: ~200 lines

### `QUICK_SETUP.md` - User Guide
**Purpose**: Fast setup instructions for end users
**Focus**: Installation and basic usage

### `BINARY_DISTRIBUTION.md` - Technical Guide
**Purpose**: Binary creation and distribution details
**Audience**: Developers and maintainers

### `WORKFLOW_GUIDE.md` - Development Processes
**Purpose**: Development, testing, and release workflows
**Audience**: Contributors and maintainers

### `FILE_GUIDE.md` - This Document
**Purpose**: Complete file structure explanation
**Audience**: Developers and contributors

### `IMPLEMENTATION_SUMMARY.md` - Technical Summary
**Purpose**: High-level technical overview
**Focus**: Architecture and design decisions

---

## 📁 config/ - Build Configurations

Build system and deployment configurations.

### `Dockerfile` - Container Configuration
**Purpose**: Docker containerization for Git-Sync
**Features**:
- Multi-stage build
- Optimized image size
- Security best practices
- Development and production modes

### `.dockerignore` - Docker Exclusions
**Purpose**: Files to exclude from Docker build context
**Contents**: Build artifacts, documentation, temporary files

### `Makefile` - Build Automation
**Purpose**: Traditional make-based build system
**Targets**:
- `make build`: Build executable
- `make test`: Run tests
- `make clean`: Clean artifacts
- `make install`: Install locally

### `git-sync.spec` - PyInstaller Configuration
**Purpose**: Detailed PyInstaller build specification
**Features**:
- Binary optimization settings
- Include/exclude rules
- Platform-specific configurations
- Compression settings

---

## 📁 .github/ - CI/CD Workflows

GitHub Actions automation for continuous integration.

### `workflows/build-release.yml` - Release Pipeline
**Purpose**: Automated multi-platform builds on releases
**Triggers**: Git tag push (e.g., `v1.0.0`)
**Matrix**: 5 platform builds (Linux x86_64/ARM64, macOS Intel/ARM, Windows x86_64)
**Output**: GitHub Releases with binaries

---

## 📄 Root Configuration Files

### `.gitignore` - Git Exclusions
**Purpose**: Prevents committing sensitive or temporary files
**Categories**:
- Python cache files (`__pycache__/`)
- Build artifacts (`dist/`, `build/`)
- Virtual environments (`venv/`, `.venv/`)
- IDE files (`.vscode/`, `.idea/`)
- Secrets (`.env`, `*.key`)

### `LICENSE` - MIT License
**Purpose**: Open source license terms
**Type**: MIT License (permissive)

---

## 🔍 File Dependencies

### Import Relationships
```
cli.py
├── chunks.git_sync
├── chunks.sys_check
└── typer

chunks/git_sync.py
├── typer
├── git (GitPython)
└── utils.logger

chunks/sys_check.py
├── typer
├── psutil
├── rich
└── utils.config
```

### Build Dependencies
```
build.sh
├── config/git-sync.spec
└── PyInstaller

test.sh
├── cli.py
├── All chunks/ modules
└── dist/ binaries

release.sh
├── Git repository
└── GitHub API
```

---

## 📊 File Statistics

| Category | Files | Total Lines | Purpose |
|----------|-------|-------------|---------|
| Core Application | 3 | ~50 | Main CLI functionality |
| Feature Modules | 4 | ~80 | Specific features |
| Utilities | 2 | ~60 | Shared functions |
| Scripts | 5 | ~500 | Automation |
| Documentation | 7 | ~1500 | Project docs |
| Configuration | 4 | ~200 | Build configs |
| **Total** | **25** | **~2390** | **Complete project** |

---

## 🎯 File Usage Patterns

### **Development Workflow**
1. Edit code in `cli.py`, `chunks/`, or `utils/`
2. Test with `scripts/test.sh`
3. Build with `scripts/build.sh`
4. Document changes in `docs/`

### **Release Workflow**
1. Update version in `setup.py`
2. Run `scripts/release.sh`
3. GitHub Actions builds all platforms
4. Binaries uploaded to GitHub Releases

### **User Workflow**
1. Download binary or run `scripts/install.sh`
2. Use `git-sync` commands
3. Reference `docs/QUICK_SETUP.md` for help

---

**This file structure provides a clean, organized, and professional codebase that's easy to understand, maintain, and extend.** 🚀
