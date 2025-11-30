# 🎨 Anvesh's Dotfiles

> A modern, modular dotfile setup managed with GNU Stow for maximum portability and ease of use across Linux machines.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GNU Stow](https://img.shields.io/badge/managed%20with-GNU%20Stow-blue)](https://www.gnu.org/software/stow/)

---

## ✨ Features

- 🚀 **One-command setup** - Install all configs with a single command
- 🔗 **Symlink magic** - GNU Stow creates symlinks automatically
- 📦 **Modular** - Install only what you need
- 🔄 **Git-tracked** - All changes versioned and synced
- 💻 **Cross-machine** - Same configs on all your Linux boxes
- 🔒 **Private repo** - Keep your secrets safe

---

## 📁 Structure

```
~/dotfiles/
├── 📝 nvim/                  Neovim configuration
│   └── .config/nvim/         LazyVim setup with custom plugins
├── 🖥️  tmux/                  Tmux configuration
│   └── .tmux.conf            Vi-mode, custom keybindings
├── 🐚 zsh/                   Zsh shell configuration
│   └── .zshrc                Oh-My-Zsh, aliases, functions
├── 🎨 colors/                Terminal color schemes
│   └── .colors-config.zsh    LS_COLORS, syntax highlighting
├── 🦥 lazygit/               LazyGit TUI configuration
│   └── config.yml            Theme and keybindings
├── ⭐ starship/              Starship prompt configuration
│   └── .starship.toml        Custom prompt theme
├── 📜 scripts/               Custom shell scripts
│   └── bin/                  Executable scripts
│       ├── gitmoji-commit    AI-powered commit messages
│       └── ...
└── 📖 README.md              This file!
```

---

## 🚀 Quick Start

### Prerequisites

```bash
# Install GNU Stow
sudo apt install stow  # Debian/Ubuntu
sudo yum install stow  # RHEL/CentOS
sudo pacman -S stow    # Arch
```

### Installation (New Machine)

```bash
# 1. Clone this repository
git clone git@github.com:AnveshJarabani/dotfiles.git ~/dotfiles

# 2. Navigate to dotfiles
cd ~/dotfiles

# 3. Install all configs
stow nvim tmux zsh colors lazygit starship scripts

# Or install selectively
stow nvim      # Just Neovim
stow tmux zsh  # Just terminal configs
```

### Verification

```bash
# Check that symlinks were created
ls -la ~/.config/nvim    # Should point to ~/dotfiles/nvim/.config/nvim
ls -la ~/.tmux.conf      # Should point to ~/dotfiles/tmux/.tmux.conf
ls -la ~/.zshrc          # Should point to ~/dotfiles/zsh/.zshrc
```

---

## 🎮 Usage

### Install a Config Package

```bash
cd ~/dotfiles
stow nvim              # Install nvim config
```

### Remove a Config Package

```bash
stow -D nvim           # Remove nvim symlinks
```

### Reinstall (Refresh) a Config

```bash
stow -R nvim           # Remove and recreate symlinks
```

### Dry Run (Preview Changes)

```bash
stow -n nvim           # See what would happen without doing it
```

### Verbose Output

```bash
stow -v nvim           # Show detailed output
```

### Install Everything

```bash
stow */                # Stow all packages
```

---

## 📦 What's Included

### 📝 Neovim
- **Distribution:** LazyVim
- **Plugins:** 100+ plugins for development
- **Features:** LSP, autocomplete, git integration, file explorer
- **Custom keymaps:** GitHub code search, telescope, lazygit integration

### 🖥️ Tmux
- **Prefix:** `Ctrl+N`
- **Mode:** Vi-mode copy/paste
- **Plugins:** tmux-open, tmux-yank, sessionx, tmux-jump
- **Features:** Mouse support, 2.5M line history

### 🐚 Zsh
- **Framework:** Oh-My-Zsh
- **Plugins:** git, z, fzf, syntax-highlighting, autosuggestions
- **Theme:** Powerlevel10k
- **Features:** Custom functions, aliases, key bindings

### 🎨 Colors
- **LS_COLORS:** Vivid 256-color scheme
- **Syntax highlighting:** Enhanced command coloring
- **Man pages:** Colorized documentation
- **Grep:** Bright orange highlights

### 🦥 LazyGit
- **Theme:** Catppuccin Macchiato
- **Features:** Nerd fonts, file icons
- **Keybindings:** Custom navigation

### ⭐ Starship
- **Prompt:** Fast, customizable shell prompt
- **Features:** Git status, directory, language versions

---

## 🔄 Workflow

### Making Changes

```bash
# 1. Edit your config (it's symlinked!)
nvim ~/.config/nvim/init.lua

# 2. Changes are automatically in ~/dotfiles/
cd ~/dotfiles

# 3. Commit and push
git add .
git commit -m "✨ Updated nvim keymaps"
git push
```

### Syncing to Another Machine

```bash
# On the other machine
cd ~/dotfiles
git pull
# Changes are immediately reflected (symlinks!)
```

---

## 🆕 Adding New Configs

```bash
# 1. Create package directory
cd ~/dotfiles
mkdir -p myapp

# 2. Mirror the home directory structure
mkdir -p myapp/.config/myapp
cp ~/.config/myapp/* myapp/.config/myapp/

# 3. Stow it
stow myapp

# 4. Commit
git add myapp
git commit -m "➕ Add myapp config"
git push
```

---

## 🛠️ Troubleshooting

### Conflicts During Stow

If stow reports conflicts:

```bash
# Option 1: Backup existing files
mv ~/.config/nvim ~/.config/nvim.backup
stow nvim

# Option 2: Use --adopt (merge existing into dotfiles)
stow --adopt nvim
git diff  # Review changes
git checkout .  # Revert if needed
```

### Broken Symlinks

```bash
# Remove broken links
stow -D nvim

# Recreate them
stow nvim
```

### Check What Stow Would Do

```bash
# Dry run with verbose output
stow -nv nvim
```

---

## 📚 Key Bindings Reference

### Tmux (Prefix = Ctrl+N)

| Binding | Action |
|---------|--------|
| `Ctrl+\` | Enter copy mode |
| `Ctrl+O` | Session manager (sessionx) |
| `Prefix t` | New window |
| `Alt+I/K` | Switch sessions |

### Neovim

| Binding | Action |
|---------|--------|
| `<leader>gs` | GitHub code search |
| `<leader>zl` | LazyGit |
| `<leader>zf` | LazyGit fullscreen |
| `<leader><space>` | Find files |

---

## 🎯 Design Principles

1. **Modularity** - Each tool has its own stow package
2. **Portability** - Works on any Linux machine
3. **Safety** - Stow won't overwrite existing files
4. **Simplicity** - One command to install everything
5. **Git-friendly** - All configs version controlled

---

## 🤝 Contributing

This is my personal dotfiles repo, but feel free to:
- Fork it for your own use
- Submit issues if you find bugs
- Suggest improvements via PRs

---

## 📝 License

MIT License - See [LICENSE](LICENSE) file

---

## 💡 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [LazyVim Documentation](https://www.lazyvim.org/)
- [Oh-My-Zsh](https://ohmyz.sh/)
- [Tmux Guide](https://github.com/tmux/tmux/wiki)

---

<div align="center">

**Made with ❤️ and ☕ by [Anvesh Jarabani](https://github.com/AnveshJarabani)**

⭐ Star this repo if you find it useful!

</div>

---

## 🪟 Windows Configs

### 🖥️ Wezterm
- **Location:** `.config/wezterm/`
- **Theme:** Cyberdream
- **Features:** GPU-accelerated terminal for Windows

### 🔍 Fluent Search
- **Location:** `PERSONAL/PRIVATE/CUSTOMIZATIONS/fluent_search/`
- **Purpose:** Windows app launcher (Alfred/Spotlight alternative)
- **Includes:** Prioritization, Quick menu, Search tags, Processes, etc.

### 📂 OneCommander
- **Location:** `PERSONAL/PRIVATE/AJ_view_one_commander.json`
- **Purpose:** Dual-pane file manager for Windows

### ⭐ Oh-My-Posh
- **Location:** `PERSONAL/PRIVATE/azure-aj.omp.json`
- **Purpose:** Prompt theme for Windows PowerShell/Terminal

### 🎨 Windows Apps
- **Location:** `PERSONAL/PRIVATE/CUSTOMIZATIONS/`
- **Includes:** Various Windows application configs

---

## 🔄 Cross-Platform Support

This repo now includes configs for both **Linux** and **Windows**:

### On Linux (WSL):
```bash
cd ~/dotfiles
stow nvim tmux zsh colors lazygit starship scripts
```

### On Windows:
```powershell
cd ~/dotfiles
stow wezterm fluent-search onecommander ohmyposh windows-apps
```

### Both:
```bash
stow */  # Install everything!
```

