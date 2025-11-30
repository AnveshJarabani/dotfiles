# 🔐 Pass, GPG Keys, and Bitwarden Integration - Complete Guide

> Everything you need to know about how pass works, GPG key management, and using it alongside Bitwarden

---

## 🎯 How Pass Works - The Complete Picture

### Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                         YOU                                  │
│                    (Has passphrase)                          │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ↓
┌─────────────────────────────────────────────────────────────┐
│                    GPG KEY PAIR                              │
│  ┌──────────────────┐        ┌─────────────────────┐       │
│  │  Private Key     │        │   Public Key        │       │
│  │  (Encrypts &     │        │   (Only encrypts)   │       │
│  │   Decrypts)      │        │                     │       │
│  │  ~/.gnupg/       │        │   ~/.gnupg/         │       │
│  │  PROTECTED BY    │        │   Can share freely  │       │
│  │  PASSPHRASE      │        │                     │       │
│  └──────────────────┘        └─────────────────────┘       │
└─────────────────────────────────────────────────────────────┘
                       │
                       ↓
┌─────────────────────────────────────────────────────────────┐
│                  PASSWORD STORE                              │
│              ~/.password-store/                              │
│  ┌──────────────────────────────────────────────┐           │
│  │  work/                                       │           │
│  │    jira-api-token.gpg  ← ENCRYPTED FILE     │           │
│  │  db/                                         │           │
│  │    password.gpg        ← ENCRYPTED FILE     │           │
│  │  ssh/                                        │           │
│  │    id_rsa.gpg          ← ENCRYPTED FILE     │           │
│  └──────────────────────────────────────────────┘           │
│                                                              │
│  ALL FILES ARE:                                             │
│  ✅ Encrypted with YOUR public key                         │
│  ✅ Stored LOCALLY on your disk                            │
│  ✅ Can be synced via git (still encrypted)                │
│  ❌ NO remote server                                        │
│  ❌ NO cloud service                                        │
└─────────────────────────────────────────────────────────────┘
```

---

## 🔑 How GPG Keys Work with Pass

### 1. Initialization

```bash
pass init AF1A74D1247ACAB69C99182612AB229CE64A58C5
```

**What happens:**
1. Pass creates `~/.password-store/` directory
2. Stores your GPG key ID in `.gpg-id` file
3. Every secret will be encrypted with this key

**The `.gpg-id` file:**
```bash
cat ~/.password-store/.gpg-id
# Output: AF1A74D1247ACAB69C99182612AB229CE64A58C5
```

This tells pass: "Use THIS key to encrypt everything"

### 2. Storing a Secret

```bash
pass insert work/jira-api-token
# You type: ATATT3xFfGF...
```

**Behind the scenes:**
```bash
# Pass runs this:
echo "ATATT3xFfGF..." | gpg --encrypt --recipient AF1A74D1247ACAB69C99182612AB229CE64A58C5 \
  > ~/.password-store/work/jira-api-token.gpg
```

**Result:**
- Plain text: `ATATT3xFfGF...`
- Encrypted file: Binary gibberish
- Can only be decrypted by YOUR private key

### 3. Retrieving a Secret

```bash
pass work/jira-api-token
```

**Behind the scenes:**
```bash
# Pass runs this:
gpg --decrypt ~/.password-store/work/jira-api-token.gpg
# GPG asks for your passphrase (if not cached)
# Then decrypts and shows the secret
```

**Security flow:**
1. Pass finds the encrypted file
2. GPG checks: "Do I have the private key?"
3. GPG asks: "What's your passphrase?"
4. You enter passphrase
5. GPG decrypts using private key
6. Pass shows you the secret

---

## 💾 Where is Data Stored?

### 100% LOCAL - No Remote Server!

```
Your Computer
├── ~/.gnupg/                    ← GPG keys (private & public)
│   ├── pubring.kbx              ← Public keys
│   ├── private-keys-v1.d/       ← Private keys (encrypted)
│   └── trustdb.gpg              ← Key trust database
│
└── ~/.password-store/           ← Pass encrypted secrets
    ├── .gpg-id                  ← Which key to use
    ├── .git/                    ← Optional git repo
    ├── work/
    │   └── jira-api-token.gpg   ← ENCRYPTED file
    └── db/
        └── password.gpg         ← ENCRYPTED file

