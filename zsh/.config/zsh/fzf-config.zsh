# -----------------------------------------------------------------------------
# FZF Configuration
# -----------------------------------------------------------------------------

# For tmux-fzf popup window
export FZF_TMUX_OPTS="-p 90%,80%"

# Default command for fzf to use for finding files.
# - 'fd' is a fast file finder.
# - '--type f' searches for files only.
# - fd respects .gitignore and hides .git by default.
export FZF_DEFAULT_COMMAND='fd --type f'

# Options for Ctrl+T (file finder)
# Use the default command for finding files.
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Add a preview window showing the file's content with 'bat'.
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' --preview-window 'right:50%:border-left'"

# Options for Alt+C (directory finder)
# - '--type d' searches for directories only.
# - '--hidden' includes hidden directories.
# - '--exclude .git' explicitly excludes the .git folder.
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
# Add a preview window showing the directory structure with 'tree'.
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200' --preview-window 'right:50%:border-left'"

# Default options for fzf's appearance and behavior.
# This will override the fzf alias you had.
export FZF_DEFAULT_OPTS='
--tmux 90%,95%
--layout=reverse
--border=bold
--separator=━
--scrollbar=▌▐
--margin=1
--padding=1
--info=inline
--prompt="❯❯"
--pointer="❯"
--marker="*"
--color=fg:#ffeb3b,bg:#1e222a,hl:#c678dd
--color=fg+:#61afef,bg+:#2c313c,hl+:#e06c75
--color=info:#56b6c2,prompt:#98c379,pointer:#e06c75
--color=marker:#c678dd,spinner:#61afef,header:#98c379
--color=border:#61afef,separator:#61afef,scrollbar:#61afef
'
