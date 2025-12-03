#!/usr/bin/env zsh
# ============================================================================
# ZSH Configuration - Modular & Optimized
# ============================================================================
# This is a minimal .zshrc that sources modular configuration files.
# See ~/.config/zsh/ for organized settings.

# ──────────────────────────────────────────────────────────────────────────
# Powerlevel10k Instant Prompt (MUST be at top)
# ──────────────────────────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ──────────────────────────────────────────────────────────────────────────
# Oh-My-Zsh Configuration
# ──────────────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART="true"
ZSH_DISABLE_COMPFIX=true  # Skip slow compinit security checks

# Essential plugins
plugins=(
    forgit
    zsh-defer
    you-should-use
    git
    tmux
    fzf-tab
    fast-syntax-highlighting
    zsh-autosuggestions
    zsh-fzf-history-search
    copybuffer
    copypath
    colored-man-pages
)

# Load fzf-history config BEFORE oh-my-zsh
source ~/.config/zsh/fzf-history-config.zsh

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Defer non-essential plugins for faster startup
zsh-defer omz plugin load zsh-completions docker-compose terraform gcloud tldr uv

# ──────────────────────────────────────────────────────────────────────────
# History Configuration
# ──────────────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/.zsh_history
setopt SHARE_HISTORY

# ──────────────────────────────────────────────────────────────────────────
# Completion System
# ──────────────────────────────────────────────────────────────────────────
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'     # Group descriptions
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Enable menu selection
zmodload zsh/complist

# ──────────────────────────────────────────────────────────────────────────
# Load Modular Configuration Files
# ──────────────────────────────────────────────────────────────────────────
# Export environment variables
source ~/.config/zsh/exports.zsh

# Load deferred config files for faster startup
zsh-defer source ~/.config/zsh/fzf-tab-config.zsh
zsh-defer source ~/.config/zsh/zoxide-config.zsh
zsh-defer source ~/.config/zsh/fzf-config.zsh
zsh-defer source ~/.config/zsh/fzf-aliases.zsh
zsh-defer source ~/.config/zsh/colors-config.zsh

# Load aliases
source ~/.config/zsh/aliases.zsh

# Load key bindings
source ~/.config/zsh/keybindings.zsh

# Load external tools (FZF, Zoxide, Atuin, NVM, etc.)
source ~/.config/zsh/external.zsh

# Load SSH agent with pass integration
source ~/.config/zsh/ssh-agent-pass.zsh

# ──────────────────────────────────────────────────────────────────────────
# Legacy Aliases File (if exists)
# ──────────────────────────────────────────────────────────────────────────
[[ -f ~/.aliases ]] && source ~/.aliases

# ──────────────────────────────────────────────────────────────────────────
# Tmux Git Auto-fetch
# ──────────────────────────────────────────────────────────────────────────
tmux-git-autofetch() {
  (/root/.tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)
}
# Uncomment to enable auto-fetch on directory change:
# add-zsh-hook chpwd tmux-git-autofetch

# ──────────────────────────────────────────────────────────────────────────
# End of Configuration
# ──────────────────────────────────────────────────────────────────────────
