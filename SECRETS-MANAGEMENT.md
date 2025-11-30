# 🔐 Secrets Management Guide

> **⚠️ CRITICAL:** Never commit plain-text secrets to git! This guide shows you how to properly handle API keys, passwords, and tokens in your dotfiles.

---

## 🚨 Secrets Found in This Repo

During security audit, the following sensitive data was discovered:

### ❌ **DO NOT COMMIT THESE:**

1. **JIRA API Token** in `zsh/.zshrc` (line 36)
   - `JIRA_API_TOKEN='ATATT3xFfGF...'`
   
2. **SQL Password** in `fluent-search/.config/fluent-search/Clipboard.json`
   - Database connection string with password
   
3. **Mount passwords** in `zsh/.zshrc` (lines 39-40)
   - CIFS mount credentials in comments

---

## ✅ Recommended Solution: pass (Password Store)

### Why pass?
- ✅ **Secure:** Uses GPG encryption
- ✅ **Simple:** Standard Unix password manager
- ✅ **Git-friendly:** Can sync encrypted passwords
- ✅ **Shell integration:** Easy to use in scripts
- ✅ **Cross-platform:** Works on Linux, macOS, Windows (WSL)

---

## 🚀 Setup Instructions

### 1. Install pass

```bash
# Already installed!
sudo apt install pass
```

### 2. Generate GPG Key (if you don't have one)

```bash
# Check if you have a key
gpg --list-keys

# If no key, generate one
gpg --full-generate-key
# Choose: (1) RSA and RSA
# Key size: 4096
# Expiration: 0 (doesn't expire)
# Enter your name and email
# Set a strong passphrase!
```

### 3. Initialize pass

```bash
# Get your GPG key ID
gpg --list-keys
# Look for something like: 1234ABCD5678EFGH

# Initialize pass with your GPG key ID
pass init <your-gpg-key-id>

# Optional: Initialize git repo for pass
pass git init
```

### 4. Store Your Secrets

```bash
# Store JIRA token
pass insert work/jira-api-token
# Enter: ATATT3xFfGF...<REDACTED>

# Store DB password
pass insert db/noe-tracker-password
# Enter: <REDACTED>

# Store mount password
pass insert mount/nuc3-cifs
# Enter: <REDACTED>

# Store other secrets
pass insert api/openai
pass insert api/github
pass insert api/currency
```

### 5. Update Your .zshrc

Replace hardcoded secrets with pass commands:

```bash
# OLD (INSECURE):
export JIRA_API_TOKEN='ATATT3xFfGF...'

# NEW (SECURE):
export JIRA_API_TOKEN=$(pass work/jira-api-token)

# Mount example:
# OLD:
# mount -t cifs //nuc3.local/wd2tb1/DOCUMENTS ~/DOCS_WD2TB1 -o username=aj,password=<REDACTED>

# NEW:
mount -t cifs //nuc3.local/wd2tb1/DOCUMENTS ~/DOCS_WD2TB1 -o username=aj,password=$(pass mount/nuc3-cifs)
```

---

## 📚 Common pass Commands

```bash
# List all passwords
pass

# Show a password
pass work/jira-api-token

# Copy to clipboard (doesn't show on screen)
pass -c work/jira-api-token

# Generate a random password
pass generate api/new-service 32

# Edit a password
pass edit work/jira-api-token

# Delete a password
pass rm old/unused-key

# Search for passwords
pass grep jira

# Show full tree
pass ls

# Sync with git (if using git repo)
pass git push
pass git pull
```

---

## 🔧 Integration Examples

### In Shell Scripts

```bash
#!/bin/bash
# Get API key from pass
API_KEY=$(pass api/openai)

# Use it
curl -H "Authorization: Bearer $API_KEY" https://api.openai.com/v1/...
```

### In Python

```python
import subprocess

def get_secret(path):
    """Get secret from pass"""
    result = subprocess.run(['pass', path], capture_output=True, text=True)
    return result.stdout.strip()

api_key = get_secret('api/openai')
```

### Database Connection

```bash
# .zshrc
export DB_HOST="10.203.146.81"
export DB_USER="MTDNTC0G16L"
export DB_PASSWORD=$(pass db/noe-tracker-password)

# Usage:
psql "postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST/NOETracker"
```

---

## 🔒 Security Best Practices

### 1. Never Commit Plain Text Secrets

