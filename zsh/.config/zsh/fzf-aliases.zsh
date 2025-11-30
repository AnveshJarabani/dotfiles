# -----------------------------------------------------------------------------
# Custom FZF Aliases (zt, zc)
# -----------------------------------------------------------------------------

# Alias for zt (file finder) - prints selected file to command line
alias zt='selected=$(eval "$FZF_CTRL_T_COMMAND" | fzf-tmux -p 90%,80% -- --border=bold --preview "bat -n --color=always {}" --preview-window "right:50%:border-left" --color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd --color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75 --color=info:#56b6c2,prompt:#98c379,pointer:#e06c75 --color=marker:#c678dd,spinner:#61afef,header:#98c379 --color=border:#61afef,preview-fg:#ffeb3b,preview-bg:#1e222a) && echo -n "$selected"'

# Alias for zc (directory changer) - changes to selected directory
alias zc='dir=$(eval "$FZF_ALT_C_COMMAND" | fzf-tmux -p 90%,80% -- --border=bold --preview "eza --icons --tree --color=always {} | head -200 | sed '\''s/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g'\''" --preview-window "right:50%:border-left" --color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd --color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75 --color=info:#56b6c2,prompt:#98c379,pointer:#e06c75 --color=marker:#c678dd,spinner:#61afef,header:#98c379 --color=border:#61afef,preview-fg:#ffeb3b,preview-bg:#1e222a) && cd "$dir"'
