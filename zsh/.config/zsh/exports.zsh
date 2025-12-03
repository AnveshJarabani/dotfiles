#!/usr/bin/env zsh
# ============================================================================
# Environment Variables & Path Configuration
# ============================================================================

# ──────────────────────────────────────────────────────────────────────────
# PATH Configuration
# ──────────────────────────────────────────────────────────────────────────
export PATH=.:$PATH
export PATH=/root/bin:$PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:~/go/bin
export PATH="$PATH:$HOME/PERSONAL/PRIVATE"
export PATH="$PATH:$HOME/home/root/sqlpackage"
export PATH="$PATH:$HOME/.tfenv/bin"
export PATH="$PATH:/mnt/c/Users/AnveshJarabani/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# ──────────────────────────────────────────────────────────────────────────
# Default Applications
# ──────────────────────────────────────────────────────────────────────────
export BROWSER='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
export EDITOR='nvim'
export COLORTERM=truecolor

# ──────────────────────────────────────────────────────────────────────────
# Tool-Specific Settings
# ──────────────────────────────────────────────────────────────────────────
export SPACECTL_SKIP_STACK_PROMPT=true

# Google Cloud / Vertex AI
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT='wsh-dev-vertex-wsky'
export GOOGLE_CLOUD_LOCATION='us-central1'

# Jira API (from password store)
export JIRA_API_TOKEN=$(pass work/jira-api-token)

# NVM
export NVM_DIR="$HOME/.nvm"

# GPG - Update TTY for each shell session
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1