ALL FILES ARE ON YOUR DISK!
```

### What Gets Synced (Optional)

If you use `pass git`:
```bash
cd ~/.password-store
git remote add origin git@github.com:you/password-store.git
git push
```

**What goes to GitHub:**
- ✅ `.gpg-id` (just the key ID, not the key itself)
- ✅ `work/jira-api-token.gpg` (ENCRYPTED, useless without your private key)
- ✅ `db/password.gpg` (ENCRYPTED, useless without your private key)
- ❌ Your GPG private key (NEVER uploaded)

**Even if GitHub is hacked:**
- Attacker gets encrypted files
- Without your GPG private key → useless
- Without your passphrase → useless

---

## 🔐 GPG Key Management - Long Term

### Challenge
GPG keys are critical:
- Lose the key = lose ALL passwords
- Forget passphrase = lose ALL passwords
- Need to keep them safe for YEARS

### Solution: Multi-Layer Backup Strategy

#### 1. **Primary Backup (Encrypted USB Drive)**

```bash
# Export GPG private key
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 > gpg-private-key.asc

# Export pass store
tar -czf password-store.tar.gz ~/.password-store

# Copy to encrypted USB drive
# Use VeraCrypt, LUKS, or BitLocker to encrypt the USB
```

**Storage:**
- 2-3 USB drives in different locations
- Physical safe
- Safe deposit box

#### 2. **Cloud Backup (Double Encrypted)**

Your GPG key is already encrypted with a passphrase, but add another layer:

```bash
# Encrypt the GPG key export with a DIFFERENT password
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
  gpg --symmetric --cipher-algo AES256 > gpg-key-backup.gpg