```bash
# Add to .gitignore
echo "*secret*" >> .gitignore
echo "*password*" >> .gitignore
echo "*.key" >> .gitignore
echo "*.pem" >> .gitignore
echo ".env" >> .gitignore
```

### 2. Use Different Secrets for Dev/Prod

```bash
pass insert dev/api-key
pass insert prod/api-key
```

### 3. Rotate Exposed Credentials

If you accidentally commit a secret:
1. **Immediately revoke/rotate it**
2. Remove from git history
3. Store new secret in pass

### 4. Backup Your GPG Key

```bash
# Export private key (KEEP SAFE!)
gpg --export-secret-keys > ~/gpg-backup.key

# Export pass store
tar -czf ~/pass-backup.tar.gz ~/.password-store
```

### 5. Use Pre-Commit Hook

Install the pre-commit hook from this repo:

```bash
# See .git/hooks/pre-commit
# Scans for secrets before allowing commit
```

---

## 🌐 Syncing Across Machines

### Option 1: Private Git Repo (Encrypted)

```bash
# On machine 1:
cd ~/.password-store
git remote add origin git@github-p:AnveshJarabani/password-store.git
git push -u origin main

# On machine 2:
pass git clone git@github-p:AnveshJarabani/password-store.git ~/.password-store
```

### Option 2: Manual Transfer

```bash
# Export from machine 1:
tar -czf pass-export.tar.gz ~/.password-store

# Import to machine 2:
tar -xzf pass-export.tar.gz -C ~/
```

---

## 🔍 Audit Your Dotfiles

### Scan for Secrets

```bash
# In your dotfiles repo:
cd ~/dotfiles

# Search for potential secrets
grep -r -i "password\|api.?key\|secret\|token" . --exclude-dir=.git

# Search for long random strings (potential keys)
grep -r -E "[A-Za-z0-9]{32,}" . --exclude-dir=.git --exclude="*.md"
```

### Clean Git History

If you committed secrets:

```bash
# Use BFG Repo-Cleaner
wget https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar
java -jar bfg-1.14.0.jar --delete-files Clipboard.json
git reflog expire --expire=now --all
git gc --prune=now --aggressive
git push --force
```

---

## 📋 Migration Checklist

- [ ] Install `pass`
- [ ] Generate/verify GPG key
- [ ] Initialize pass store
- [ ] Migrate all secrets to pass:
  - [ ] JIRA_API_TOKEN
  - [ ] DB passwords
  - [ ] Mount credentials
  - [ ] API keys (OpenAI, GitHub, etc.)
  - [ ] Other sensitive data
- [ ] Update .zshrc to use `pass`
- [ ] Remove plain-text secrets from files
- [ ] Add sensitive files to .gitignore
- [ ] Commit and push cleaned dotfiles
- [ ] **ROTATE exposed credentials!**
- [ ] Backup GPG key
- [ ] Set up pre-commit hook

---

## 🆘 Troubleshooting

### GPG Agent Issues

```bash
# Restart GPG agent
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

### Can't Decrypt Passwords

```bash
# Check GPG key
gpg --list-keys

# Re-initialize pass with correct key
pass init <correct-key-id>
```

### Permission Issues

```bash
# Fix permissions
chmod 700 ~/.password-store
chmod 600 ~/.password-store/**/*.gpg
```

---

## 📚 Additional Resources

- [pass homepage](https://www.passwordstore.org/)
- [GPG quick start](https://www.gnupg.org/gph/en/manual.html)
- [Git-crypt](https://github.com/AGWA/git-crypt) - Alternative for entire files
- [SOPS](https://github.com/mozilla/sops) - Alternative by Mozilla
- [age](https://github.com/FiloSottile/age) - Modern encryption tool

---

## 🎯 Summary

**Before:**
```bash
export JIRA_API_TOKEN='ATATT3xFfGF...'  # ❌ EXPOSED!
```

**After:**
```bash
export JIRA_API_TOKEN=$(pass work/jira-api-token)  # ✅ SECURE!
```

**Benefits:**
- 🔒 Secrets encrypted with GPG
- 📦 Can commit dotfiles safely
- 🔄 Sync across machines
- 🔑 One master password for all secrets
- 🚀 Easy to use in scripts

---

<div align="center">

**🔐 Keep your secrets secret! 🔐**

*Last updated: 2025-11-30*

</div>
