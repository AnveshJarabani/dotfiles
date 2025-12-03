#!/usr/bin/env zsh
# ============================================================================
# External Tools & Integrations (Lazy Loaded)
# ============================================================================
# Note: Most tools use zsh-defer for faster shell startup

# ──────────────────────────────────────────────────────────────────────────
# FZF - Fuzzy Finder
# ──────────────────────────────────────────────────────────────────────────
zsh-defer eval "$(fzf --zsh)"

# ──────────────────────────────────────────────────────────────────────────
# Zoxide - Smarter cd
# ──────────────────────────────────────────────────────────────────────────
zsh-defer eval "$(zoxide init zsh)"

# ──────────────────────────────────────────────────────────────────────────
# FZF Marks - Directory Bookmarks
# ──────────────────────────────────────────────────────────────────────────
zsh-defer source ~/.config/.fzf-marks/fzf-marks.plugin.zsh

# ──────────────────────────────────────────────────────────────────────────
# NVM - Node Version Manager
# ──────────────────────────────────────────────────────────────────────────
zsh-defer source "$NVM_DIR/nvm.sh"
zsh-defer source "$NVM_DIR/bash_completion"

# ──────────────────────────────────────────────────────────────────────────
# Google Cloud SDK
# ──────────────────────────────────────────────────────────────────────────
zsh-defer source '/root/google-cloud-sdk/path.zsh.inc'
zsh-defer source '/root/google-cloud-sdk/completion.zsh.inc'

# ──────────────────────────────────────────────────────────────────────────
# Atuin - Shell History (NOT deferred - needed for immediate up-arrow support)
# ──────────────────────────────────────────────────────────────────────────
source "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)" 2>/dev/null
