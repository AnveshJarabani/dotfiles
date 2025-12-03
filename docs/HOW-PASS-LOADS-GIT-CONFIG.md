# 🔐 How Pass Data Loads into Git Config

## Two Methods for Loading Data from Pass

### Method 1: Dynamic Script Loading (Manual Switch)

**Using `git-profile` command:**

```bash
# When you run this:
git-profile personal

# It executes:
git config --global user.name "$(pass git/personal/name)"
git config --global user.email "$(pass git/personal/email)"
git config --global user.signingkey "$(pass git/personal/signing-key)"

# What happens:
# 1. `pass git/personal/email` decrypts and outputs: xzput@outlook.com
# 2. $(...) captures that output
# 3. git config --global sets it in ~/.gitconfig
```

**Result in `~/.gitconfig`:**
```gitconfig
[user]
    name = AnveshJarabani
    email = xzput@outlook.com
    signingkey = 12AB229CE64A58C5
```

### Method 2: Auto-Setup with Generated Files (Automatic by Directory)

**Using `setup-from-pass.sh`:**

```bash
# When you run:
~/dotfiles/scripts/setup-from-pass.sh

# It creates TWO files in your home directory:
```

**File 1: `~/.gitconfig-personal`** (auto-generated, git-ignored)
```gitconfig
# Auto-generated from pass - DO NOT COMMIT
[user]
    name = AnveshJarabani
    email = xzput@outlook.com
    signingkey = 12AB229CE64A58C5

[commit]
    gpgsign = true
```

**File 2: `~/.gitconfig-work`** (auto-generated, git-ignored)
```gitconfig
# Auto-generated from pass - DO NOT COMMIT
[user]
    name = AnveshJarabani
    email = anvesh.jarabani@wellsky.com
    signingkey = 2B9BE0A0C0632BBE

[commit]
    gpgsign = true
```

**Your dotfiles `git/.gitconfig` includes them conditionally:**
```gitconfig
# This file IS committed to your dotfiles repo
[user]
    name = PLACEHOLDER
    email = PLACEHOLDER
    signingkey = PLACEHOLDER

# Auto-load personal config when in personal repos
[includeIf "gitdir:~/PERSONAL/"]
    path = ~/.gitconfig-personal

[includeIf "gitdir:~/dotfiles/"]
    path = ~/.gitconfig-personal

# Auto-load work config when in work repos
[includeIf "gitdir:~/WELLSKY_REPOS/"]
    path = ~/.gitconfig-work
```

## 📊 How It Works Step-by-Step

### First Time Setup (One Time per Machine)

```bash
# 1. Clone your dotfiles
git clone git@github.com:AnveshJarabani/dotfiles.git ~/dotfiles

# 2. Clone your password store
git clone git@github.com:AnveshJarabani/password-store.git ~/.password-store

# 3. Run setup script (reads from pass, writes to ~/.gitconfig-*)
~/dotfiles/scripts/setup-from-pass.sh
```

**What `setup-from-pass.sh` does:**
```bash
# Reads from encrypted pass:
pass git/personal/email   # Outputs: xzput@outlook.com

# Writes to ~/.gitconfig-personal:
cat > ~/.gitconfig-personal << EOF
[user]
    email = xzput@outlook.com
EOF
```

### Daily Usage (Automatic)

**Option A: Automatic by Directory (Recommended)**
```bash
cd ~/PERSONAL/my-project
git config user.email
# Output: xzput@outlook.com (from ~/.gitconfig-personal)

cd ~/WELLSKY_REPOS/work-project
git config user.email
# Output: anvesh.jarabani@wellsky.com (from ~/.gitconfig-work)
```

**Option B: Manual Switch (When needed)**
```bash
# Switch to personal profile globally
git-profile personal

# Switch to work profile globally
git-profile work
```

## 🔄 Workflow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│  Encrypted Password Store (~/.password-store/)              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ git/personal/email.gpg → "xzput@outlook.com"         │   │
│  │ git/personal/name.gpg → "AnveshJarabani"             │   │
│  │ git/work/email.gpg → "anvesh.jarabani@wellsky.com"   │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                             ↓
                   (setup-from-pass.sh runs)
                   pass git/personal/email
                             ↓
┌─────────────────────────────────────────────────────────────┐
│  Generated Config Files (HOME directory - git-ignored)      │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ ~/.gitconfig-personal (has real email)               │   │
│  │ ~/.gitconfig-work (has real work email)              │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                             ↓
                   (git includeIf loads them)
                             ↓
┌─────────────────────────────────────────────────────────────┐
│  Your Dotfiles Repo (PUBLIC - safe to share)               │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ git/.gitconfig (has PLACEHOLDER only)                │   │
│  │   [includeIf "gitdir:~/PERSONAL/"]                   │   │
│  │       path = ~/.gitconfig-personal                   │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## 🎯 Why This Works

1. **Your dotfiles repo** contains ONLY the includeIf logic (PLACEHOLDER values)
2. **Your home directory** has the real generated files (git-ignored globally)
3. **Git includeIf** automatically loads the right config based on directory
4. **Pass** stores the encrypted source data
5. **Setup script** is the bridge that generates configs from pass

## ✅ Security Features

- ✅ Dotfiles repo: NO sensitive data (just PLACEHOLDER)
- ✅ Password store: Encrypted with GPG
- ✅ Generated files: Never committed (in .gitignore)
- ✅ Works across machines: Just run setup-from-pass.sh

## 📝 Quick Reference

```bash
# See current git config
git config --global user.email

# Switch profiles manually
git-profile personal
git-profile work

# Regenerate config files from pass
~/dotfiles/scripts/setup-from-pass.sh

# View what's in pass
pass git/personal/email
pass git/work/email
```

## 🔍 Check What's Loaded

```bash
# In any repo, see what git sees
git config user.email
git config user.name
git config user.signingkey

# See where it's coming from
git config --show-origin user.email
# Output: file:/home/user/.gitconfig-personal	xzput@outlook.com
```

---

**Key Takeaway:** Your dotfiles repo is PUBLIC-safe because it only has PLACEHOLDER values and includeIf logic. The real data lives in pass-generated files in your home directory that are never committed!
