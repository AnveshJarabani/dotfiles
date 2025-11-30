# -----------------------------------------------------------------------------
# FZF-TAB Configuration - Slick interactive completions
# -----------------------------------------------------------------------------
# Disable default completion menu
zstyle ':completion:*' menu no

# Enable fzf-tab for all completions
zstyle ':fzf-tab:*' fzf-command fzf

# Use tmux popup for completions
zstyle ':fzf-tab:*' fzf-flags --height=80% --layout=reverse --border=bold --margin=1 --padding=1

# Color scheme matching our theme
zstyle ':fzf-tab:*' fzf-flags --color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd --color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75 --color=info:#56b6c2,prompt:#98c379,pointer:#e06c75 --color=marker:#c678dd,spinner:#61afef,header:#98c379 --color=border:#61afef

# Show previews for different commands
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --tree --color=always $realpath | head -200 | sed "s/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g"'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'bat --color=always $realpath 2>/dev/null || eza --icons --color=always $realpath'
zstyle ':fzf-tab:complete:cat:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:complete:nvim:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:complete:vim:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:complete:git-*:*' fzf-preview 'bat --color=always $realpath 2>/dev/null || eza --icons --color=always $realpath'

# Show systemd unit status
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# Show environment variable values
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# Show command help
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word 2>/dev/null | bat --plain --language=man --color=always'

# Preview process info
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags --preview-window=down:3:wrap

# Switch groups with < and >
zstyle ':fzf-tab:*' switch-group '<' '>'

# Continuous trigger (accept and continue)
zstyle ':fzf-tab:*' continuous-trigger '/'
