# 🔄 Git-Sync

[![GitHub release](https://img.shields.io/github/release/Aniketgawande1/Git-Sync.svg)](https://github.com/Aniketgawande1/Git-Sync/releases)
[![GitHub downloads](https://img.shields.io/github/downloads/Aniketgawande1/Git-Sync/total.svg)](https://github.com/Aniketgawande1/Git-Sync/releases)
[![License](https://img.shields.io/github/license/Aniketgawande1/Git-Sync.svg)](LICENSE)
[![Python](https://img.shields.io/badge/python-3.8+-blue.svg)](https://python.org)

**Git-Sync** is a powerful, standalone CLI tool for automating Git workflows and system monitoring. No Python installation required - just download and run!

## 🚀 Quick Start

### 📥 Download (Recommended)

Choose the right binary for your system:

| Platform | Architecture | Download Link |
|----------|-------------|---------------|
| 🐧 **Linux** | x86_64 | [`git-sync-linux-amd64`](https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-linux-amd64) |
| 🐧 **Linux** | ARM64 | [`git-sync-linux-arm64`](https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-linux-arm64) |
| 🍎 **macOS** | Intel | [`git-sync-darwin-amd64`](https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-darwin-amd64) |
| 🍎 **macOS** | Apple Silicon | [`git-sync-darwin-arm64`](https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-darwin-arm64) |
| 🪟 **Windows** | x86_64 | [`git-sync-windows-amd64.exe`](https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-windows-amd64.exe) |

### 💻 Installation

#### One-Line Install (Linux/macOS):
```bash
curl -sSL https://raw.githubusercontent.com/Aniketgawande1/Git-Sync/main/install.sh | bash
```

#### Manual Download

#### Linux/macOS:
```bash
# Download
wget https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-linux-amd64

# Make executable
chmod +x git-sync-linux-amd64

# Run
./git-sync-linux-amd64 --help
```

#### Windows:
```powershell
# Download git-sync-windows-amd64.exe from the link above
# Run directly
git-sync-windows-amd64.exe --help
```

## 🔧 Features

### 🚀 Git Automation
- **Auto-commit & push** with custom messages
- **Repository sync** across multiple branches
- **Batch operations** for multiple repositories

### 🛡️ System Monitoring
- **CPU usage** monitoring
- **Memory usage** tracking
- **Disk space** analysis
- **System health** reports

### 🌐 API Testing
- **Custom endpoint** testing
- **Response validation**
- **Performance metrics**

## 📖 Usage Examples

### System Health Check
```bash
# Check system resources
./git-sync sys health
```
Output:
```
CPU Usage: 15.2%
Memory Usage: 67.8%
Disk Usage: 42.1%
```

### Git Auto-commit
```bash
# Auto-commit and push changes
./git-sync git auto-commit --message "✨ Added new feature"
```
Output:
```
✅ Code is committed and pushed!
```

### Help & Commands
```bash
# Show all available commands
./git-sync --help

# Git-specific commands
./git-sync git --help

# System commands
./git-sync sys --help
```

## 🔧 Installation from Source

If you prefer to install from source or contribute to development:

### Prerequisites
- Python 3.8+
- pip

### Steps
```bash
# Clone repository
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync

# Install dependencies
pip install -r requirements.txt

# Install in development mode
pip install -e .

# Run
git-sync --help
```

## 🏗️ Building from Source

Want to build your own executable?

```bash
# Install PyInstaller
pip install pyinstaller

# Build executable
./build.sh

# Or manually
pyinstaller git-sync.spec --clean
```

The executable will be created in `dist/` directory.

## 📁 Project Structure

```
Git-Sync/
├── 📄 cli.py                 # Main CLI entry point
├── 📁 chunks/                # Feature modules
│   ├── git_sync.py          # Git automation
│   ├── sys_check.py         # System monitoring
│   └── api_tester.py        # API testing
├── 📁 utils/                # Utility modules
│   ├── config.py           # Configuration
│   └── logger.py           # Logging
├── 📄 build.sh              # Build script
├── 📄 Makefile              # Build automation
├── 📄 git-sync.spec         # PyInstaller config
└── 📄 requirements.txt      # Dependencies
```

## 🎯 Why Git-Sync?

### ✅ Advantages
- **Zero Dependencies**: No Python installation required
- **Cross-Platform**: Works on Linux, macOS, and Windows
- **Fast & Lightweight**: ~21MB standalone executable
- **Easy Distribution**: Single file download
- **Rich Output**: Beautiful terminal interface with colors

### 📊 Comparison

| Tool | Size | Dependencies | Installation |
|------|------|-------------|--------------|
| **Git-Sync** | ~21MB | None | Single binary |
| Git | ~20MB | System deps | Package manager |
| Python CLI | ~5MB | Python + deps | pip install |

## 🤝 Contributing

We welcome contributions! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch
3. **Make** your changes
4. **Test** your changes
5. **Submit** a pull request

### Development Setup
```bash
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync
pip install -r requirements.txt
pip install -e .
```

### Running Tests
```bash
# Test CLI functionality
python cli.py --help
python cli.py sys health
```

## 🐛 Troubleshooting

### Common Issues

**Q: "Permission denied" error on Linux/macOS?**
```bash
chmod +x git-sync-linux-amd64
```

**Q: "Command not found"?**
- Ensure you're in the correct directory
- Use `./git-sync-linux-amd64` (with `./`)

**Q: Windows SmartScreen warning?**
- Click "More info" → "Run anyway"
- Our binaries are safe but unsigned

**Q: Large file size?**
- This is normal for Python executables
- All dependencies are bundled for zero-dependency distribution

## 📝 Changelog

### v1.0.0 (Latest)
- ✨ Initial release
- 🚀 Git auto-commit functionality
- 🛡️ System health monitoring
- 📦 Standalone executables for all platforms

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## � Acknowledgments

- Built with [Typer](https://typer.tiangolo.com/) for CLI framework
- Uses [Rich](https://rich.readthedocs.io/) for beautiful terminal output
- Git operations powered by [GitPython](https://gitpython.readthedocs.io/)
- System monitoring via [psutil](https://psutil.readthedocs.io/)

## 📞 Support

- � **Bug Reports**: [GitHub Issues](https://github.com/Aniketgawande1/Git-Sync/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/Aniketgawande1/Git-Sync/discussions)
- 📧 **Contact**: [Your Email]

---

⭐ **Star this repo** if you find it helpful!

Made with ❤️ by [Aniket Gawande](https://github.com/Aniketgawande1)

