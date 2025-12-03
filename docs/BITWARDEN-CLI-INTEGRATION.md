# 🔐 Bitwarden CLI Integration with Pass

> YES! You can use Bitwarden CLI to sync, backup, and integrate with pass!

---

## 🎯 What You Can Do

### Bitwarden CLI (`bw`) Capabilities

```bash
# Already installed!
bw --version  # 2025.4.0

# Key features:
✅ Access all Bitwarden vault items from terminal
✅ Sync with Bitwarden cloud
✅ Create/read/update items programmatically  
✅ Generate passwords
✅ Integrate with shell scripts
✅ Store pass secrets IN Bitwarden as backup
✅ Retrieve Bitwarden items TO use with pass
```

---

## 🚀 Quick Start

### 1. Login to Bitwarden

```bash
# Login (one time)
bw login

# Or if already logged in, unlock
bw unlock

# This gives you a session key:
# export BW_SESSION="your-session-key-here"
```

**Better:** Create an alias to auto-unlock:

```bash
# Add to ~/.zshrc
alias bwu='export BW_SESSION=$(bw unlock --raw)'
```

### 2. Basic Commands

```bash
# List all items
bw list items

# Get specific item
bw get item "GPG Master Key"

# Get password only
bw get password "GitHub"

# Get username
bw get username "GitHub"

# Search
bw list items --search "github"

# Sync with cloud
bw sync
```

---

## 🔄 Integration Strategies

### Strategy 1: Store GPG Key in Bitwarden ⭐

**RECOMMENDED FOR YOU!**

```bash
#!/bin/bash
# store-gpg-in-bitwarden.sh

# 1. Create Bitwarden secure note with GPG key
bw get template item | jq \
  '.type = 2 | 
   .secureNote.type = 0 |
   .name = "GPG Master Key - Personal" |
   .notes = "GPG Key ID: AF1A74D1247ACAB69C99182612AB229CE64A58C5
Created: 2025-11-30
Used for: pass password store
Recovery: gpg --import gpg-backup.asc

Passphrase stored separately in Login item" |
   .fields = [
     {"name": "Key ID", "value": "AF1A74D1247ACAB69C99182612AB229CE64A58C5", "type": 0},
     {"name": "Created", "value": "2025-11-30", "type": 0},
     {"name": "Email", "value": "xzput@outlook.com", "type": 0}
   ]' | bw encode | bw create item

echo "✅ Created Bitwarden secure note"
echo "📎 Now attach your GPG key file via web vault or desktop app"
echo "   File: ~/gpg-backup-personal.key"
```

**Add GPG Passphrase as Login:**

```bash
# Create login item for GPG passphrase
bw get template item | jq \
  '.type = 1 |
   .login.username = "AF1A74D1247ACAB69C99182612AB229CE64A58C5" |
   .login.password = "YOUR-GPG-PASSPHRASE-HERE" |
   .name = "GPG Master Key Passphrase" |
   .notes = "Passphrase for personal GPG key used with pass"' \
  | bw encode | bw create item

echo "✅ GPG passphrase stored in Bitwarden"
```

**Retrieve GPG Passphrase:**

```bash
# Get GPG passphrase from Bitwarden when needed
bw get password "GPG Master Key Passphrase"

# Or copy to clipboard
bw get password "GPG Master Key Passphrase" | xclip -selection clipboard
```

---

### Strategy 2: Backup Pass Secrets to Bitwarden

**Create secure notes for critical pass entries:**

```bash
#!/bin/bash
# backup-pass-to-bitwarden.sh

CRITICAL_SECRETS=(
  "work/jira-api-token"
  "db/noe-tracker-password"
  "db/noe-tracker-connection"
)

for secret in "${CRITICAL_SECRETS[@]}"; do
  echo "Backing up: $secret"
  
  # Get secret from pass
  SECRET_VALUE=$(pass "$secret")
  
  # Create Bitwarden secure note
  bw get template item | jq \
    --arg name "BACKUP: $secret" \
    --arg value "$SECRET_VALUE" \
    '.type = 2 |
     .secureNote.type = 0 |
     .name = $name |
     .notes = "Backup from pass\nOriginal location: ~/.password-store/\($name)\nBackup date: '"$(date +%Y-%m-%d)"'" |
     .fields = [{"name": "Secret", "value": $value, "type": 1}]' \
    | bw encode | bw create item
  
  echo "✅ Backed up to Bitwarden"
done

bw sync
echo "🔄 Synced to cloud"
```

