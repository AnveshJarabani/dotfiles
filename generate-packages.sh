#!/bin/bash
# Generate packages list from current system
# Run this whenever you install new packages to update the list

OUTPUT_DIR="$(dirname "$0")"
echo "📸 Generating package lists from current system..."

# ==============================================================================
# APT Packages (manually installed)
# ==============================================================================
echo "📦 Exporting APT packages..."
apt-mark showmanual | sort > "$OUTPUT_DIR/packages-apt.txt"
echo "   Saved $(wc -l < "$OUTPUT_DIR/packages-apt.txt") packages to packages-apt.txt"

# ==============================================================================
# NPM Global Packages
# ==============================================================================
echo "📦 Exporting NPM global packages..."
npm list -g --depth=0 --json 2>/dev/null | jq -r '.dependencies | keys[]' | grep -v "^npm$" | sort > "$OUTPUT_DIR/packages-npm.txt" 2>/dev/null || echo "" > "$OUTPUT_DIR/packages-npm.txt"
echo "   Saved $(wc -l < "$OUTPUT_DIR/packages-npm.txt") packages to packages-npm.txt"

# ==============================================================================
# Python pip packages (user-installed)
# ==============================================================================
echo "🐍 Exporting Python packages..."
pip3 list --user --format=freeze 2>/dev/null | cut -d= -f1 | sort > "$OUTPUT_DIR/packages-pip.txt" || echo "" > "$OUTPUT_DIR/packages-pip.txt"
echo "   Saved $(wc -l < "$OUTPUT_DIR/packages-pip.txt") packages to packages-pip.txt"

# ==============================================================================
# Cargo packages (Rust)
# ==============================================================================
if command -v cargo &> /dev/null; then
    echo "🦀 Exporting Rust packages..."
    cargo install --list | grep -E '^\S+' | awk '{print $1}' | sort > "$OUTPUT_DIR/packages-cargo.txt"
    echo "   Saved $(wc -l < "$OUTPUT_DIR/packages-cargo.txt") packages to packages-cargo.txt"
fi

# ==============================================================================
# Go packages
# ==============================================================================
if [ -d "$HOME/go/bin" ]; then
    echo "🐹 Exporting Go binaries..."
    ls -1 "$HOME/go/bin" | sort > "$OUTPUT_DIR/packages-go.txt"
    echo "   Saved $(wc -l < "$OUTPUT_DIR/packages-go.txt") packages to packages-go.txt"
fi

echo ""
echo "✅ Package lists generated!"
echo ""
echo "📋 Files created:"
ls -lh "$OUTPUT_DIR"/packages-*.txt 2>/dev/null
echo ""
echo "💡 Tip: Commit these files to track your packages over time"
echo "   git add packages-*.txt"
echo "   git commit -m '📦 Update package lists'"
