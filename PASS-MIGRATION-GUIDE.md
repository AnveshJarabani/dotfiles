# 🔄 Pass Migration & Replication Guide

> Complete guide to sync your encrypted password store across machines and store any type of secret (including SSH keys!)

---

## 🚀 Quick Migration (New Machine)

### Option 1: Git Sync (Recommended) ⭐

**On current machine (one-time setup):**
```bash
# Create private GitHub repo for password store
cd ~/.password-store
git remote add origin git@github-p:AnveshJarabani/password-store.git
git push -u origin main
```

**On new machine:**
```bash
# 1. Install pass
sudo apt install pass

# 2. Import GPG key
scp your-server:~/gpg-backup-personal.key ~/
gpg --import ~/gpg-backup-personal.key
gpg --edit-key AF1A74D1247ACAB69C99182612AB229CE64A58C5
  trust
  5 (ultimate)
  quit

# 3. Clone password store
git clone git@github-p:AnveshJarabani/password-store.git ~/.password-store

# 4. Done! Test it
pass
```

**That's it! 3 commands and you're synced!** 🎉

---

### Option 2: Manual Transfer

**Export from current machine:**
```bash
# Export GPG key
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 > ~/gpg-personal.key

# Export password store
tar -czf ~/pass-store.tar.gz ~/.password-store

# Transfer files
scp ~/gpg-personal.key ~/pass-store.tar.gz new-machine:~/
```

**Import on new machine:**
```bash
# Install pass
sudo apt install pass

# Import GPG key and trust it
gpg --import ~/gpg-personal.key
gpg --edit-key AF1A74D1247ACAB69C99182612AB229CE64A58C5
  trust
  5
  quit

# Extract password store
tar -xzf ~/pass-store.tar.gz -C ~/

# Done!
pass
```

---

## 🔐 Storing SSH Keys in Pass

### YES! You can store SSH keys, certificates, and ANY files!

### Store Private Keys

```bash
# Store SSH private key
cat ~/.ssh/id_rsa | pass insert -m ssh/keys/id_rsa

# Store GitHub SSH key
cat ~/.ssh/id_rsa_github | pass insert -m ssh/keys/github

# Store SSH config
cat ~/.ssh/config | pass insert -m ssh/config
```

### Restore SSH Keys

```bash
# Restore private key
pass ssh/keys/id_rsa > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

# Restore SSH config
pass ssh/config > ~/.ssh/config
chmod 600 ~/.ssh/config

# Generate public key from private
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
```

### Complete SSH Backup Script

```bash
#!/bin/bash
# backup-ssh-to-pass.sh

echo "🔐 Backing up SSH keys to pass..."

# Store all private keys
for key in ~/.ssh/id_*; do
  [[ -f "$key" && ! "$key" =~ \.pub$ ]] && \
    cat "$key" | pass insert -m "ssh/keys/$(basename $key)"
done

# Store SSH config
cat ~/.ssh/config | pass insert -m ssh/config

# Store authorized_keys
cat ~/.ssh/authorized_keys | pass insert -m ssh/authorized_keys

echo "✅ SSH keys backed up!"
pass ls ssh
```

---

## 📦 What You Can Store

| Type | Example | Command |
|------|---------|---------|
| **Passwords** | Database, API keys | `pass insert db/password` |
| **SSH Keys** | Private keys | `cat ~/.ssh/id_rsa \| pass insert -m ssh/keys/id_rsa` |
| **Certificates** | SSL/TLS, PEM | `cat cert.pem \| pass insert -m certs/ssl` |
| **Tokens** | GitHub, JIRA | `pass insert tokens/github` |
| **Config Files** | .env, kubeconfig | `cat .env \| pass insert -m configs/env` |
| **GPG Keys** | Backup keys | `gpg --export-secret-key \| pass insert -m gpg/backup` |
| **2FA Seeds** | TOTP secrets | `pass insert 2fa/github` |
| **JSON/YAML** | AWS config, etc | `cat config.json \| pass insert -m api/aws` |

---

## 🔄 Syncing Workflow

### Daily Usage

```bash
# After adding/updating secrets
cd ~/.password-store
git pull --rebase  # Get changes from other machines
git push          # Push your changes
```

### Or use pass git commands:
```bash
pass git pull
pass git push
```

### Auto-sync on Shell Startup

Add to `.zshrc`:
```bash
# Auto-sync pass on shell start (runs in background)
(cd ~/.password-store && git pull --rebase && git push) 2>/dev/null &
```

---

## 🏗️ Restore SSH on New Machine

