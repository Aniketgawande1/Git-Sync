# 🔄 Development Workflow Guide

Complete guide to developing, testing, building, and releasing Git-Sync.

## 🎯 Overview

This guide covers the complete development lifecycle from initial setup to production release.

---

## 🏗️ Development Setup

### Prerequisites
```bash
# Required tools
python3.8+
git
pip

# Optional but recommended
docker
pandoc (for PDF generation)
```

### Initial Setup
```bash
# Clone repository
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync

# Install dependencies
pip install -r requirements.txt

# Test installation
python cli.py --help
```

---

## 💻 Development Workflow

### 1. Feature Development

#### Branch Creation
```bash
# Create feature branch
git checkout -b feature/new-awesome-feature

# Start development
vim cli.py
vim chunks/new_feature.py
```

#### Code Structure
```python
# Follow existing patterns
# chunks/new_feature.py
import typer
from rich.console import Console

app = typer.Typer()
console = Console()

@app.command()
def new_command():
    """Description of new command."""
    console.print("✅ New feature working!")

if __name__ == "__main__":
    app()
```

#### Integration
```python
# cli.py - Add to main CLI
from chunks.new_feature import app as new_app
app.add_typer(new_app, name="new")
```

### 2. Testing During Development

#### Quick Testing
```bash
# Test Python CLI directly
python cli.py --help
python cli.py new new-command

# Test imports
python -c "from chunks import new_feature"
```

#### Comprehensive Testing
```bash
# Run full test suite
./scripts/test.sh
```

#### Manual Testing
```bash
# Test in different environments
python3.8 cli.py --help
python3.9 cli.py --help
python3.10 cli.py --help
```

### 3. Code Quality

#### Style Guidelines
- Follow PEP 8
- Use type hints where appropriate
- Add docstrings to functions
- Keep functions small and focused

#### Documentation Updates
```bash
# Update relevant docs when adding features
vim docs/README.md
vim docs/PROJECT_REPORT.md
```

---

## 🔧 Build Workflow

### Local Building

#### Quick Build
```bash
# Build for current platform
./scripts/build.sh

# Test the binary
./dist/git-sync-linux-amd64 --help
```

#### Clean Build
```bash
# Clean previous builds
rm -rf build/ dist/

# Fresh build
./scripts/build.sh
```

#### Cross-Platform Testing
```bash
# Test on different platforms (if available)
# Linux
./dist/git-sync-linux-amd64 --help

# macOS (if on Mac)
./dist/git-sync-darwin-amd64 --help
```

### Docker Building
```bash
# Build Docker image
docker build -t git-sync .

# Test Docker image
docker run --rm git-sync --help
```

---

## 🧪 Testing Workflow

### Automated Testing
```bash
# Run all tests
./scripts/test.sh

# Expected output:
# ✅ Python CLI works
# ✅ System health command works
# ✅ Executable binary works
# ✅ Required files exist
# ✅ Module imports work
```

### Manual Testing Checklist

#### Basic Functionality
- [ ] `git-sync --help` shows help
- [ ] `git-sync sys health` shows system info
- [ ] `git-sync git --help` shows git commands

#### Git Commands (in git repo)
- [ ] `git-sync git auto-commit --message "test"` works
- [ ] `git-sync git auto-push` works (if remote configured)

#### Error Handling
- [ ] Commands fail gracefully with helpful messages
- [ ] Invalid arguments show proper error messages
- [ ] Non-git directories handle git commands appropriately

#### Platform Testing
- [ ] Binary runs on target platforms
- [ ] No missing dependencies
- [ ] Proper file permissions

---

## 📦 Release Workflow

### Pre-Release Checklist

#### Code Quality
- [ ] All tests pass (`./scripts/test.sh`)
- [ ] No obvious bugs or issues
- [ ] New features documented
- [ ] Version number updated in `setup.py`

#### Documentation
- [ ] README.md updated
- [ ] CHANGELOG.md updated (if exists)
- [ ] New features documented
- [ ] Installation instructions current

#### Build Testing
- [ ] Local build successful
- [ ] Binary works correctly
- [ ] No missing dependencies
- [ ] Appropriate file size (~21MB)

### Release Process

#### 1. Version Management
```bash
# Update version in setup.py
vim setup.py
# Change version="1.0.0" to version="1.1.0"

# Commit version update
git add setup.py
git commit -m "🔖 Bump version to 1.1.0"
git push origin main
```

