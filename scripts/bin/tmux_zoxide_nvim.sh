#!/bin/bash

# 1. Use zoxide and fzf to select a directory.
# `zoxide query -l` lists directories.
# `fzf` provides the interactive selection.
SELECTED_DIR=$(zoxide query -l | fzf --height=40% --preview='eza --tree --color=always --icons --level=2 {}')

# 2. Exit if no directory was selected.
if [ -z "$SELECTED_DIR" ]; then
    echo "No directory selected."
    exit 0
fi

# 3. Get the directory name for the tmux session name.
# Using `basename` to get the last part of the path.
SESSION_NAME=$(basename "$SELECTED_DIR")
# Sanitize the session name: tmux doesn't like dots.
SESSION_NAME=${SESSION_NAME//./_}

# 4. Check if we are inside a tmux session already.
if [ -n "$TMUX" ]; then
    # We are inside tmux.
    # Check if the session already exists.
    if tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
        # Session exists, just switch to it.
        tmux switch-client -t "=$SESSION_NAME"
    else
        # Session does not exist, create it and switch.
        # Create the new session in the background.
        tmux new-session -d -s "$SESSION_NAME" -c "$SELECTED_DIR"
        # Send 'nvim' command to the new session.
        tmux send-keys -t "=$SESSION_NAME" 'nvim' C-m
        # Switch to the new session.
        tmux switch-client -t "=$SESSION_NAME"
    fi
else
    # We are not inside tmux.
    # Check if the session already exists.
    if tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
        # Session exists, just attach to it.
        tmux attach-session -t "=$SESSION_NAME"
    else
        # Session does not exist, create it and attach.
        # The -c flag sets the starting directory.
        # We start nvim directly as the session's command.
        tmux new-session -s "$SESSION_NAME" -c "$SELECTED_DIR" "nvim"
    fi
fi
