#!/usr/bin/env zsh
# ============================================================================
# SSH Agent with Pass Integration
# ============================================================================
# Automatically loads SSH keys from pass into ssh-agent
# Keys are never stored in plaintext on disk
# ============================================================================

# SSH agent socket file
SSH_AGENT_SOCK_FILE="$HOME/.ssh/agent.sock"

# Start ssh-agent if not running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    # Start agent and save environment to file
    ssh-agent -s -a "$SSH_AGENT_SOCK_FILE" > "$HOME/.ssh/agent.env"
    source "$HOME/.ssh/agent.env" > /dev/null
else
    # Load existing agent environment
    if [ -f "$HOME/.ssh/agent.env" ]; then
        source "$HOME/.ssh/agent.env" > /dev/null
    fi
fi

# Export SSH_AUTH_SOCK if not set
if [ -z "$SSH_AUTH_SOCK" ]; then
    if [ -S "$SSH_AGENT_SOCK_FILE" ]; then
        export SSH_AUTH_SOCK="$SSH_AGENT_SOCK_FILE"
    elif [ -f "$HOME/.ssh/agent.env" ]; then
        source "$HOME/.ssh/agent.env" > /dev/null
    fi
fi

# Function to load SSH key from pass into agent
load_ssh_key_from_pass() {
    local key_name=$1
    local pass_path="ssh/$key_name"
    
    # Check if key exists in pass
    if ! pass show "$pass_path" &>/dev/null; then
        echo "❌ Key not found in pass: $pass_path"
        return 1
    fi
    
    # Check if key is already loaded
    if ssh-add -l 2>/dev/null | grep -q "$key_name"; then
        return 0
    fi
    
    # Load key from pass into agent
    pass show "$pass_path" | ssh-add - &>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Loaded SSH key: $key_name"
    else
        echo "❌ Failed to load: $key_name"
        return 1
    fi
}

# Function to load all SSH keys from pass
load_all_ssh_keys() {
    echo "🔑 Loading SSH keys from pass into ssh-agent..."
    
    # List of SSH keys to load
    local ssh_keys=(
        "git_p"          # Personal GitHub (AnveshJarabani)
        "git_work"       # Work GitHub (AnveshJarabani-WellSky)
        "nuc2"
        "nuc3"
        "nuc4"
        "px"
        "pihole"
        "pihole2"
        "pihole3"
        "sftpgo_wsl"
        "google_compute_engine"
    )
    
    for key in "${ssh_keys[@]}"; do
        load_ssh_key_from_pass "$key"
    done
    
    echo ""
    echo "📋 Currently loaded keys:"
    ssh-add -l 2>/dev/null || echo "  (none)"
}

# Function to clear all keys from agent
clear_ssh_keys() {
    ssh-add -D &>/dev/null
    echo "🗑️  Cleared all SSH keys from agent"
}

# Alias for convenience
alias ssh-load='load_all_ssh_keys'
alias ssh-clear='clear_ssh_keys'
alias ssh-list='ssh-add -l'

# Auto-load keys on shell startup (optional - uncomment to enable)
# load_all_ssh_keys
