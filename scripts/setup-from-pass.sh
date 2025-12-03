#!/bin/bash
# Setup all personal configs from pass
# Run this after cloning dotfiles on a new machine

set -e

echo "🔐 Setting up dotfiles with data from pass..."

# Check if pass is available
if ! command -v pass &> /dev/null; then
    echo "❌ pass not found. Please install it first."
    exit 1
fi

# Verify required secrets exist
REQUIRED_SECRETS=(
    "git/personal/name"
    "git/personal/email"
    "git/personal/signing-key"
    "git/work/name"
    "git/work/email"
    "git/work/signing-key"
)

echo "📋 Checking required secrets..."
MISSING=0
for secret in "${REQUIRED_SECRETS[@]}"; do
    if ! pass "$secret" &> /dev/null; then
        echo "❌ Missing secret: $secret"
        echo "   Add it with: pass insert $secret"
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    echo ""
    echo "Please add missing secrets first:"
    echo "  pass insert git/personal/name"
    echo "  pass insert git/personal/email"
    echo "  pass insert git/personal/signing-key"
    exit 1
fi

echo "✅ All required secrets found!"

# Generate git config files
echo "⚙️  Generating git config files..."

cat > ~/.gitconfig-personal << EOF
# Auto-generated from pass - DO NOT COMMIT
[user]
    name = $(pass git/personal/name)
    email = $(pass git/personal/email)
    signingkey = $(pass git/personal/signing-key)

[commit]
    gpgsign = true
EOF

cat > ~/.gitconfig-work << EOF
# Auto-generated from pass - DO NOT COMMIT
[user]
    name = $(pass git/work/name)
    email = $(pass git/work/email)
    signingkey = $(pass git/work/signing-key)

[commit]
    gpgsign = true
EOF

# Update Jira config if it exists
if [ -f ~/.jira/.config.yml ]; then
    echo "⚙️  Updating Jira config..."
    if pass work/jira-email &> /dev/null; then
        JIRA_EMAIL=$(pass work/jira-email)
        sed -i "s/login:.*/login: $JIRA_EMAIL/" ~/.jira/.config.yml
        echo "✅ Jira config updated"
    fi
fi

# Generate env file for personal variables
echo "⚙️  Generating ~/.env.personal..."

cat > ~/.env.personal << 'EOF'
# Auto-generated from pass - DO NOT COMMIT
export GIT_AUTHOR_NAME="$(pass git/personal/name)"
export GIT_AUTHOR_EMAIL="$(pass git/personal/email)"
EOF

# Add GitHub token if it exists
if pass github/token &> /dev/null; then
    echo 'export GITHUB_TOKEN="$(pass github/token)"' >> ~/.env.personal
fi

# Add Jira email if it exists
if pass work/jira-email &> /dev/null; then
    echo 'export JIRA_EMAIL="$(pass work/jira-email)"' >> ~/.env.personal
fi

echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "   1. Run: git-profile personal  (or work)"
echo "   2. Verify: git config --global user.email"
echo "   3. Source env: source ~/.env.personal"
echo ""
echo "🔧 Files created:"
echo "   - ~/.gitconfig-personal"
echo "   - ~/.gitconfig-work"
echo "   - ~/.env.personal"
echo ""
echo "⚠️  These files are git-ignored and should never be committed!"
