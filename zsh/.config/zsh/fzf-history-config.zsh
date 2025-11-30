# -----------------------------------------------------------------------------
# FZF History Search Configuration - Matching Zoxide Theme
# -----------------------------------------------------------------------------

# Configure zsh-fzf-history-search to match zoxide popup style
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1
export ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=1

# Extra args for fzf history search - match zoxide theme exactly
export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS="--tmux 90%,95% --exit-0 --layout=reverse --border=bold --separator=━ --scrollbar=▌▐ --margin=1 --padding=1 --info=inline --prompt='❯❯' --pointer='❯' --marker='*' --color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd --color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75 --color=info:#56b6c2,prompt:#98c379,pointer:#e06c75 --color=marker:#c678dd,spinner:#61afef,header:#98c379 --color=border:#61afef,separator:#61afef,scrollbar:#61afef"

