# Git-Sync 🔄

A powerful Python CLI tool for automatically syncing Git repositories with their upstream sources. Perfect for keeping your forks up-to-date with the original repositories.

## ✨ Features

- 🔄 **Automatic syncing** of multiple repositories with their upstream sources
- ⚙️ **YAML configuration** for easy management of multiple repos
- 🛡️ **Safe force-push** using `--force-with-lease` after rebasing
- ⏰ **Timeout handling** to prevent hanging operations
- 📊 **Progress tracking** with detailed status reporting
- 🚫 **Comprehensive error handling** with clear error messages
- 🎯 **Path validation** and Git repository checks
- 🔧 **Remote management** with automatic upstream configuration

## 📦 Installation

### Option 1: Install from Source (Recommended)

```bash
# Clone the repository
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync

# Install in development mode
pip install -e .
```

### Option 2: Install from PyPI (When Available)

```bash
pip install git-sync-cli
```

### Option 3: Download and Install Manually

1. **Download the latest release:**
   - Go to [Releases](https://github.com/Aniketgawande1/Git-Sync/releases)
   - Download the source code (ZIP or tar.gz)
   - Extract the archive

2. **Install:**
   ```bash
   cd Git-Sync
   pip install -e .
   ```

### Option 4: Quick Install Script

```bash
# One-liner installation
curl -sSL https://raw.githubusercontent.com/Aniketgawande1/Git-Sync/main/install.sh | bash
```

## 🚀 Quick Start

1. **Create a configuration file** (`config.yaml`):

```yaml
repos:
  - path: "/home/user/projects/my-fork"
    upstream: "https://github.com/original/repository.git"
    branch: "main"
    auto_push: true
  
  - path: "/home/user/projects/another-fork"
    upstream: "https://github.com/upstream/repo.git"
    branch: "master"
    auto_push: false
```

2. **Run the sync:**

```bash
git-sync --config config.yaml
```

## 📖 Usage

### Basic Usage

```bash
# Use default config.yaml in current directory
git-sync

# Specify custom config file
git-sync --config /path/to/your/config.yaml

# Get help
git-sync --help
```

### Configuration Format

The configuration file uses YAML format with the following structure:

```yaml
repos:
  - path: "/absolute/path/to/repository"     # Required: Local repository path
    upstream: "https://github.com/user/repo.git"  # Required: Upstream repository URL
    branch: "main"                           # Required: Branch to sync
    auto_push: true                          # Optional: Auto-push after sync (default: false)
```

#### Configuration Options:

- **`path`** (required): Absolute path to your local Git repository
- **`upstream`** (required): URL of the upstream repository to sync from
- **`branch`** (required): Branch name to sync (e.g., "main", "master", "develop")
- **`auto_push`** (optional): Whether to automatically push changes to origin after syncing (default: `false`)

### Example Workflow

What Git-Sync does for each repository:

1. 🔍 **Validates** the repository path and Git installation
2. 🌐 **Fetches** latest changes from origin
3. 🔗 **Adds/updates** upstream remote if needed
4. ⬇️ **Fetches** latest changes from upstream
5. 🔄 **Switches** to the specified branch
6. 🔀 **Rebases** your branch with upstream changes
7. ⬆️ **Pushes** changes to origin (if `auto_push: true`)

## 📋 Requirements

- **Python 3.6+**
- **Git** installed and available in PATH
- **PyYAML** and **Click** (automatically installed)

## 🔧 Development

### Setting up Development Environment

```bash
# Clone the repository
git clone https://github.com/Aniketgawande1/Git-Sync.git
cd Git-Sync

# Create virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install in development mode
pip install -e .

# Install development dependencies
pip install pytest black flake8
```

### Running Tests

```bash
# Run tests
pytest

# Run with coverage
pytest --cov=git_sync
```

### Code Formatting

```bash
# Format code
black git_sync/

# Check linting
flake8 git_sync/
```

## 🚨 Safety Features

- **Path Validation**: Checks if repository paths exist and are valid Git repositories
- **Timeout Protection**: 30-second timeout on Git operations to prevent hanging
- **Safe Force Push**: Uses `--force-with-lease` instead of `--force` for safer pushes
- **Error Recovery**: Continues processing other repositories even if one fails
- **Directory Restoration**: Always restores original working directory after operations

## 📊 Output Examples

### Successful Sync:
```
🔁 Syncing: /home/user/projects/my-repo
▶️ git fetch origin
▶️ git fetch upstream  
▶️ git checkout main
▶️ git rebase upstream/main
▶️ git push --force-with-lease origin main
✅ Successfully synced: /home/user/projects/my-repo

📊 Summary: 1/1 repositories synced successfully
```

### Error Handling:
```
🔁 Syncing: /home/user/invalid/path
❌ Failed to sync /home/user/invalid/path: Path does not exist: /home/user/invalid/path

📊 Summary: 0/1 repositories synced successfully
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Bug Reports & Feature Requests

- **Bug Reports**: [Create an Issue](https://github.com/Aniketgawande1/Git-Sync/issues/new?template=bug_report.md)
- **Feature Requests**: [Create an Issue](https://github.com/Aniketgawande1/Git-Sync/issues/new?template=feature_request.md)

## 📚 Additional Resources

- [Git Documentation](https://git-scm.com/doc)
- [YAML Syntax Guide](https://yaml.org/spec/1.2/spec.html)
- [Python Click Documentation](https://click.palletsprojects.com/)

## 🙏 Acknowledgments

- Thanks to all contributors who help improve this tool
- Inspired by the need to keep multiple repository forks synchronized
- Built with ❤️ using Python, Click, and PyYAML

---

**Made with ❤️ by [Aniket Gawande](https://github.com/Aniketgawande1)**
