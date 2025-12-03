# 🚀 Quick Start: Git Config from Pass

> **TL;DR:** Complete guide to populate git configs from pass on any machine

## ⚡ Super Quick Setup (New Machine)

```bash
# 1. Clone both repos
git clone git@github.com:AnveshJarabani/dotfiles.git ~/dotfiles
git clone git@github.com:AnveshJarabani/password-store.git ~/.password-store

# 2. Import GPG key (if needed)
gpg --import /path/to/your-gpg-backup.asc

# 3. Run ONE command - does everything!
~/dotfiles/scripts/setup-from-pass.sh

# 4. Done! Git config is populated automatically by directory
cd ~/PERSONAL/myproject     # Uses personal email
cd ~/WELLSKY_REPOS/work     # Uses work email
```

## 📚 Full Documentation Available

All details are in these markdown files:

### 1. **HOW-PASS-LOADS-GIT-CONFIG.md** ← START HERE
   - ✅ Complete workflow diagram
   - ✅ Two methods explained (auto + manual)
   - ✅ Step-by-step examples
   - ✅ What `setup-from-pass.sh` does internally
   - ✅ How `includeIf` works
   - ✅ Verification commands

### 2. **PERSONAL-DATA-MIGRATION.md** ← Complete Guide
   - ✅ How to store secrets in pass
   - ✅ What to store (git, github, jira, etc.)
   - ✅ Migration from hardcoded values
   - ✅ Script examples
   - ✅ First-time setup instructions
   - ✅ Security checklist

### 3. **MIGRATION-COMPLETE.md** ← What We Did
   - ✅ Summary of all changes
   - ✅ Files updated
   - ✅ Security status

## 🔑 Key Files

### In Your Dotfiles Repo (PUBLIC - safe to commit)
```
dotfiles/
├── git/.gitconfig              # PLACEHOLDER values + includeIf
├── scripts/
│   ├── bin/git-profile         # Manual profile switcher
│   └── setup-from-pass.sh      # Auto-setup script
└── docs/
    ├── HOW-PASS-LOADS-GIT-CONFIG.md
    └── PERSONAL-DATA-MIGRATION.md
```

### In Your Password Store (ENCRYPTED)
```
~/.password-store/
└── git/
    ├── personal/
    │   ├── name.gpg
    │   ├── email.gpg
    │   └── signing-key.gpg
    └── work/
        ├── name.gpg
        ├── email.gpg
        └── signing-key.gpg
```

### Generated in HOME (GIT-IGNORED)
```
~/
├── .gitconfig-personal     # Auto-created by setup-from-pass.sh
├── .gitconfig-work         # Auto-created by setup-from-pass.sh
└── .env.personal           # Optional env vars from pass
```

## 🎯 How It Works (Summary)

1. **Pass** stores encrypted secrets (emails, keys)
2. **setup-from-pass.sh** reads from pass, creates `~/.gitconfig-personal` and `~/.gitconfig-work`
3. **git/.gitconfig** uses `includeIf` to auto-load the right config by directory
4. **git-profile** command lets you manually switch anytime

## 📖 Complete Workflow Documented

### First-Time Setup (Documented in PERSONAL-DATA-MIGRATION.md)
```bash
# Store secrets in pass (one-time)
pass insert git/personal/name
pass insert git/personal/email
pass insert git/personal/signing-key

# Run on each new machine
~/dotfiles/scripts/setup-from-pass.sh
```

### Daily Usage (Documented in HOW-PASS-LOADS-GIT-CONFIG.md)
```bash
# Option 1: Automatic (recommended)
cd ~/PERSONAL/myproject
git commit -m "update"  # Uses personal email automatically

cd ~/WELLSKY_REPOS/work-project
git commit -m "update"  # Uses work email automatically

# Option 2: Manual switch
git-profile personal    # Switch globally to personal
git-profile work        # Switch globally to work
```

### Verification (Documented in both guides)
```bash
# See what git is using
git config user.email
git config user.name

# See where it's coming from
git config --show-origin user.email

# Regenerate if needed
~/dotfiles/scripts/setup-from-pass.sh
```

## ✅ Everything You Need is Documented

| Question | Answer In |
|----------|-----------|
| How does pass load into git? | HOW-PASS-LOADS-GIT-CONFIG.md |
| How to store secrets? | PERSONAL-DATA-MIGRATION.md (lines 15-35) |
| First-time machine setup? | Both docs (complete steps) |
| How to switch profiles? | HOW-PASS-LOADS-GIT-CONFIG.md (lines 126-132) |
| What does setup script do? | HOW-PASS-LOADS-GIT-CONFIG.md (lines 102-112) |
| How includeIf works? | HOW-PASS-LOADS-GIT-CONFIG.md (lines 66-84) |
| Security checklist? | PERSONAL-DATA-MIGRATION.md (lines 454-470) |
| What was changed? | MIGRATION-COMPLETE.md |

## 🎬 Quick Reference Commands

```bash
# View secrets in pass
pass git/personal/email
pass git/work/email

# Populate git configs from pass
~/dotfiles/scripts/setup-from-pass.sh

# Switch profiles
git-profile personal
git-profile work
git-profile show

# Check current config
git config user.email
```

---

**✅ Yes! All details are fully documented in the markdown files.**

Read `HOW-PASS-LOADS-GIT-CONFIG.md` for the complete workflow with diagrams and examples!
