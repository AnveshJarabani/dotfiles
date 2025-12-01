# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
if [ -f ~/.aliases ]; then
   . ~/.aliases
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# If you come from bash you might have to change your $PATH.
# export PATH="usr/local/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
export PATH=.:$PATH
export ZSH="$HOME/.oh-my-zsh"
# export PATH="$PATH:/usr/bin/python3.13"
export PATH=/root/bin:$PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH=$PATH:~/go/bin
export PATH="$PATH:$HOME/PERSONAL/PRIVATE"
export PATH="$PATH:$HOME/home/root/sqlpackage"
export PATH="$PATH:$HOME/.tfenv/bin"
export PATH="$PATH:/mnt/c/Users/AnveshJarabani/AppData/Local/Programs/Microsoft\ VS\ Code/Code.exe"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export BROWSER='/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe'
export EDITOR='nvim'
export SPACECTL_SKIP_STACK_PROMPT=true
#FOR USING VERTEX AI MODEL 
export GOOGLE_GENAI_USE_VERTEXAI=true
export GOOGLE_CLOUD_PROJECT='wsh-dev-vertex-wsky'
export JIRA_API_TOKEN=$(pass work/jira-api-token)
export GOOGLE_CLOUD_LOCATION='us-central1'
# enable ftp mount - 
# mount -t cifs //nuc3.local/wd2tb1/DOCUMENTS ~/DOCS_WD2TB1 -o username=aj,password=$(pass mount/nuc3-cifs) 2>/dev/null
# mount -t cifs //nuc3.local/wd6tb ~/wd6tb -o username=aj,password=$(pass mount/nuc3-cifs) 2>/dev/null

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/.zsh_history
setopt SHARE_HISTORY
# Basic auto/tab complete:
fpath=(/usr/share/zsh/vendor-completions $fpath)
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Colored completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u' # Group descriptions
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
LISTMAX=0  # Always show list, never ask
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
compinit
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
setopt autocd
plugins=(
    git
		z
		tmux
		fzf-tab
		zsh-autosuggestions
		zsh-syntax-highlighting
		zsh-fzf-history-search
		zsh-history-substring-search
		zsh-interactive-cd
		copybuffer
		docker-compose
		terraform
		gcloud
		colored-man-pages
		tldr
		uv
		copypath)
# Load fzf-history config BEFORE oh-my-zsh
source ~/.config/zsh/fzf-history-config.zsh
ZSH_TMUX_AUTOSTART="true"
source $ZSH/oh-my-zsh.sh
source ~/.config/.fzf-marks/fzf-marks.plugin.zsh

# Load fzf AFTER oh-my-zsh so zsh-fzf-history-search takes priority for Ctrl+R
eval "$(fzf --zsh)"

