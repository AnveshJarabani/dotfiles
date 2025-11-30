#!/bin/bash
# Dotfiles Installation Script using GNU Stow
# Usage: ./install.sh [package_name...]
# Example: ./install.sh        # Install all packages
#          ./install.sh zsh nvim tmux  # Install specific packages

set -e

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# All available packages
ALL_PACKAGES=(
    "aicommit"
    "btop"
    "colors"
    "fluent-search"
    "git"
    "gitignore"
    "lazydocker"
    "neofetch"
    "nvim"
    "ohmyposh"
    "onecommander"
    "p10k"
    "ranger"
    "scripts"
    "starship"
    "tmux"
    "wezterm"
    "windows-apps"
    "yazi"
    "zsh"
)

echo -e "${BLUE}=== Dotfiles Installation Script ===${NC}\n"

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed${NC}"
    echo -e "${YELLOW}Install with: sudo apt install stow${NC}"
    exit 1
fi

# Change to dotfiles directory
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Dotfiles directory not found at $DOTFILES_DIR${NC}"
    exit 1
fi

cd "$DOTFILES_DIR" || exit 1
echo -e "${GREEN}Working in: $DOTFILES_DIR${NC}\n"

# Determine which packages to install
if [ $# -eq 0 ]; then
    # No arguments - install all packages
    PACKAGES=("${ALL_PACKAGES[@]}")
    echo -e "${BLUE}Installing all packages...${NC}\n"
else
    # Specific packages requested
    PACKAGES=("$@")
    echo -e "${BLUE}Installing specific packages: ${PACKAGES[*]}${NC}\n"
fi

# Backup existing configs if they exist and are not symlinks
backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}  Backing up existing: $target${NC}"
        mkdir -p "$BACKUP_DIR"
        cp -r "$target" "$BACKUP_DIR/"
        rm -rf "$target"
    fi
}

# Install each package
for package in "${PACKAGES[@]}"; do
    if [ ! -d "$package" ]; then
        echo -e "${YELLOW}⚠ Skipping $package (directory not found)${NC}"
        continue
    fi

    echo -e "${GREEN}📦 Installing: $package${NC}"
    
    # Optional: Add specific backup logic for known configs
    case "$package" in
        nvim)
            backup_if_exists "$HOME/.config/nvim"
            ;;
        tmux)
            backup_if_exists "$HOME/.tmux.conf"
            backup_if_exists "$HOME/.tmux"
            ;;
        zsh)
            backup_if_exists "$HOME/.zshrc"
            backup_if_exists "$HOME/.zshenv"
            ;;
        git)
            backup_if_exists "$HOME/.gitconfig"
            ;;
    esac
    
    # Run stow
    if stow -v "$package" 2>&1 | grep -q "CONFLICT"; then
        echo -e "${RED}  ✗ Conflict detected for $package${NC}"
        echo -e "${YELLOW}  Run: cd $DOTFILES_DIR && stow -n $package (to see conflicts)${NC}"
    else
        stow "$package"
        echo -e "${GREEN}  ✓ $package installed${NC}"
    fi
    echo
done

# Show backup location if anything was backed up
if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Backup created at: $BACKUP_DIR${NC}"
fi

echo -e "\n${GREEN}=== Installation Complete! ===${NC}\n"
echo -e "${BLUE}Useful commands:${NC}"
echo -e "  ${YELLOW}stow -D <package>${NC}   - Remove package symlinks"
echo -e "  ${YELLOW}stow -R <package>${NC}   - Restow package (remove and recreate)"
echo -e "  ${YELLOW}stow -n <package>${NC}   - Dry run (see what would happen)"
echo
