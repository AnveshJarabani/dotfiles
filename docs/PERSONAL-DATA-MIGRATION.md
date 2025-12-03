# 🔐 Storing Personal Data in Pass - Complete Migration Guide

This guide shows how to keep ALL personal information (emails, names, tokens) in `pass` instead of committing them to your public dotfiles repo.

## 📋 Table of Contents
- [Quick Start](#quick-start)
- [What to Store in Pass](#what-to-store-in-pass)
- [Migration Steps](#migration-steps)
- [Usage Examples](#usage-examples)
- [Automated Setup Script](#automated-setup-script)

---

## 🚀 Quick Start

### 1. Store Your Personal Data in Pass

```bash
# Git identities
pass insert git/personal/name      # AnveshJarabani
pass insert git/personal/email     # your-email@domain.com
pass insert git/personal/signing-key  # 12AB229CE64A58C5

pass insert git/work/name          # AnveshJarabani-Wellsky
pass insert git/work/email         # work-email@company.com
pass insert git/work/signing-key   # 2B9BE0A0C0632BBE

# GitHub tokens (if needed)
pass insert github/token

# Jira
pass insert work/jira-email        # work-email@company.com

# Windows username (for scripts)
pass insert windows/username       # YourWindowsUsername
```

### 2. Create Setup Script

Create `~/dotfiles/scripts/setup-personal-config.sh`:

```bash
#!/bin/bash
# Auto-configure personal settings from pass

echo "🔧 Setting up personal git configuration..."

# Git personal profile config files
mkdir -p ~/.config/git

cat > ~/.gitconfig-personal << EOF
[user]
    name = $(pass git/personal/name)
    email = $(pass git/personal/email)
    signingkey = $(pass git/personal/signing-key)

[commit]
    gpgsign = true
EOF

cat > ~/.gitconfig-work << EOF
[user]
    name = $(pass git/work/name)
    email = $(pass git/work/email)
    signingkey = $(pass git/work/signing-key)

[commit]
    gpgsign = true
EOF

echo "✅ Git config files created!"
echo "ℹ️  Main .gitconfig will use includeIf to load these"
```

Make it executable:
```bash
chmod +x ~/dotfiles/scripts/setup-personal-config.sh
```

---

## 📦 What to Store in Pass

### Git Identity
```
pass/
├── git/
│   ├── personal/
│   │   ├── name
│   │   ├── email
│   │   └── signing-key
│   └── work/
│       ├── name
│       ├── email
│       └── signing-key
```

### GitHub/GitLab Tokens
```
pass/
├── github/
│   ├── token
│   └── username
```

### Jira/Atlassian
```
pass/
└── work/
    ├── jira-email
    └── jira-api-token
```

### System-Specific
```
pass/
└── windows/
    └── username
```

---

## 🔄 Migration Steps

### Step 1: Identify Sensitive Data

Run this scanner:

```bash
cd ~/dotfiles

# Find emails
grep -r "@" --exclude-dir=.git --exclude-dir=docs \
  | grep -v "example.com" \
  | grep -v "user@" \
  | grep -v "mailto"

# Find potential usernames
grep -r "AnveshJarabani" --exclude-dir=.git --exclude-dir=docs

# Find GitHub usernames
grep -r "github.com/" --exclude-dir=.git | grep -v "https://github.com/trending"
```

### Step 2: Store in Pass

```bash
# Example: Store personal email
echo "xzput@outlook.com" | pass insert -e git/personal/email

# Example: Store name
echo "AnveshJarabani" | pass insert -e git/personal/name

# Example: Store GPG key
echo "12AB229CE64A58C5" | pass insert -e git/personal/signing-key
```

### Step 3: Update Config Files

#### For Git Config

**Before:**
```gitconfig
[user]
    name = AnveshJarabani
    email = xzput@outlook.com
    signingkey = 12AB229CE64A58C5
```

**After:**
```gitconfig
# Default git config - actual values loaded from pass
# Run: ~/dotfiles/scripts/setup-personal-config.sh

[user]
    # Values will be set by git-profile script from pass
    name = PLACEHOLDER
    email = PLACEHOLDER
    signingkey = PLACEHOLDER

[includeIf "gitdir:~/PERSONAL/"]
    path = ~/.gitconfig-personal

[includeIf "gitdir:~/WELLSKY_REPOS/"]
    path = ~/.gitconfig-work
```

#### For Scripts (git-profile)

**Before:**
```bash
git config --global user.email "xzput@outlook.com"
```

**After:**
```bash
git config --global user.email "$(pass git/personal/email)"
```

#### For Jira Config

**Before:**
```yaml
login: anvesh.jarabani@wellsky.com
```

**After:**
```yaml
# Login email stored in pass: work/jira-email
# Get with: pass work/jira-email
login: PLACEHOLDER_EMAIL
```

Then create `~/.jira-setup.sh`:
```bash
#!/bin/bash
JIRA_EMAIL=$(pass work/jira-email)
sed -i "s/PLACEHOLDER_EMAIL/$JIRA_EMAIL/" ~/.jira/.config.yml
```

---

## 💡 Usage Examples

### Dynamic Git Profile Switching

Update `scripts/bin/git-profile`:

```bash
#!/bin/bash
# Switch between personal and work git profiles

case "$1" in
    personal|p)
        git config --global user.name "$(pass git/personal/name)"
        git config --global user.email "$(pass git/personal/email)"
        git config --global user.signingkey "$(pass git/personal/signing-key)"
        echo "✓ Switched to PERSONAL profile"
        ;;
    
    work|w)
        git config --global user.name "$(pass git/work/name)"
        git config --global user.email "$(pass git/work/email)"
        git config --global user.signingkey "$(pass git/work/signing-key)"
        echo "✓ Switched to WORK profile"
        ;;
esac
```

### Replace Hardcoded Paths

**For Windows Username in Scripts:**

Before:
```bash
/mnt/c/Users/AnveshJarabani/Documents/...
```

After:
```bash
WIN_USER=$(pass windows/username)
/mnt/c/Users/$WIN_USER/Documents/...
```

### Environment Variables

Create `~/.env.personal` (git-ignored):
```bash
#!/bin/bash
# Auto-generated from pass - DO NOT COMMIT

export GIT_AUTHOR_NAME="$(pass git/personal/name)"
export GIT_AUTHOR_EMAIL="$(pass git/personal/email)"
export GITHUB_TOKEN="$(pass github/token)"
export JIRA_EMAIL="$(pass work/jira-email)"
```

Generate it with:
```bash
cat > ~/.env.personal << 'EOF'
export GIT_AUTHOR_NAME="$(pass git/personal/name)"
export GIT_AUTHOR_EMAIL="$(pass git/personal/email)"
export GITHUB_TOKEN="$(pass github/token)"
export JIRA_EMAIL="$(pass work/jira-email)"
EOF
```

Then in your `.zshrc`:
```bash
[ -f ~/.env.personal ] && source ~/.env.personal
```

---

## 🤖 Automated Setup Script

Create `scripts/setup-from-pass.sh`:

```bash
#!/bin/bash
# Setup all personal configs from pass

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
for secret in "${REQUIRED_SECRETS[@]}"; do
    if ! pass "$secret" &> /dev/null; then
        echo "❌ Missing secret: $secret"
        echo "   Add it with: pass insert $secret"
        exit 1
    fi
done

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
    JIRA_EMAIL=$(pass work/jira-email)
    sed -i "s/login:.*/login: $JIRA_EMAIL/" ~/.jira/.config.yml
fi

echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "   - Add ~/.gitconfig-personal to .gitignore"
echo "   - Add ~/.gitconfig-work to .gitignore"
echo "   - Add ~/.env.personal to .gitignore"
echo "   - Run: git-profile personal  (or work)"
```

---

## 📝 .gitignore Updates

Add to `~/.gitignore_global`:

```gitignore
# Personal config files generated from pass
.gitconfig-personal
.gitconfig-work
.env.personal
.jira-personal.yml

# Backup files with potential personal data
*.backup
*_backup
```

And to your dotfiles repo `.gitignore`:

```gitignore
# Personal data files
**/*personal*
**/*private*
scripts/setup-personal-config.sh.secret

# Config files that contain personal data after setup
git/.gitconfig-personal
git/.gitconfig-work
```

---

## 🔄 First-Time Setup on New Machine

1. Clone dotfiles:
   ```bash
   git clone git@github.com:YourUsername/dotfiles.git ~/dotfiles
   ```

2. Clone password store:
   ```bash
   git clone git@github.com:YourUsername/password-store.git ~/.password-store
   ```

3. Import GPG keys:
   ```bash
   gpg --import /path/to/your-gpg-backup.asc
   ```

4. Run setup:
   ```bash
   ~/dotfiles/scripts/setup-from-pass.sh
   ```

5. Switch to personal profile:
   ```bash
   git-profile personal
   ```

---

## 📚 Files to Update

### Scripts to Update

1. **scripts/bin/git-profile** - ✅ Use pass for all credentials
2. **scripts/bin/ggg** - ✅ Use pass for email check
3. **scripts/bin/sync_edge_bookmarks** - Replace hardcoded username
4. **scripts/bin/wsl_nat** - Replace hardcoded username

### Config Files to Update

1. **git/.gitconfig** - Use includeIf with generated files
2. **jira/.config/.jira/.config.yml** - Use placeholder, generate on setup
3. **gh/.config/gh/hosts.yml** - Store tokens in pass (already git-ignored)

### Documentation to Update

1. **docs/*** - Use generic examples instead of real emails
2. **README.md** - Replace personal GitHub username with variable

---

## ✅ Verification Checklist

After migration, verify no personal data remains:

```bash
cd ~/dotfiles

# Check for emails (should only find examples/docs)
grep -r "@" --exclude-dir=.git --exclude="*.md" \
  | grep -v "example.com" \
  | grep -v "PLACEHOLDER"

# Check for your name
grep -r "AnveshJarabani" --exclude-dir=.git --exclude="*.md"

# Check for tokens (should find none)
grep -r "ghp_\|gho_\|ATATT" --exclude-dir=.git

# Check for private keys (should find none)
grep -r "BEGIN.*PRIVATE KEY" --exclude-dir=.git
```

All results should be either:
- Documentation/examples
- Placeholders
- Comments explaining where to get real values

---

## 🎯 Summary

| Data Type | Storage Location | Access Method |
|-----------|------------------|---------------|
| Git Name/Email | `pass git/*/name,email` | `$(pass git/personal/email)` |
| GPG Keys | `pass git/*/signing-key` | `$(pass git/personal/signing-key)` |
| GitHub Token | `pass github/token` | `$(pass github/token)` |
| Jira Email | `pass work/jira-email` | `$(pass work/jira-email)` |
| API Tokens | `pass work/*-token` | `$(pass work/jira-api-token)` |
| SSH Keys | `~/.ssh/*` (git-ignored) | Already excluded |

**Benefits:**
- ✅ Dotfiles repo can be 100% public
- ✅ No accidental credential leaks
- ✅ Easy to rotate credentials
- ✅ Works across machines with password-store sync
- ✅ Single source of truth for all credentials

---

**🔐 Your dotfiles are now safe to share publicly! 🔐**
