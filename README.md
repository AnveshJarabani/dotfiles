# My Dotfiles 🎨

Managed with [GNU Stow](https://www.gnu.org/software/stow/)

## Structure

```
dotfiles/
├── nvim/       # Neovim config
├── tmux/       # Tmux config
├── zsh/        # Zsh config
├── scripts/    # Custom scripts
└── colors/     # Terminal colors
```

## Installation

```bash
git clone <your-repo> ~/dotfiles
cd ~/dotfiles
stow nvim tmux zsh scripts colors
```

## Usage

```bash
stow nvim     # Install nvim config
stow -D nvim  # Uninstall nvim config
stow -R nvim  # Reinstall nvim config
```
