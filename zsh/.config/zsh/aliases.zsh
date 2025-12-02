#!/usr/bin/env zsh
# ============================================================================
# Aliases Configuration
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────
# Shell & System
# ──────────────────────────────────────────────────────────────────────────
alias src="exec zsh"  # Reload shell (use exec for clean reload)
alias c="clear"
alias python=python3.13

# ──────────────────────────────────────────────────────────────────────────
# File Navigation & Viewing
# ──────────────────────────────────────────────────────────────────────────
alias ls="eza --header --icons --all --group-directories-first"
alias ll="eza --icons --long -a -h --group-directories-first"
alias tr="eza --icons --tree | sed 's/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g'"
alias trf="eza --icons --tree --only-dirs"
alias cat="batcat"

# Zoxide shortcuts
alias z=zi

# ──────────────────────────────────────────────────────────────────────────
# File Managers & Editors
# ──────────────────────────────────────────────────────────────────────────
alias r=". ranger"
alias r-fp='ranger --choosefile=$HOME/.rangerfp; echo $HOME/.rangerfp;'
alias nv="nvim"

# ──────────────────────────────────────────────────────────────────────────
# FZF-Enhanced Tools
# ──────────────────────────────────────────────────────────────────────────
alias fzf='fzf --preview="bat --color=always {}"'
alias find_fzf='zsh -c "find ${1:-/} | fzf"'
alias cz="code \$(fzf)"

# Custom FZF scripts (from ~/bin via stow)
alias zn='zoxide_openfiles_nvim.sh'
alias zl='fzf_listoldfiles.sh'
alias tn='tmux_zoxide_nvim.sh'

# ──────────────────────────────────────────────────────────────────────────
# Git Aliases
# ──────────────────────────────────────────────────────────────────────────
alias gconfig="git config user.name && git config user.email"
alias git-push='git push -u origin $(git symbolic-ref --short HEAD)'
alias gitprune='git branch --list | egrep -v "(^\*|master|main)" | xargs git branch -D'
alias lz="lazygit"
alias lzf="lazygit --screen-mode full"

# ──────────────────────────────────────────────────────────────────────────
# GitHub CLI
# ──────────────────────────────────────────────────────────────────────────
alias ghcs="gh copilot suggest"
alias gsearch="gh search code --owner mediwareinc"
alias gbrowse="gh browse -R"

# ──────────────────────────────────────────────────────────────────────────
# Cloud & Infrastructure
# ──────────────────────────────────────────────────────────────────────────
# Google Cloud
alias gauth=" DISPLAY='X' gcloud auth login & gcloud auth application-default login"
alias gsl="gcloud secrets list | rg \"\""
alias gsv="gcloud secrets versions access latest --secret=\"\""

# Spacelift
alias splan="spacectl stack local-preview"
alias sauth="spacectl profile login  --endpoint https://wellsky.app.us.spacelift.io"

# Terraform
alias fmt='terraform fmt -recursive'
alias tf-sync="rsync -avr --delete --exclude '*.tfvars' --exclude '*.tfstate' --exclude 'terraform.tf' --exclude '.terraform/' --exclude 'backend.tf' --exclude '*.hcl' --exclude 'db_list.yaml' --include '_config/' --exclude '_*'"

# Jira
alias jl="jira sprint  list --current -a$(jira me)"

# ──────────────────────────────────────────────────────────────────────────
# SSH & Remote Access
# ──────────────────────────────────────────────────────────────────────────
alias nuc3="ssh -i ~/.ssh/nuc3 root@192.168.1.103"
alias nuc2="ssh -i ~/.ssh/nuc2 root@192.168.1.102"
alias nuc4="ssh -i ~/.ssh/nuc4 root@192.168.1.104"
alias px="ssh -i ~/.ssh/px root@192.168.1.105"

# SFTP/SSHFS
alias sftp="sshfs -o IdentityFile=~/.ssh/sftpgo_wsl -p 2022 wsl@sftp.local:/ /mnt/sftpgo"
alias unmount="fusermount -u /mnt/sftpgo"

# ──────────────────────────────────────────────────────────────────────────
# Utilities
# ──────────────────────────────────────────────────────────────────────────
alias btop="btop --tty_on"
alias speedtest="speedtest| lolcat"
alias lolcat='/usr/games/lolcat'
alias b="buku --deep -S"  # Bookmark manager
alias cp-pwd="pwd | xclip -selection clipboard"
alias x-cp="xclip -selection clipboard"

# ──────────────────────────────────────────────────────────────────────────
# Windows Interop (WSL)
# ──────────────────────────────────────────────────────────────────────────
alias node="/mnt/c/Program\ Files/nodejs//node.exe"
alias oc="/mnt/c/Program\\ Files/OneCommander/OneCommander.exe"
alias ex="/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE"
