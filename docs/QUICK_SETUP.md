# 🚀 Git-Sync Quick Setup Guide

Get Git-Sync running in under 2 minutes!

## ⚡ Installation Options

### Option 1: One-Line Install (Recommended)
```bash
curl -sSL https://raw.githubusercontent.com/Aniketgawande1/Git-Sync/main/scripts/install.sh | bash
```

### Option 2: Manual Download
```bash
# Linux x64
wget https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-linux-amd64
chmod +x git-sync-linux-amd64
sudo mv git-sync-linux-amd64 /usr/local/bin/git-sync

# macOS Intel
wget https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-darwin-amd64
chmod +x git-sync-darwin-amd64
sudo mv git-sync-darwin-amd64 /usr/local/bin/git-sync

# macOS Apple Silicon
wget https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-darwin-arm64
chmod +x git-sync-darwin-arm64
sudo mv git-sync-darwin-arm64 /usr/local/bin/git-sync

# Windows (PowerShell)
Invoke-WebRequest -Uri "https://github.com/Aniketgawande1/Git-Sync/releases/latest/download/git-sync-windows-amd64.exe" -OutFile "git-sync.exe"
```

### Option 3: Python Installation
```bash
# Clone and install
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync
pip install -r requirements.txt
python cli.py --help
```

## 🎯 Basic Usage

### System Monitoring
```bash
# Check system health
git-sync sys health

# Monitor resources
git-sync sys --help
```

### Git Automation
```bash
# Auto-commit with message
git-sync git auto-commit --message "✨ Add new feature"

# Auto-push to origin
git-sync git auto-push

# See all git commands
git-sync git --help
```

## 🔧 First Time Setup

1. **Verify Installation**
   ```bash
   git-sync --help
   ```

2. **Test System Commands**
   ```bash
   git-sync sys health
   ```

3. **Test in Git Repository**
   ```bash
   cd your-git-repo
   git-sync git auto-commit --message "Testing Git-Sync"
   ```

## 🚨 Common Issues

### "Command not found"
- **Linux/macOS**: Make sure `/usr/local/bin` is in your PATH
- **Windows**: Add the executable location to your PATH environment variable

### "Permission denied"
```bash
chmod +x git-sync-*
```

### Import Errors (Python mode)
```bash
pip install -r requirements.txt
```

## 🎉 You're Ready!

Now you can use Git-Sync to automate your daily Git and system tasks!

**Next Steps:**
- Read the [Complete Documentation](PROJECT_REPORT.md)
- Check [Binary Distribution Guide](BINARY_DISTRIBUTION.md)
- Explore [Advanced Workflows](WORKFLOW_GUIDE.md)
