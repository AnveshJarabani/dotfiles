# -----------------------------------------------------------------------------
# Zoxide (zi) FZF Popup Override
# -----------------------------------------------------------------------------
# Set FZF options for zoxide interactive mode to use popup with preview
export EZA_COLORS="da=1;36:gm=1;33:gu=1;32:tr=1;35:tw=1;34:tx=1;32:ux=1;36"
export _ZO_FZF_OPTS="
--tmux 90%,95%
--exit-0
--select-1
--preview 'eza --icons --tree --color=always {2..} | sed \"s/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g\"'
--preview-window=right:50%:border-left
--height=100%
--layout=reverse
--border=bold
--separator=━
--scrollbar=▌▐
--margin=1
--padding=1
--info=inline
--prompt='❯❯'
--pointer='❯'
--marker='*'
--color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd
--color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75
--color=info:#56b6c2,prompt:#98c379,pointer:#e06c75
--color=marker:#c678dd,spinner:#61afef,header:#98c379
--color=border:#61afef,separator:#61afef,scrollbar:#61afef,preview-fg:#ffeb3b,preview-bg:#1e222a
"

eval "$(zoxide init zsh)"
