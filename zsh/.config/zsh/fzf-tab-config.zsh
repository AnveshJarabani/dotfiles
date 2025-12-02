# -----------------------------------------------------------------------------
# FZF-TAB Configuration - Slick interactive completions
# -----------------------------------------------------------------------------
# Disable default completion menu
zstyle ':completion:*' menu no

# Enable fzf-tab for all completions - use regular fzf (respects FZF_DEFAULT_OPTS)
zstyle ':fzf-tab:*' fzf-command fzf

# Enable preview window
zstyle ':fzf-tab:*' show-group full

# Match zn/zl/tn style - these override/add to FZF_DEFAULT_OPTS for fzf-tab
zstyle ':fzf-tab:*' fzf-flags \
  --tmux=90%,95% \
  --preview-window=right:50%:wrap

# Show previews for different commands
# Default catch-all preview FIRST - directories get eza tree, files get bat
zstyle ':fzf-tab:complete:*:*' fzf-preview '[[ -d $realpath ]] && eza --tree --color=always --icons --level=2 $realpath || bat --color=always $realpath 2>/dev/null'

# Specific command overrides
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --color=always --icons --level=2 $realpath'
# For autocd and ./ paths (bare directory/file completion)
zstyle ':fzf-tab:complete:-command-:*' fzf-preview '[[ -d $realpath ]] && eza --tree --color=always --icons --level=2 $realpath || bat --color=always $realpath 2>/dev/null'
zstyle ':fzf-tab:complete:ls:*' fzf-preview '[[ -d $realpath ]] && eza --tree --color=always --icons --level=2 $realpath || bat --color=always $realpath'
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
