#!/bin/bash
# Package Installation Script for New System Setup
# Installs packages from generated lists (packages-*.txt)
# Run ./generate-packages.sh on current system to update lists

set -e

DOTFILES_DIR="$(dirname "$0")"

# ==============================================================================
# APT Packages
# ==============================================================================
if [ -f "$DOTFILES_DIR/packages-apt.txt" ]; then
    echo "📦 Installing APT packages from packages-apt.txt..."
    sudo apt update
    
    # Filter out packages that don't exist and install the rest
    while IFS= read -r package; do
        if apt-cache show "$package" &> /dev/null; then
            sudo apt install -y "$package" 2>/dev/null || echo "  ⚠️  Skipped: $package"
        else
            echo "  ⚠️  Package not found: $package"
        fi
    done < "$DOTFILES_DIR/packages-apt.txt"
    
    echo "  ✅ APT packages installed"
else
    echo "⚠️  packages-apt.txt not found, skipping APT packages"
fi

# ==============================================================================
# NPM Global Packages
# ==============================================================================
if [ -f "$DOTFILES_DIR/packages-npm.txt" ] && [ -s "$DOTFILES_DIR/packages-npm.txt" ]; then
    echo "📦 Installing NPM packages from packages-npm.txt..."
    
    while IFS= read -r package; do
        npm install -g "$package" 2>/dev/null || echo "  ⚠️  Skipped: $package"
    done < "$DOTFILES_DIR/packages-npm.txt"
    
    echo "  ✅ NPM packages installed"
else
    echo "⚠️  packages-npm.txt not found or empty, skipping NPM packages"
fi

# ==============================================================================
# Python Packages
# ==============================================================================
if [ -f "$DOTFILES_DIR/packages-pip.txt" ] && [ -s "$DOTFILES_DIR/packages-pip.txt" ]; then
    echo "🐍 Installing Python packages from packages-pip.txt..."
    
    while IFS= read -r package; do
        pip3 install --user "$package" 2>/dev/null || echo "  ⚠️  Skipped: $package"
    done < "$DOTFILES_DIR/packages-pip.txt"
    
    echo "  ✅ Python packages installed"
else
    echo "⚠️  packages-pip.txt not found or empty, skipping Python packages"
fi

# ==============================================================================
# Cargo Packages (Rust)
# ==============================================================================
if [ -f "$DOTFILES_DIR/packages-cargo.txt" ] && [ -s "$DOTFILES_DIR/packages-cargo.txt" ]; then
    if command -v cargo &> /dev/null; then
        echo "🦀 Installing Rust packages from packages-cargo.txt..."
        
        while IFS= read -r package; do
            cargo install "$package" 2>/dev/null || echo "  ⚠️  Skipped: $package"
        done < "$DOTFILES_DIR/packages-cargo.txt"
        
        echo "  ✅ Rust packages installed"
    else
        echo "⚠️  Cargo not installed, skipping Rust packages"
    fi
else
    echo "⚠️  packages-cargo.txt not found or empty, skipping Rust packages"
fi

# ==============================================================================
# Special Installations (not in package lists)
# ==============================================================================
echo ""
echo "🔧 Installing special packages..."

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🎨 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Powerlevel10k theme
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "🎨 Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

echo ""
echo "✅ Package installation complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Run: ./install.sh (to stow dotfiles)"
echo "  2. Change shell: chsh -s \$(which zsh)"
echo "  3. Restart terminal"
echo "  4. Setup pass: git clone git@github-p:AnveshJarabani/pass.git ~/.password-store"
echo ""

echo ""
echo "✅ Package installation complete!"
echo ""
echo "📋 Summary:"
echo "  - APT packages: $(wc -l < packages-apt.txt 2>/dev/null || echo 0)"
echo "  - NPM packages: $(wc -l < packages-npm.txt 2>/dev/null || echo 0)"
echo "  - Python packages: $(wc -l < packages-pip.txt 2>/dev/null || echo 0)"
echo "  - Rust packages: $(wc -l < packages-cargo.txt 2>/dev/null || echo 0)"
echo ""
echo "📋 Next steps:"
echo "  1. Run: ./install.sh (to stow dotfiles)"
echo "  2. Change shell: chsh -s \$(which zsh)"
echo "  3. Restart terminal"
echo "  4. Setup pass: git clone git@github-p:AnveshJarabani/pass.git ~/.password-store"
echo ""
echo "�� To update package lists on this system:"
echo "   ./generate-packages.sh"
echo ""