#### 2. Create Release
```bash
# Use release script
./scripts/release.sh

# OR manually:
git tag v1.1.0
git push origin v1.1.0
```

#### 3. Automated Pipeline
GitHub Actions automatically:
1. Builds for all 5 platforms
2. Creates GitHub Release
3. Uploads binaries
4. Notifies maintainers

#### 4. Post-Release Verification
```bash
# Test download URLs
wget https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-linux-amd64

# Test installation script
curl -sSL https://raw.githubusercontent.com/Aniketgawande1/Git-Sync/main/scripts/install.sh | bash
```

---

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

#### Trigger Events
- **Push to main**: Run tests
- **Pull request**: Run tests and build check
- **Tag push** (`v*`): Full release build

#### Build Matrix
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest, windows-latest]
    python-version: [3.8, 3.9, 3.10, 3.11]
```

#### Pipeline Steps
1. **Checkout**: Get source code
2. **Setup Python**: Install Python version
3. **Install Dependencies**: `pip install -r requirements.txt`
4. **Run Tests**: `./scripts/test.sh`
5. **Build Binary**: `./scripts/build.sh`
6. **Upload Artifacts**: Store build results
7. **Create Release**: (tag builds only)

### Pipeline Configuration
```bash
# Check workflow status
# .github/workflows/build-release.yml

# View build logs
# GitHub Actions tab in repository
```

---

## 🐛 Debugging Workflow

### Common Issues

#### Import Errors
```bash
# Check Python path
python -c "import sys; print(sys.path)"

# Verify module structure
python -c "from chunks import git_sync, sys_check"

# Fix: Ensure __init__.py files exist
touch chunks/__init__.py
```

#### Build Failures
```bash
# Check PyInstaller logs
cat build/git-sync/warn-git-sync.txt

# Common fixes:
pip install --upgrade pyinstaller
pip install --upgrade setuptools
```

#### Runtime Errors
```bash
# Run with verbose output
python cli.py --help --verbose

# Check binary execution
./dist/git-sync-linux-amd64 --help --verbose
```

### Debugging Tools

#### Development Mode
```bash
# Run with Python for easier debugging
python -v cli.py --help  # Verbose imports

# Use debugger
python -m pdb cli.py sys health
```

#### Production Debugging
```bash
# Check binary with debugging
strace ./dist/git-sync-linux-amd64 --help 2>&1 | head -50

# Check dependencies
ldd ./dist/git-sync-linux-amd64
```

---

## 📊 Performance Monitoring

### Metrics to Track

#### Build Performance
- Build time per platform
- Binary size trends
- CI/CD pipeline duration

#### Runtime Performance
- CLI startup time
- Memory usage
- Command execution time

### Monitoring Tools
```bash
# Measure startup time
time ./dist/git-sync-linux-amd64 --help

# Monitor memory usage
/usr/bin/time -v ./dist/git-sync-linux-amd64 sys health

# Profile Python version
python -m cProfile cli.py sys health
```

---

## 🔧 Maintenance Tasks

### Regular Maintenance

#### Weekly
- [ ] Check for dependency updates
- [ ] Review open issues and PRs
- [ ] Test latest builds

#### Monthly
- [ ] Update dependencies in requirements.txt
- [ ] Review and update documentation
- [ ] Check build pipeline performance

#### Per Release
- [ ] Update version numbers
- [ ] Update changelog
- [ ] Test on all target platforms
- [ ] Update download links

### Dependency Management
```bash
# Check for outdated packages
pip list --outdated

# Update requirements
pip-review --auto

# Test with new dependencies
./scripts/test.sh
```

---

## 🚀 Advanced Workflows

### Multi-Platform Development
```bash
# Use Docker for cross-platform testing
docker run --rm -v $(pwd):/app python:3.9 bash -c "cd /app && pip install -r requirements.txt && python cli.py --help"
```

### Plugin Development
```bash
# Future: Plugin architecture
# chunks/plugins/
# └── my_plugin.py
```

### Integration Testing
```bash
# Test with real Git repositories
cd /tmp
git init test-repo
cd test-repo
git-sync git auto-commit --message "Test commit"
```

---

**This workflow ensures consistent, high-quality releases and makes contributing to Git-Sync straightforward and efficient.** 🎯
