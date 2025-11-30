# Package Management

Automated package tracking and installation system for reproducible development environments.

## 📋 Overview

This system tracks all your installed packages in simple text files, making it easy to replicate your entire development environment on a new machine.

**What it tracks:**
- 📦 APT packages (system utilities, tools)
- 📦 NPM global packages (JavaScript/Node tools)
- 🐍 Python pip packages (Python tools)
- 🦀 Rust cargo packages
- 🐹 Go binaries

## 🎯 How It Works

### On Your Current System (Source)

When you install new packages, snapshot them:

```bash
# 1. Install packages normally
sudo apt install ripgrep
npm install -g prettier
pip3 install --user httpie

# 2. Update package lists
cd ~/dotfiles/packages
./generate-packages.sh

# 3. Commit and push
git add packages-*.txt
git commit -m "📦 Add ripgrep, prettier, httpie"
git push
```

**What `generate-packages.sh` does:**
- Scans your system for manually-installed packages
- Generates separate `.txt` files for each package manager
- Each file is a simple list (one package per line)

### On a New System (Target)

Install everything with one command:

```bash
# 1. Clone dotfiles
git clone git@github-p:AnveshJarabani/dotfiles.git ~/dotfiles

# 2. Run the installer
cd ~/dotfiles/packages
./packages.sh

# That's it! All packages installed ✅
```

**What `packages.sh` does:**
- Reads each `packages-*.txt` file
- Installs packages using the appropriate package manager
- Handles errors gracefully (skips unavailable packages)
- Installs special tools (Oh My Zsh, Powerlevel10k)

## 📁 Files

```
packages/
├── README.md                    # This file
├── generate-packages.sh         # Snapshot current system
├── packages.sh                  # Install on new system
├── packages-apt.txt             # APT packages (173)
├── packages-npm.txt             # NPM packages (7)
├── packages-pip.txt             # Python packages (0)
├── packages-cargo.txt           # Rust packages (1)
└── packages-go.txt              # Go binaries (2)
```

## 🚀 Quick Start

### First Time Setup

```bash
# Generate initial package lists from your current system
cd ~/dotfiles/packages
./generate-packages.sh
git add packages-*.txt
git commit -m "📦 Initial package snapshot"
git push
```

### New System Setup

```bash
# Full workflow for new machine
git clone git@github-p:AnveshJarabani/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install packages
./packages/packages.sh

# Install dotfiles
./install.sh

# Setup pass
git clone git@github-p:AnveshJarabani/pass.git ~/.password-store

# Change shell
chsh -s $(which zsh)

# Restart terminal
```

## 🔄 Workflow Examples

### Adding a New Package

```bash
# Install something
sudo apt install fzf

# Update lists
cd ~/dotfiles/packages
./generate-packages.sh

# Commit
git add packages-apt.txt
git commit -m "📦 Add fzf"
git push
```

### Removing a Package

```bash
# Remove from system
sudo apt remove unwanted-package

# Update lists
cd ~/dotfiles/packages
./generate-packages.sh

# Commit
git add packages-apt.txt
git commit -m "📦 Remove unwanted-package"
git push
```

### Installing Specific Package Types Only

```bash
# Install only APT packages
cd ~/dotfiles/packages
sudo apt update
while read package; do sudo apt install -y "$package"; done < packages-apt.txt

# Install only NPM packages
while read package; do npm install -g "$package"; done < packages-npm.txt
```

## 📊 Current Package Count

| Type   | Count | File                |
|--------|-------|---------------------|
| APT    | 173   | packages-apt.txt    |
| NPM    | 7     | packages-npm.txt    |
| Python | 0     | packages-pip.txt    |
| Rust   | 1     | packages-cargo.txt  |
| Go     | 2     | packages-go.txt     |

**Total:** 183 packages tracked

## 🛠️ Manual Package List Editing

You can manually edit the `.txt` files:

```bash
# Edit APT packages
vim packages/packages-apt.txt

# Add or remove lines as needed
# One package per line, no special formatting required
```

## 🔍 Viewing Installed Packages

```bash
# See what's tracked
cat packages/packages-apt.txt
cat packages/packages-npm.txt

# Compare with system
apt-mark showmanual | sort > /tmp/current-apt.txt
diff packages/packages-apt.txt /tmp/current-apt.txt
```

## ⚠️ Important Notes

1. **APT packages** - Includes ALL manually installed packages, including dependencies. You may want to clean this list.

2. **System-specific packages** - Some packages may not exist on different Ubuntu/Debian versions. The installer skips these automatically.

3. **Conflicting packages** - If two packages conflict, the installer will fail. Remove one from the list.

4. **Credential-based installs** - Some packages (like GitHub CLI) require authentication. These are installed via custom logic in `packages.sh`.

## 🧹 Cleaning Package Lists

To reduce the list to essentials:

```bash
# Start fresh on a minimal system
# Only install what you actually use
# Then run generate-packages.sh

# OR manually edit the lists to remove:
# - Build dependencies you don't need
# - Auto-installed packages
# - System packages that come by default
```

## 📚 Alternative Approaches

### Why not Homebrew?

Homebrew is great but:
- Not all packages available in Homebrew
- Still need fallback to apt/npm/pip
- Adds another layer of abstraction

This approach uses native package managers directly.

### Why not Nix/Ansible?

- **Nix**: More powerful but steeper learning curve
- **Ansible**: Overkill for personal dotfiles
- **This**: Simple text files, easy to understand and modify

## 🐛 Troubleshooting

### Package not found

```bash
# Check if package exists
apt-cache search packagename

# If not found, remove from packages-apt.txt
```

### Permission denied

```bash
# Run with sudo (packages.sh already does this for apt)
sudo ./packages/packages.sh
```

### NPM packages fail

```bash
# Make sure Node.js is installed first
sudo apt install nodejs npm
```

## 💡 Tips

1. **Run `generate-packages.sh` regularly** - After installing new tools
2. **Keep lists clean** - Remove packages you no longer use
3. **Test on fresh VM** - Verify your package lists work before relying on them
4. **Document custom setups** - Add comments to `packages.sh` for special cases

## 🔗 Related

- [Main README](../README.md) - Dotfiles overview
- [install.sh](../install.sh) - Stow installation script
- [Pass Integration](../PASS-INTEGRATION.md) - Password management

---

**Last Updated:** November 30, 2024  
**Package Count:** 183 packages across 5 package managers