```bash
#!/bin/bash
# restore-ssh-from-pass.sh

mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Restore all SSH keys
pass ls ssh/keys | while read key; do
  keyfile=$(basename "$key")
  pass "ssh/keys/$keyfile" > ~/.ssh/"$keyfile"
  chmod 600 ~/.ssh/"$keyfile"
  
  # Generate public key
  ssh-keygen -y -f ~/.ssh/"$keyfile" > ~/.ssh/"$keyfile.pub"
done

# Restore SSH config
pass ssh/config > ~/.ssh/config
chmod 600 ~/.ssh/config

echo "✅ SSH keys restored from pass!"
ls -la ~/.ssh
```

---

## 🌐 Recommended Structure

```
~/.password-store/
├── work/
│   ├── jira-api-token
│   ├── vpn-password
│   └── aws-credentials
├── personal/
│   ├── email-password
│   └── github-token
├── ssh/
│   ├── keys/
│   │   ├── id_rsa
│   │   ├── id_rsa_github
│   │   └── id_rsa_work
│   ├── config
│   └── authorized_keys
├── db/
│   ├── prod-password
│   └── dev-password
├── api/
│   ├── openai
│   └── stripe
└── certs/
    ├── ssl-cert.pem
    └── client-cert.pem
```

---

## 🔒 Security Best Practices

### 1. Backup Your GPG Key (Multiple Locations)

```bash
# Export GPG key
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 > ~/gpg-backup.key

# Store in:
# - External USB drive
# - Encrypted cloud storage
# - Physical safe
# - Another pass entry: cat ~/gpg-backup.key | pass insert -m gpg/master-key
```

### 2. Use Private GitHub Repo

```bash
# Create private repo on GitHub
# Enable 2FA on your GitHub account
# Use SSH keys (not HTTPS) for authentication
```

### 3. Trust Your GPG Key

```bash
# After importing, always set ultimate trust
gpg --edit-key AF1A74D1247ACAB69C99182612AB229CE64A58C5
  trust
  5  # ultimate trust
  quit
```

---

## 💡 Pro Tips

### Quick Aliases

Add to `.zshrc`:
```bash
alias p="pass"
alias pc="pass -c"      # Copy to clipboard
alias pg="pass generate"
alias pe="pass edit"
alias pl="pass ls"
```

### Generate Strong Passwords

```bash
pass generate api/new-service 32      # 32 char password
pass generate api/simple 20 -n        # No symbols
```

### Search Secrets

```bash
pass grep "github"  # Find all containing "github"
pass find jira      # Find by path
```

### Store Multi-line Data

```bash
# Store JSON config
cat << 'EOF' | pass insert -m api/aws-config
{
  "access_key": "AKIA...",
  "secret_key": "wJalr...",
  "region": "us-east-1"
}
EOF

# Retrieve
pass api/aws-config
```

---

## 📱 Mobile Access

### Android
1. Install **Password Store** app (F-Droid)
2. Clone your git repo
3. Import GPG key via OpenKeychain
4. Access all passwords on phone!

### iOS
1. Install **Pass for iOS** (App Store)
2. Similar setup to Android

---

## 🎯 New Machine Setup Checklist

- [ ] Install `pass` and `gpg`
- [ ] Import GPG key: `gpg --import ~/gpg-backup-personal.key`
- [ ] Trust key: `gpg --edit-key ... trust 5`
- [ ] Clone password store: `git clone git@github-p:AnveshJarabani/password-store.git ~/.password-store`
- [ ] Test: `pass work/jira-api-token`
- [ ] Restore SSH keys: Run restore script
- [ ] Set permissions: `chmod 600 ~/.ssh/*`
- [ ] Update .zshrc to load secrets
- [ ] Test all integrations

---

## 🚀 Complete Setup Script

```bash
#!/bin/bash
# setup-pass-new-machine.sh

set -e

echo "🔐 Setting up pass on new machine..."

# Install
sudo apt update && sudo apt install -y pass gpg

# Import GPG key
echo "Import GPG key from old machine..."
read -p "Path to GPG backup: " gpg_path
gpg --import "$gpg_path"

# Trust key
echo "Setting ultimate trust..."
gpg --edit-key AF1A74D1247ACAB69C99182612AB229CE64A58C5 trust quit

# Clone password store
git clone git@github-p:AnveshJarabani/password-store.git ~/.password-store

# Restore SSH
mkdir -p ~/.ssh && chmod 700 ~/.ssh
pass ssh/keys/id_rsa > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
pass ssh/config > ~/.ssh/config && chmod 600 ~/.ssh/config
ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub

echo "✅ Setup complete!"
pass
```

---

<div align="center">

**🔄 Your secrets, everywhere! 🔄**

*Secure • Simple • Synchronized*

</div>