eval "$(zoxide init zsh)"
# Source modular configurations from ~/.config/zsh/
source ~/.config/zsh/fzf-tab-config.zsh
source ~/.config/zsh/zoxide-config.zsh
source ~/.config/zsh/fzf-config.zsh
source ~/.config/zsh/fzf-aliases.zsh
source ~/.config/zsh/colors-config.zsh
alias src="source ~/.zshrc"
alias python=python3.13
alias z=zi
alias lolcat='/usr/games/lolcat'
alias r-fp='ranger --choosefile=$HOME/.rangerfp; echo $HOME/.rangerfp;'
alias node="/mnt/c/Program\ Files/nodejs//node.exe"
alias ls="eza --header --icons --all --group-directories-first"
alias ll="eza --icons --long -a -h --group-directories-first"
alias tr="eza --icons --tree | sed 's/├/┣/g; s/└/┗/g; s/─/━/g; s/│/┃/g'"
alias trf="eza --icons --tree --only-dirs"
alias find_fzf='zsh -c "find ${1:-/} | fzf"'
alias fzf='fzf --preview="bat --color=always {}"'
alias fmt='terraform fmt -recursive'
alias cat="batcat"
alias speedtest="speedtest| lolcat"
alias c="clear"
alias r=". ranger"
alias nv="nvim"
alias btop="btop --tty_on"
alias gconfig="git config user.name && git config user.email"
alias gauth=" DISPLAY='X' gcloud auth login & gcloud auth application-default login"
alias gsl="gcloud secrets list | rg \"\""
alias gsv="gcloud secrets versions access latest --secret=\"\""
alias git-push='git push -u origin $(git symbolic-ref --short HEAD)'
alias cp-pwd="pwd | xclip -selection clipboard"
alias x-cp="xclip -selection clipboard"
# alias diff="git diff"
alias lz="lazygit"
alias lzf="lazygit --screen-mode full"  # Full screen diff
alias cz="code \$(fzf)"
alias splan="spacectl stack local-preview"
alias sauth="spacectl profile login  --endpoint https://wellsky.app.us.spacelift.io"
alias jl="jira sprint  list --current -a$(jira me)"
# SSH aliases using pass for key management
alias sftp="sshfs -o IdentityFile=<(pass ssh/sftpgo_wsl) -p 2022 wsl@sftp.local:/ /mnt/sftpgo"
alias unmount="fusermount -u /mnt/sftpgo"
alias b="buku --deep -S"
# Custom scripts (from ~/bin via stow)
alias zn='zoxide_openfiles_nvim.sh'
alias zl='fzf_listoldfiles.sh'
alias tn='tmux_zoxide_nvim.sh'
git config --global user.name "AvneshJarabani-Wellsky"
git config --global user.email "anvesh.jarabani@wellsky.com"
ggg() {
  git_email=$(git config user.email)
  required_email="xzput@outlook.com"

  if [ "$git_email" != "$required_email" ]; then
    echo "Current git email is '$git_email'. Please switch to '$required_email' to use this function."
    return 1
  fi

  git add .

  if [ -z "$1" ]; then
    commit_message="updates"
  else
    commit_message="$1"
  fi

  git commit -m "$commit_message"
  git push -u origin "$(git symbolic-ref --short HEAD)"

  current_branch=$(git symbolic-ref --short HEAD)
  base_branch="main"  # Change to "master" if needed

  #hub pull-request -b "$base_branch" -h "$current_branch" -m "$commit_message"
  echo "pushed from -"
  gconfig
}
alias gitprune='git branch --list | egrep -v "(^\*|master|main)" | xargs git branch -D'
gmprune() {
  if git show-ref --verify --quiet refs/heads/main; then
    git checkout main
  else
    git checkout master
  fi
  git pull
  gitprune
}
# SSH server aliases using pass for SSH keys
alias nuc3="ssh -i <(pass ssh/nuc3) root@192.168.1.103"
alias nuc2="ssh -i <(pass ssh/nuc2) root@192.168.1.102"
alias nuc4="ssh -i <(pass ssh/nuc4) root@192.168.1.104"
alias px="ssh -i <(pass ssh/px) root@192.168.1.105"

alias ghcs="gh copilot suggest"
alias gsearch="gh search code --owner mediwareinc"
alias gbrowse="gh browse -R"
# wsl to windows apps 
alias oc="/mnt/c/Program\\ Files/OneCommander/OneCommander.exe"
alias ex="/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE"