---

### Strategy 3: Use Bitwarden AS Your Pass Backend

**Create pass-compatible wrapper:**

```bash
#!/bin/bash
# bw-pass - Use Bitwarden like pass

case "$1" in
  get|show)
    # pass work/jira → bw get password work/jira
    bw get password "$2"
    ;;
  
  insert)
    # pass insert work/new-key
    read -p "Enter secret: " -s SECRET
    bw get template item | jq \
      --arg name "$2" \
      --arg value "$SECRET" \
      '.type = 1 |
       .login.username = "pass-item" |
       .login.password = $value |
       .name = $name' \
      | bw encode | bw create item
    ;;
  
  ls|list)
    # pass ls → bw list items
    bw list items --pretty
    ;;
  
  *)
    echo "Usage: bw-pass {get|insert|ls} <item-name>"
    ;;
esac
```

---

### Strategy 4: Hybrid Sync Script ⭐

**Best approach: Keep both in sync!**

```bash
#!/bin/bash
# sync-pass-bitwarden.sh
# Two-way sync between pass and Bitwarden

# CONFIG
PASS_TO_BW=(
  "work/jira-api-token"
  "db/noe-tracker-password"
)

BW_TO_PASS=(
  "GitHub Personal Token"
  "AWS Access Key"
)

# PASS → BITWARDEN (backup critical secrets)
echo "📤 Syncing pass → Bitwarden..."
for item in "${PASS_TO_BW[@]}"; do
  if pass "$item" > /dev/null 2>&1; then
    echo "  Backing up: $item"
    SECRET=$(pass "$item")
    
    # Check if exists in Bitwarden
    EXISTING=$(bw list items --search "BACKUP: $item" 2>/dev/null | jq -r '.[0].id // empty')
    
    if [ -n "$EXISTING" ]; then
      # Update existing
      bw get item "$EXISTING" | jq \
        --arg value "$SECRET" \
        '.notes = "Updated: '"$(date)"'" |
         .fields[0].value = $value' \
        | bw encode | bw edit item "$EXISTING"
    else
      # Create new
      bw get template item | jq \
        --arg name "BACKUP: $item" \
        --arg value "$SECRET" \
        '.type = 2 |
         .secureNote.type = 0 |
         .name = $name |
         .fields = [{"name": "Secret", "value": $value, "type": 1}]' \
        | bw encode | bw create item
    fi
  fi
done

# BITWARDEN → PASS (retrieve specific items)
echo "📥 Syncing Bitwarden → pass..."
for item in "${BW_TO_PASS[@]}"; do
  echo "  Retrieving: $item"
  PASSWORD=$(bw get password "$item" 2>/dev/null)
  
  if [ -n "$PASSWORD" ]; then
    # Store in pass under bw/ directory
    echo "$PASSWORD" | pass insert -m "bw/$(echo $item | tr ' ' '-' | tr '[:upper:]' '[:lower:]')"
  fi
done

bw sync
echo "✅ Sync complete!"
```

---

## 🔧 Useful Scripts

### Get GPG Passphrase from Bitwarden

```bash
#!/bin/bash
# gpg-unlock-from-bw.sh
# Auto-unlock GPG using passphrase from Bitwarden

# Get passphrase
GPG_PASS=$(bw get password "GPG Master Key Passphrase")

# Test GPG with this passphrase
echo "test" | gpg --batch --passphrase "$GPG_PASS" \
  --encrypt --recipient AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
  gpg --batch --passphrase "$GPG_PASS" --decrypt > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "✅ GPG unlocked successfully!"
  # Cache the passphrase
  echo "test" | gpg --batch --passphrase "$GPG_PASS" \
    --encrypt --recipient AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
    gpg --decrypt > /dev/null 2>&1
else
  echo "❌ Failed to unlock GPG"
fi
```