# Upload to Dropbox/Google Drive/OneDrive
# Even if cloud is hacked, they need TWO passwords:
#   1. Symmetric encryption password
#   2. GPG key passphrase
```

#### 3. **Bitwarden Integration** ⭐ RECOMMENDED

Store your GPG passphrase in Bitwarden:

```
Bitwarden Entry:
┌────────────────────────────────────────┐
│ Name: GPG Master Key Passphrase        │
│ Username: AF1A74D1247ACAB69C99182612AB │
│ Password: [your GPG passphrase]        │
│ Notes:                                 │
│   Key ID: AF1A74D1247ACAB69C99182612AB│
│   Created: 2025-11-30                  │
│   Backup location: USB drive in safe   │
│                                        │
│   Recovery Instructions:               │
│   1. Get backup from USB/cloud         │
│   2. gpg --import gpg-private-key.asc  │
│   3. Use this passphrase               │
└────────────────────────────────────────┘
```

**Plus:** Store the GPG key itself in Bitwarden as an attachment!

```bash
# Attach to Bitwarden:
1. Export: gpg --export-secret-keys AF1A74... > gpg-backup.asc
2. Open Bitwarden → Edit entry
3. Attachments → Upload gpg-backup.asc
4. Delete local copy (it's in Bitwarden now)
```

#### 4. **Paper Backup (Nuclear Option)**

For ultimate paranoia:

```bash
# Print the key as QR code or text
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
  paperkey --output gpg-paper-backup.txt

# Or use paperkey + qrencode for QR codes
```

Store the paper in:
- Physical safe
- Safe deposit box
- With trusted family member

---

## 🔄 Pass + Bitwarden: Best of Both Worlds

### Why Use Both?

| Feature | Pass | Bitwarden |
|---------|------|-----------|
| **Shell integration** | ✅ Perfect | ❌ No |
| **Browser autofill** | ❌ No | ✅ Perfect |
| **Team sharing** | ❌ Manual | ✅ Built-in |
| **Mobile access** | ⚠️ Advanced | ✅ Easy |
| **Cross-platform** | ⚠️ Linux/Mac | ✅ Everything |
| **CLI access** | ✅ Native | ⚠️ Via API |
| **Git sync** | ✅ Built-in | ❌ Cloud only |
| **Open source** | ✅ Yes | ⚠️ Partial |
| **Offline access** | ✅ Yes | ⚠️ Limited |

### Recommended Split

**Use Pass for:**
```bash
# Server/development credentials
~/.password-store/
├── work/
│   ├── jira-api-token
│   ├── aws-access-key
│   └── database-passwords
├── ssh/
│   ├── id_rsa
│   └── id_rsa_github
└── api/
    ├── openai
    └── stripe

# Accessed in terminal, scripts, SSH
```

**Use Bitwarden for:**
```
- Website logins (autofill)
- Personal accounts (email, social media)
- Credit cards
- 2FA/TOTP codes
- Shared family passwords
- Secure notes
- GPG passphrase backup!
```

### Integration Script

```bash
#!/bin/bash
# sync-pass-to-bitwarden.sh
# Backup critical pass entries to Bitwarden as secure notes

SECRETS_TO_BACKUP=(
  "work/jira-api-token"
  "db/noe-tracker-password"
  "ssh/id_rsa"
)

for secret in "${SECRETS_TO_BACKUP[@]}"; do
  echo "Backup $secret to Bitwarden as secure note:"
  echo "1. pass $secret"
  echo "2. Copy output"
  echo "3. Create secure note in Bitwarden: 'BACKUP: $secret'"
  echo ""
done
```

---

## 🛡️ Long-Term GPG Key Management Strategy

### The 3-2-1 Backup Rule

**3** copies of your GPG key:
1. Original on your main computer (`~/.gnupg/`)
2. Encrypted USB drive (in safe)
3. Bitwarden attachment

**2** different storage types:
1. Local (USB, disk)
2. Cloud (Bitwarden, encrypted Dropbox)

**1** copy off-site:
1. Cloud backup OR
2. Safe deposit box OR
3. Trusted family member

### Annual Maintenance Checklist

```bash
#!/bin/bash
# gpg-annual-check.sh
# Run once a year!

echo "📅 Annual GPG Key Maintenance"
echo ""

# 1. Check key expiration
echo "1. Checking key expiration..."
gpg --list-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5
echo "   → Does it expire soon? Extend if needed."
echo ""

# 2. Verify passphrase
echo "2. Testing passphrase..."
echo "test" | gpg --encrypt --recipient AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
  gpg --decrypt > /dev/null 2>&1 && \
  echo "   ✅ Passphrase correct!" || \
  echo "   ❌ Passphrase wrong - check Bitwarden backup!"
echo ""

# 3. Test backups
echo "3. Verify backups exist:"
echo "   - USB drive in safe?"
echo "   - Bitwarden attachment?"
echo "   - Cloud backup?"
echo ""

# 4. Update backup
echo "4. Creating fresh backup..."
gpg --export-secret-keys AF1A74D1247ACAB69C99182612AB229CE64A58C5 > \
  ~/gpg-backup-$(date +%Y).asc
echo "   → Upload to Bitwarden/cloud"
echo ""

echo "✅ Maintenance complete!"
```

### Extending Key Expiration

If your key expires:
```bash
# Edit key
gpg --edit-key AF1A74D1247ACAB69C99182612AB229CE64A58C5

# In GPG prompt:
gpg> expire
  # Choose: 0 (never expires) or 5y (5 years)
gpg> key 1
  # Select subkey
gpg> expire
  # Extend subkey too
gpg> save

# Re-export and update backups
gpg --export-secret-keys AF1A... > gpg-backup-new.asc
```

---

## 🔒 Security Best Practices

### GPG Passphrase

**DO:**
- ✅ Use 20+ character passphrase
- ✅ Use Diceware or random words
- ✅ Store in Bitwarden
- ✅ Write on paper (in safe)

**DON'T:**
- ❌ Use weak password
- ❌ Store in plain text file
- ❌ Email to yourself
- ❌ Forget to back it up!

### Pass Store Security

```bash
# Set restrictive permissions
chmod 700 ~/.password-store
chmod 600 ~/.password-store/**/*.gpg

# If syncing to git, use SSH keys
git remote set-url origin git@github.com:you/password-store.git

# Optionally encrypt the entire .password-store directory
# Use disk encryption (LUKS, FileVault, BitLocker)
```

### Key Rotation Strategy

**When to create a new GPG key:**
- Every 2-5 years (best practice)
- If passphrase compromised
- If private key possibly leaked

**How to rotate:**
```bash
# 1. Generate new key
gpg --full-generate-key

# 2. Re-initialize pass with new key
pass init NEW-KEY-ID

# 3. Pass re-encrypts everything automatically!

# 4. Export old key before deleting
gpg --export-secret-keys OLD-KEY-ID > old-key-backup.asc

# 5. Eventually delete old key
gpg --delete-secret-key OLD-KEY-ID
```

---

## 🚀 Quick Reference

### Daily Usage

```bash
# Store secret
pass insert work/new-api-key

# Get secret
pass work/new-api-key

# Copy to clipboard (auto-clears in 45s)
pass -c work/new-api-key

# Use in script
export API_KEY=$(pass work/api-key)

# Sync (if using git)
pass git pull
pass git push
```

### Backup/Restore

```bash
# BACKUP
gpg --export-secret-keys AF1A... > gpg-backup.asc
tar -czf pass-backup.tar.gz ~/.password-store

# RESTORE
gpg --import gpg-backup.asc
tar -xzf pass-backup.tar.gz -C ~/
gpg --edit-key AF1A... trust quit  # Set trust to 5
```

### Emergency Recovery

**If you lose your GPG key:**
1. Get backup from Bitwarden attachment
2. `gpg --import gpg-backup.asc`
3. Get passphrase from Bitwarden
4. `gpg --edit-key AF1A... trust quit` (set to 5)
5. `pass` should now work!

**If you forget your passphrase:**
1. Get passphrase from Bitwarden
2. If not in Bitwarden → check paper backup
3. If no backup → 🔥 All passwords lost

---

## 📊 Comparison Summary

### Pass Advantages

- ✅ **Privacy:** Everything local, you control it
- ✅ **Simplicity:** Just encrypted files + git
- ✅ **Shell integration:** Perfect for scripts/SSH
- ✅ **Offline:** Works without internet
- ✅ **Open source:** Auditable, no vendor lock-in
- ✅ **Flexibility:** Store any file type
- ✅ **Git integration:** Track changes, sync easily

### Bitwarden Advantages

- ✅ **User-friendly:** Great UI/UX
- ✅ **Browser integration:** Autofill
- ✅ **Cross-platform:** Works everywhere
- ✅ **Team features:** Easy sharing
- ✅ **Mobile apps:** Full-featured
- ✅ **Cloud sync:** Automatic
- ✅ **2FA:** Built-in TOTP

### The Hybrid Approach ⭐

```
┌─────────────────────────────────────────┐
│           BITWARDEN (Cloud)             │
│  ┌────────────────────────────────┐    │
│  │ - Website logins               │    │
│  │ - Personal accounts            │    │
│  │ - Credit cards                 │    │
│  │ - 2FA/TOTP codes               │    │
│  │ - GPG PASSPHRASE BACKUP ⭐    │    │
│  │ - GPG KEY FILE ATTACHMENT ⭐  │    │
│  └────────────────────────────────┘    │
└─────────────────────────────────────────┘
                  ↕
┌─────────────────────────────────────────┐
│           PASS (Local)                  │
│  ┌────────────────────────────────┐    │
│  │ - Server credentials           │    │
│  │ - API keys                     │    │
│  │ - SSH keys                     │    │
│  │ - Database passwords           │    │
│  │ - Shell script secrets         │    │
│  └────────────────────────────────┘    │
└─────────────────────────────────────────┘
```

**Best of both worlds!**

---

<div align="center">

**🔐 Understand → Secure → Backup → Relax 🔐**

*Your secrets are safe with pass + GPG + Bitwarden!*

</div>