git-merge() {
    if [ "$1" = "-" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)  # Use current branch if first argument is a placeholder '-'
        target_branch=${2:-main}  # Use second argument as target branch, default to 'main'
    elif [ -z "$1" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)  # Default to current branch if no arguments
        target_branch="main"  # Default target branch to 'main'
    else
        branch="$1"
        target_branch=${2:-main}  # Use second argument as target branch, default to 'main' if not provided
    fi

    git checkout "$target_branch" && git pull origin "$target_branch"
    git merge "$branch"
    
    # Check if merge resulted in conflicts
    if [ $? -ne 0 ]; then
        echo "Merge failed. Resolve conflicts and try again."
        return 1
    fi

    git push origin "$target_branch"

    # Delete merged branches locally and remotely
    git branch --merged | egrep -v "(^\*|$target_branch)" | xargs -I % sh -c '{ git branch -d %; git push origin --delete %; }'
}
rollback() {
  if [ -z "$1" ]; then
    echo "Usage: rollback <file-path>"
    return 1
  fi
  git checkout HEAD~1 -- "$1"
}
# Function to update all git repositories in a directory, excluding dot folders
update_repos() {
  local repos_dir="$HOME/WELLSKY_REPOS"  # Change this to your repos directory path
  
  echo "Updating repositories in $repos_dir"
  
  # Change to the repos directory
  cd "$repos_dir" || return
  
  # Find all directories, excluding those that start with a dot, and execute git pull
  find . -mindepth 1 -maxdepth 1 -type d -not -name ".*" -print -exec git -C {} pull \;
  
  # Return to the original directory
  cd - > /dev/null
}
# Function to change to the directory of the file path copied to the clipboard
function cd_active() {
  # Get the file path from the clipboard
  FILE_PATH=$(xclip -o -selection clipboard)

  # Extract the directory path using parameter expansion
  DIR_PATH=${FILE_PATH%/*}

  # Change to the directory
  cd "$DIR_PATH"
}
alias tf-sync="rsync -avr --delete --exclude '*.tfvars' --exclude '*.tfstate' --exclude 'terraform.tf' --exclude '.terraform/' --exclude 'backend.tf' --exclude '*.hcl' --exclude 'db_list.yaml' --include '_config/' --exclude '_*'"
#GCLOUD SHORTCUTS
list_passwords() {
  key_value=$1
  secrets=$(gcloud secrets list --filter="$key_value" --format="value(name)")

  # Loop through each secret and extract the password
  echo "$secrets" | while read -r secret; do
    secret_value=$(gcloud secrets versions access latest --secret="$secret")
    password=$(echo "$secret_value" | grep -oP '(?<=Password=).*')
    echo "$secret, $password"
  done
}
function wsl_nat() {
  powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-File \"C:\Users\AnveshJarabani\SCRIPTS\wsl_nat.ps1\"' -Verb RunAs"
}
export COLORTERM=truecolor
# echo "-ZSH TERMINAL-" | figlet -f'DOS Rebel.flf' -p -t -c| lolcat  
# Lazy load NVM for faster startup
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Key bindings
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^H' backward-kill-word 
bindkey -r '^P'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History search highlighting
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# Google Cloud SDK - lazy load
gcloud() {
    unset -f gcloud
    [ -f '/root/google-cloud-sdk/path.zsh.inc' ] && source '/root/google-cloud-sdk/path.zsh.inc'
    [ -f '/root/google-cloud-sdk/completion.zsh.inc' ] && source '/root/google-cloud-sdk/completion.zsh.inc'
    gcloud "$@"
}

tmux-git-autofetch() {(/root/.tmux/plugins/tmux-git-autofetch/git-autofetch.tmux --current &)}
# add-zsh-hook chpwd tmux-git-autofetch
# eval "$(oh-my-posh init zsh --config $HOME/PERSONAL/PRIVATE/CUSTOMIZATIONS/work.omp.yaml)"
# Yazi function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

sync_edge_bookmarks() {
  # EdgeChromium script path (if needed, move to dotfiles or keep here)
  local ps_script="$HOME/PERSONAL/PRIVATE/CUSTOMIZATIONS/EdgeChromium-Bookmarks-Backup-JSON-to-HTML.ps1"
  
  if [ -f "$ps_script" ]; then
    powershell.exe -ExecutionPolicy Bypass -File "$(wslpath -w "$ps_script")"
  else
    echo "EdgeChromium script not found"
    return 1
  fi

  # Move today's exported HTML file to your WSL path
  mv /mnt/c/Users/AnveshJarabani/Documents/EdgeChromium-Bookmarks.backup_$(date +%Y-%m-%d)_*.html \
     "$HOME/PERSONAL/PRIVATE/edgebookmarks.html"

  # Delete existing Buku database with auto-confirmation
  yes y| buku --nostdin -d

  # Import the new bookmarks with auto-tagging and no prompts
  yes y | buku --nostdin -i "$HOME/PERSONAL/PRIVATE/edgebookmarks.html" --tag "$(date +%Y%b%d)"
}
# Disable bracketed paste mode
# unset zle_bracketed_paste
export BIGQUERY_PROJECT="wsh-dev-analytics-wsky"

# GPG_TTY required for pass/gpg passphrase prompts to work
export GPG_TTY=$(tty)

