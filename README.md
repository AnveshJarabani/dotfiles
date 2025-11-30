# 🎨 Anvesh's Dotfiles

> A modern, modular dotfile setup managed with GNU Stow for maximum portability and ease of use across Linux and Windows machines.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![GNU Stow](https://img.shields.io/badge/managed%20with-GNU%20Stow-blue)](https://www.gnu.org/software/stow/)
[![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows-lightgrey)](https://github.com/AnveshJarabani/dotfiles)

---

## ✨ Features

- 🚀 **One-command setup** - Install all configs with a single command
- 🔗 **Symlink magic** - GNU Stow creates symlinks automatically
- 📦 **Modular** - Install only what you need
- 🔄 **Git-tracked** - All changes versioned and synced
- 💻 **Cross-platform** - Linux + Windows configs in one repo
- 🔒 **Private repo** - Keep your secrets safe

---

## 📁 Structure

```
~/dotfiles/
├── 🐧 LINUX CONFIGS
│   ├── nvim/              Neovim (LazyVim + 100+ plugins)
│   ├── tmux/              Tmux (Vi-mode, custom keybindings)
│   ├── zsh/               Zsh (Oh-My-Zsh + P10k)
│   ├── p10k/              Powerlevel10k theme
│   ├── colors/            Terminal color schemes
│   ├── lazygit/           LazyGit TUI
│   ├── lazydocker/        LazyDocker TUI
│   ├── starship/          Starship prompt
│   ├── btop/              System monitor
│   ├── yazi/              File manager
│   ├── ranger/            File manager
│   ├── neofetch/          System info
│   ├── aicommit/          AI commit messages
│   ├── gitignore/         Global git ignore
│   └── scripts/           Custom scripts
│
├── 🪟 WINDOWS CONFIGS
│   ├── wezterm/           Terminal + themes
│   ├── fluent-search/     App launcher
│   ├── onecommander/      File manager
│   ├── ohmyposh/          Prompt theme
│   └── windows-apps/      VSCode, Vimium, etc
│
└── 📚 DOCUMENTATION
    ├── README.md          This file
    ├── STOW-USAGE.md      Quick reference
    └── LICENSE            MIT License
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
cd ~/dotfiles

# 2. Install configs (choose your OS)

# Linux - All configs
stow nvim tmux zsh p10k colors lazygit lazydocker starship btop yazi ranger neofetch aicommit gitignore scripts

# Windows - All configs  
stow wezterm fluent-search onecommander ohmyposh windows-apps

# Or install everything at once!
stow */
```

---

## 🎮 Usage

### Install a Package

```bash
cd ~/dotfiles
stow nvim              # Install nvim config
```

### Remove a Package

```bash
stow -D nvim           # Remove nvim symlinks
```

### Reinstall (Refresh)

```bash
stow -R nvim           # Remove and recreate symlinks
```

### Dry Run (Preview)

```bash
stow -n nvim           # See what would happen
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

## 📦 Package Details

### 🐧 Linux Packages

| Package | Description | Key Features |
|---------|-------------|--------------|
| **nvim** | Neovim config | LazyVim, 100+ plugins, LSP, GitHub search |
| **tmux** | Terminal multiplexer | Vi-mode, sessionx, 2.5M line history |
| **zsh** | Shell config | Oh-My-Zsh, P10k, custom aliases |
| **p10k** | Powerlevel10k | Custom prompt theme |
| **colors** | Terminal colors | LS_COLORS, syntax highlighting |
| **lazygit** | Git TUI | Catppuccin theme, nerd fonts |
| **lazydocker** | Docker TUI | Container management |
| **starship** | Fast prompt | Git status, language versions |
| **btop** | System monitor | Beautiful resource monitor |
| **yazi** | File manager | Modern TUI file manager |
| **ranger** | File manager | Vi-like file manager |
| **neofetch** | System info | Fancy system information |
| **aicommit** | AI commits | OpenAI-powered commit messages |
| **gitignore** | Git ignore | Global gitignore patterns |
| **scripts** | Custom scripts | Utility scripts |

### 🪟 Windows Packages

| Package | Description | Key Features |
|---------|-------------|--------------|
| **wezterm** | Terminal | GPU-accelerated, Lua config |
| **fluent-search** | App launcher | Alfred/Spotlight for Windows |
| **onecommander** | File manager | Dual-pane file manager |
| **ohmyposh** | Prompt | PowerShell/Terminal prompt |
| **windows-apps** | App configs | VSCode, Vimium, etc |

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
mkdir -p myapp/.config/myapp

# 2. Copy your config
cp -r ~/.config/myapp/* myapp/.config/myapp/

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
# Remove and recreate
stow -D nvim
stow nvim
```

### Preview Changes

```bash
# Dry run with verbose output
stow -nv nvim
```

---

## 📚 Key Bindings

### Tmux (Prefix = Ctrl+N)

| Binding | Action |
|---------|--------|
| `Ctrl+\` | Enter copy mode |
| `Ctrl+O` | Session manager |
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
2. **Portability** - Works on any Linux/Windows machine
3. **Safety** - Stow won't overwrite existing files
4. **Simplicity** - One command to install everything
5. **Git-friendly** - All configs version controlled
6. **Cross-platform** - Same workflow on Windows + Linux

---

## 💡 Resources

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [LazyVim Documentation](https://www.lazyvim.org/)
- [Oh-My-Zsh](https://ohmyz.sh/)
- [Tmux Guide](https://github.com/tmux/tmux/wiki)
- [Wezterm](https://wezfurlong.org/wezterm/)

---

<div align="center">

**Made with ❤️ and ☕ by [Anvesh Jarabani](https://github.com/AnveshJarabani)**

⭐ Star this repo if you find it useful!

</div>
