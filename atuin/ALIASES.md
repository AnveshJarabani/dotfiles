# Atuin Shell History - Aliases Reference

This document lists all commonly used aliases for quick reference with Atuin search (Ctrl+R).

## Shell & System
- `src` → `exec zsh` - Reload shell
- `c` → `clear` - Clear screen
- `python` → `python3.13` - Python 3.13

## File Navigation & Viewing
- `ls` → `eza --header --icons --all --group-directories-first` - List files
- `ll` → `eza --icons --long -a -h --group-directories-first` - Long list
- `tr` → `eza --icons --tree | sed 's/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g'` - Tree view
- `trf` → `eza --icons --tree --only-dirs` - Tree folders only
- `cat` → `batcat` - Cat with syntax highlighting
- `z` → `zi` - Zoxide interactive

## File Managers & Editors
- `r` → `. ranger` - Ranger file manager
- `r-fp` → `ranger --choosefile=$HOME/.rangerfp; echo $HOME/.rangerfp;` - Ranger with file picker
- `nv` → `nvim` - Neovim

## FZF Tools
- `fzf` → `fzf --preview="bat --color=always {}"` - FZF with preview
- `find_fzf` → `zsh -c "find ${1:-/} | fzf"` - Find with FZF
- `cz` → `code $(fzf)` - VSCode with FZF picker
- `zn` → `zoxide_openfiles_nvim.sh` - Zoxide + Nvim files
- `zl` → `fzf_listoldfiles.sh` - FZF old files list
- `tn` → `tmux_zoxide_nvim.sh` - Tmux + Zoxide + Nvim

## Git Aliases
- `gconfig` → `git config user.name && git config user.email` - Show git config
- `git-push` → `git push -u origin $(git symbolic-ref --short HEAD)` - Push current branch
- `gitprune` → `git branch --list | egrep -v "(^\*|master|main)" | xargs git branch -D` - Delete all branches except main/master
- `lz` → `lazygit` - LazyGit TUI
- `lzf` → `lazygit --screen-mode full` - LazyGit fullscreen

## GitHub CLI
- `ghcs` → `gh copilot suggest` - GitHub Copilot CLI
- `gsearch` → `gh search code --owner mediwareinc` - Search code in org
- `gbrowse` → `gh browse -R` - Browse repo

## Google Cloud
- `gauth` → ` DISPLAY='X' gcloud auth login & gcloud auth application-default login` - GCloud auth
- `gsl` → `gcloud secrets list | rg ""` - List GCloud secrets
- `gsv` → `gcloud secrets versions access latest --secret=""` - Get secret value

## Spacelift
- `splan` → `spacectl stack local-preview` - Spacelift plan preview
- `sauth` → `spacectl profile login --endpoint https://wellsky.app.us.spacelift.io` - Spacelift auth

## Terraform
- `fmt` → `terraform fmt -recursive` - Format terraform files
- `tf-sync` → `rsync -avr --delete --exclude '*.tfvars' --exclude '*.tfstate' --exclude 'terraform.tf' --exclude '.terraform/' --exclude 'backend.tf' --exclude '*.hcl' --exclude 'db_list.yaml' --include '_config/' --exclude '_*'` - Sync terraform configs

## Jira
- `jl` → `jira sprint list --current -a$(jira me)` - List current sprint issues

## SSH & Remote Access
- `nuc2` → `ssh nuc2` - Connect to NUC2
- `nuc3` → `ssh nuc3` - Connect to NUC3
- `nuc4` → `ssh nuc4` - Connect to NUC4
- `px` → `ssh px` - Connect to Proxmox
- `sftp` → `sshfs -o IdentityFile=~/.ssh/sftpgo_wsl -p 2022 wsl@sftp.local:/ /mnt/sftpgo` - Mount SFTP
- `unmount` → `fusermount -u /mnt/sftpgo` - Unmount SFTP
- `ssh-load` → `load_all_ssh_keys` - Load SSH keys from pass
- `ssh-clear` → `clear_ssh_keys` - Clear SSH keys from agent
- `ssh-list` → `ssh-add -l` - List loaded SSH keys

## Utilities
- `btop` → `btop --tty_on` - System monitor
- `speedtest` → `speedtest | lolcat` - Speed test with colors
- `lolcat` → `/usr/games/lolcat` - Rainbow colors
- `b` → `buku --deep -S` - Bookmark search
- `cp-pwd` → `pwd | xclip -selection clipboard` - Copy current path
- `x-cp` → `xclip -selection clipboard` - Copy to clipboard

## Windows Interop (WSL)
- `node` → `/mnt/c/Program Files/nodejs//node.exe` - Windows Node.js
- `oc` → `/mnt/c/Program Files/OneCommander/OneCommander.exe` - OneCommander
- `ex` → `/mnt/c/Program Files/Microsoft Office/root/Office16/EXCEL.EXE` - Excel

---

## Usage with Atuin

1. **Search history**: Press `Ctrl+R`
2. **Type alias name or command**: Start typing to filter
3. **Navigate**: Use arrow keys
4. **Execute**: Press Enter
5. **Edit before execute**: Press Tab

## Atuin Dotfiles Integration

All aliases are also stored in Atuin's dotfiles feature:

```bash
# List all aliases in Atuin
atuin dotfiles alias list

# Set a new alias
atuin dotfiles alias set myalias "my command"

# Delete an alias
atuin dotfiles alias delete myalias
```

These aliases sync across machines when using Atuin sync!

## Tips

- Just type the full command once, Atuin will remember it
- Aliases are auto-expanded when you use them
- Use Atuin's fuzzy search to find commands by keywords
- All command history syncs across machines (if sync enabled)

---

*Last updated: 2025-12-03*
