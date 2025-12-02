# 🚀 ZSH Configuration - Modular & Optimized

A highly organized, performant ZSH configuration using modular design principles.

## 📁 Structure

```
zsh/
├── .zshrc                           # Main configuration (minimal, sources modules)
└── .config/zsh/                     # Modular configuration files
    ├── aliases.zsh                  # All command aliases
    ├── exports.zsh                  # Environment variables & PATH
    ├── keybindings.zsh              # Keyboard shortcuts
    ├── external.zsh                 # External tool integrations
    ├── fzf-tab-config.zsh          # FZF tab completion config
    ├── fzf-config.zsh              # FZF settings
    ├── fzf-aliases.zsh             # FZF-specific aliases
    ├── fzf-history-config.zsh      # FZF history search
    ├── zoxide-config.zsh           # Zoxide (smart cd) config
    └── colors-config.zsh           # Color schemes
```

## ✨ Features

### 🎯 Performance Optimized
- **Lazy Loading**: Heavy tools (FZF, Zoxide, NVM, Google Cloud SDK) load in background
- **Instant Prompt**: Shell appears ready in ~0.5s, background tasks complete asynchronously
- **Deferred Plugins**: Non-essential completions load after prompt

### 🎨 Theme & Prompt
- **Powerlevel10k**: Fast, customizable prompt with instant-prompt support
- **True Color Support**: Rich terminal colors

### 🔧 Tools & Integrations

#### Shell Enhancement
- **FZF**: Fuzzy finder for files, history, and more
- **Zoxide**: Smarter directory navigation (frecency-based)
- **Atuin**: Advanced shell history with sync capabilities
- **Fast Syntax Highlighting**: Real-time command validation
- **Zsh Autosuggestions**: Fish-like command suggestions

#### Development Tools
- **Git Integration**: Enhanced git aliases and status
- **Lazygit**: Terminal UI for git
- **NVM**: Node version manager
- **Terraform**: Infrastructure as code

#### Cloud & Infrastructure
- **Google Cloud SDK**: GCP CLI tools
- **Spacelift**: Infrastructure orchestration
- **Jira**: Issue tracking integration

#### File Management
- **Eza**: Modern `ls` replacement with icons
- **Bat**: Better `cat` with syntax highlighting
- **Ranger**: Terminal file manager
- **Buku**: Bookmark manager

## 🔑 Key Bindings

| Keybinding | Action |
|------------|--------|
| `↑` / `↓` | Atuin history search |
| `Ctrl+R` | FZF history search |
| `Tab` | FZF tab completion |
| `Ctrl+←` / `Ctrl+→` | Jump by word |
| `Ctrl+Backspace` | Delete word backward |

## 📝 Important Aliases

### Quick Navigation
```bash
z <dir>       # Jump to directory (zoxide)
zi            # Interactive directory picker
zn            # Open recent files in nvim
```

### File Viewing
```bash
ls            # List files with icons
ll            # Long list format
tr            # Tree view with decorations
cat <file>    # View file with syntax highlighting
```

### Git Shortcuts
```bash
lz            # Launch lazygit
lzf           # Lazygit full-screen
git-push      # Push current branch
gitprune      # Delete all local branches except main/master
```

### Development
```bash
fmt           # Terraform format recursively
splan         # Spacelift preview
jl            # List current sprint tasks
```

### SSH Shortcuts
```bash
nuc2/3/4      # Connect to home servers
px            # Connect to Proxmox
sftp          # Mount SFTP share
unmount       # Unmount SFTP share
```

## 🚀 Quick Start

### Installation
```bash
# Clone dotfiles
cd ~/dotfiles
stow zsh

# Reload shell
exec zsh
```

### Customization

#### Add New Aliases
Edit `~/.config/zsh/aliases.zsh`:
```bash
alias myalias="my command"
```

#### Add Environment Variables
Edit `~/.config/zsh/exports.zsh`:
```bash
export MY_VAR="value"
```

#### Add Key Bindings
Edit `~/.config/zsh/keybindings.zsh`:
```bash
bindkey '^X' my-widget
```

### Reload Configuration
```bash
src           # Fast reload with exec zsh
```

## 🎛️ Configuration Details

### History Settings
- **Size**: 10,000 commands
- **Location**: `~/.cache/.zsh_history`
- **Sharing**: Enabled across sessions

### Completion Features
- Case-insensitive matching
- Colored output
- Group descriptions
- Menu selection

### Lazy Loaded Tools
These load in the background after prompt appears:
- FZF initialization
- Zoxide initialization
- NVM (Node Version Manager)
- Google Cloud SDK
- Additional completions (Docker, Terraform, etc.)

### Immediately Loaded
These load during startup for instant availability:
- **Atuin**: Required for up-arrow history search
- **Core aliases**: Command shortcuts
- **Environment variables**: PATH and exports
- **Key bindings**: Keyboard shortcuts

## 🔍 Troubleshooting

### Slow Startup
```bash
# Profile startup time
time zsh -i -c exit

# Check deferred tasks
# Most heavy tasks should be deferred with zsh-defer
```

### Aliases Not Working
```bash
# Verify file is sourced
grep "aliases.zsh" ~/.zshrc

# Check for errors
zsh -n ~/.config/zsh/aliases.zsh
```

### Atuin Up-Arrow Not Working
```bash
# Check binding
bindkey | grep -E "\\^\\[\\[A"

# Should show: "^[[A" _atuin_search_widget

# If not, verify atuin loads AFTER history-substring-search plugin
```

## 📦 Dependencies

### Required
- `zsh` >= 5.8
- `oh-my-zsh`
- `powerlevel10k`
- `fzf`
- `zoxide`
- `atuin`

### Optional (but recommended)
- `eza` - Better ls
- `bat` - Better cat
- `lazygit` - Git TUI
- `ranger` - File manager
- `buku` - Bookmark manager

## 🤝 Contributing

1. Edit files in `~/dotfiles/zsh/`
2. Changes take effect immediately (symlinked)
3. Commit to git repo
4. No need to re-stow unless adding new files

## 📄 License

Personal configuration - use freely!

---

**Last Updated**: December 2025  
**Maintained By**: AnveshJarabani