### Emergency Pass Recovery from Bitwarden

```bash
#!/bin/bash
# emergency-recovery.sh
# Restore pass secrets from Bitwarden backups

echo "🚨 Emergency Recovery: Restoring pass from Bitwarden backups"

# List all backup items
BACKUPS=$(bw list items --search "BACKUP:" | jq -r '.[] | .name')

for backup in $BACKUPS; do
  # Remove "BACKUP: " prefix to get original path
  ORIGINAL_PATH=${backup#BACKUP: }
  
  # Get secret value
  SECRET=$(bw list items --search "$backup" | jq -r '.[0].fields[] | select(.name=="Secret") | .value')
  
  if [ -n "$SECRET" ]; then
    echo "Restoring: $ORIGINAL_PATH"
    echo "$SECRET" | pass insert -m "$ORIGINAL_PATH"
  fi
done

echo "✅ Recovery complete!"
```

---

## ⚡ Shell Integration

### Add to ~/.zshrc

```bash
# Bitwarden CLI shortcuts
alias bwu='export BW_SESSION=$(bw unlock --raw)'  # Unlock and set session
alias bwl='bw lock && unset BW_SESSION'            # Lock and clear session
alias bws='bw sync'                                 # Sync with cloud
alias bwg='bw get password'                         # Get password
alias bwls='bw list items --pretty'                 # List all items
alias bwsearch='bw list items --search'             # Search items

# Get password and copy to clipboard
bwc() {
  bw get password "$1" | xclip -selection clipboard
  echo "✅ Copied to clipboard (will clear in 45s)"
  (sleep 45 && echo -n "" | xclip -selection clipboard) &
}

# Get secret from either pass or Bitwarden
secret() {
  # Try pass first
  if pass "$1" > /dev/null 2>&1; then
    pass "$1"
  else
    # Try Bitwarden
    bw get password "$1"
  fi
}

# Store GPG passphrase in session (from Bitwarden)
gpg-unlock() {
  export GPG_PASSPHRASE=$(bw get password "GPG Master Key Passphrase")
  echo "✅ GPG passphrase loaded from Bitwarden"
}
```

---

## 📊 Comparison: Pass vs Bitwarden CLI

