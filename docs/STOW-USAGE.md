# How to Use Stow with Your Dotfiles 🚀

## First Time Setup (Already Done ✅)
Your dotfiles are now in `~/dotfiles/` and pushed to GitHub!

## To Apply Dotfiles with Stow

### Step 1: Backup Current Configs
```bash
mkdir -p ~/backup-configs
mv ~/.config/nvim ~/backup-configs/
mv ~/.tmux.conf ~/backup-configs/
mv ~/.zshrc ~/backup-configs/
```

### Step 2: Use Stow to Create Symlinks
```bash
cd ~/dotfiles
stow nvim     # Creates ~/.config/nvim -> ~/dotfiles/nvim/.config/nvim
stow tmux     # Creates ~/.tmux.conf -> ~/dotfiles/tmux/.tmux.conf
stow zsh      # Creates ~/.zshrc -> ~/dotfiles/zsh/.zshrc
stow scripts  # Creates ~/bin/* -> ~/dotfiles/scripts/bin/*
stow colors   # Creates ~/.colors-config.zsh
```

### Step 3: Verify
```bash
ls -la ~/.config/nvim  # Should show it's a symlink
ls -la ~/.tmux.conf    # Should show it's a symlink
```

## On a New Machine

```bash
# 1. Clone your dotfiles
git clone git@github.com:AnveshJarabani/dotfiles.git ~/dotfiles

# 2. Install stow
sudo apt install stow

# 3. Apply all configs
cd ~/dotfiles
stow nvim tmux zsh scripts colors

# Done! All configs are now symlinked ✅
```

## Useful Commands

```bash
stow -n nvim        # Dry run (see what would happen)
stow -v nvim        # Verbose output
stow -D nvim        # Remove symlinks (unstow)
stow -R nvim        # Restow (remove and recreate symlinks)
stow */             # Stow everything at once
```

## When You Edit Configs

Since they're symlinked, edits are automatically tracked:
```bash
nvim ~/.config/nvim/init.lua  # Edit config
cd ~/dotfiles
git add .
git commit -m "Updated nvim config"
git push
```

## Notes

- Stow won't overwrite existing files (safety!)
- Private repo keeps your sensitive data safe
- Easy to sync across machines