| Feature | pass | bw (Bitwarden CLI) |
|---------|------|-------------------|
| **Storage** | Local files | Cloud + local cache |
| **Encryption** | GPG (your key) | AES-256 (Bitwarden's) |
| **Sync** | Manual (git) | Automatic (cloud) |
| **Access** | Instant (local) | Needs unlock/session |
| **Sharing** | Manual | Built-in sharing |
| **Browser** | No | Yes (via extension) |
| **Mobile** | Advanced | Native apps |
| **Backup** | Your responsibility | Automatic (cloud) |
| **Trust** | You control everything | Trust Bitwarden |
| **Speed** | Very fast | Depends on network |

---

## 🎯 Recommended Workflow

### Daily Usage

```bash
# Morning: Unlock both
bwu                    # Unlock Bitwarden (sets BW_SESSION)
# pass auto-unlocks when needed (GPG cached)

# During work: Use pass for server/dev
export JIRA_TOKEN=$(pass work/jira-api-token)
ssh-add <(pass ssh/keys/id_rsa)

# During browsing: Bitwarden extension handles websites

# Evening: Lock both
bwl                    # Lock Bitwarden
gpgconf --kill gpg-agent  # Clear GPG cache
```

### Weekly Backup

```bash
#!/bin/bash
# weekly-backup.sh

# Unlock Bitwarden
export BW_SESSION=$(bw unlock --raw)

# Backup critical pass secrets to Bitwarden
./backup-pass-to-bitwarden.sh

# Sync
bw sync

echo "✅ Weekly backup complete!"
```

### Monthly Security Check

```bash
#!/bin/bash
# monthly-security-check.sh

echo "🔐 Monthly Security Audit"
echo ""

# 1. Check Bitwarden vault
echo "1. Checking Bitwarden vault..."
bw sync
ITEM_COUNT=$(bw list items | jq length)
echo "   Items in vault: $ITEM_COUNT"

# 2. Check pass store
echo "2. Checking pass store..."
PASS_COUNT=$(find ~/.password-store -name "*.gpg" | wc -l)
echo "   Items in pass: $PASS_COUNT"

# 3. Verify GPG key backup in Bitwarden
echo "3. Verifying GPG key backup..."
bw list items --search "GPG Master Key" | jq -r '.[0].name'

# 4. Test GPG passphrase from Bitwarden
echo "4. Testing GPG passphrase..."
GPG_PASS=$(bw get password "GPG Master Key Passphrase")
echo "test" | gpg --batch --passphrase "$GPG_PASS" \
  --encrypt --recipient AF1A74D1247ACAB69C99182612AB229CE64A58C5 | \
  gpg --batch --passphrase "$GPG_PASS" --decrypt > /dev/null 2>&1 \
  && echo "   ✅ GPG passphrase valid" \
  || echo "   ❌ GPG passphrase invalid!"

echo ""
echo "✅ Security check complete!"
```

---

## 💡 Pro Tips

### 1. Session Management

```bash
# Store session in file for reuse
bw unlock --raw > ~/.bw-session
export BW_SESSION=$(cat ~/.bw-session)

# Auto-expire session after 1 hour
bw unlock --raw > ~/.bw-session
(sleep 3600 && rm ~/.bw-session && bw lock) &
```

### 2. Secure Note Templates

```bash
# Create template for storing pass secrets
bw get template item | jq \
  '.type = 2 |
   .secureNote.type = 0 |
   .name = "TEMPLATE: Pass Secret" |
   .fields = [
     {"name": "Path", "value": "", "type": 0},
     {"name": "Secret", "value": "", "type": 1},
     {"name": "Created", "value": "", "type": 0},
     {"name": "Notes", "value": "", "type": 0}
   ]' > ~/pass-secret-template.json
```

### 3. Emergency Kit

Store this in Bitwarden as a secure note:

```
EMERGENCY RECOVERY INSTRUCTIONS

If you lose access to pass:
1. Install pass: sudo apt install pass
2. Unlock Bitwarden: bw unlock
3. Download GPG key attachment from "GPG Master Key" item
4. Import: gpg --import gpg-backup.asc
5. Get passphrase from "GPG Master Key Passphrase" item
6. Trust key: gpg --edit-key AF1A... trust 5 quit
7. Restore secrets from "BACKUP:" items in Bitwarden
8. Or restore from git: git clone <repo> ~/.password-store

GPG Key ID: AF1A74D1247ACAB69C99182612AB229CE64A58C5
Email: xzput@outlook.com
Created: 2025-11-30
```

---

## 🚀 Quick Setup

```bash
#!/bin/bash
# setup-bitwarden-pass-integration.sh

echo "🔐 Setting up Bitwarden + Pass integration..."

# 1. Login to Bitwarden
echo "1. Login to Bitwarden..."
bw login

# 2. Store GPG passphrase
echo "2. Storing GPG passphrase in Bitwarden..."
read -sp "Enter your GPG passphrase: " GPG_PASS
bw get template item | jq \
  --arg pass "$GPG_PASS" \
  '.type = 1 |
   .login.username = "AF1A74D1247ACAB69C99182612AB229CE64A58C5" |
   .login.password = $pass |
   .name = "GPG Master Key Passphrase"' \
  | bw encode | bw create item

# 3. Add shell aliases
echo "" >> ~/.zshrc
echo "# Bitwarden CLI shortcuts" >> ~/.zshrc
cat << 'ALIASES' >> ~/.zshrc
alias bwu='export BW_SESSION=$(bw unlock --raw)'
alias bwl='bw lock && unset BW_SESSION'
alias bws='bw sync'
alias bwg='bw get password'
ALIASES

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Web vault: Upload ~/gpg-backup-personal.key as attachment"
echo "2. Run: source ~/.zshrc"
echo "3. Test: bwu && bwg 'GPG Master Key Passphrase'"
```

---

<div align="center">

**🔐 Bitwarden CLI + Pass = Ultimate Security! 🔐**

*Cloud convenience meets local control*

</div>
