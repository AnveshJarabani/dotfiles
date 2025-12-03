# Pass Integration in Dotfiles

This dotfile setup uses `pass` (the standard Unix password manager) for secure credential management instead of storing sensitive data in `~/.ssh` or config files.

## Why Pass?

✅ **Encrypted** - All credentials encrypted with GPG  
✅ **Git-backed** - Version controlled and synced across machines  
✅ **No plaintext** - Credentials never stored in dotfiles  
✅ **Secure sharing** - Can share dotfiles publicly without exposing secrets  

## Setup on New System

### 1. Restore GPG Keys
```bash
# Import GPG key from backup
gpg --import gpg-backup-all-keys.asc

# Trust the keys
gpg --edit-key 2B9BE0A0C0632BBE  # Git signing key
# Type: trust, 5, y, quit

gpg --edit-key 12AB229CE64A58C5  # Pass encryption key
# Type: trust, 5, y, quit
```

### 2. Clone Pass Repository
```bash
git clone git@github-p:AnveshJarabani/pass.git ~/.password-store
```

### 3. Test Pass Works
```bash
pass  # Should show your password tree
```

## Credentials Stored in Pass

### SSH Keys
```
ssh/
├── git_p              # GitHub personal SSH key
├── google_compute_engine
├── id_rsa
├── id_rsa_p
├── nuc2               # Home server SSH keys
├── nuc3
├── nuc4
├── pihole
├── pihole2
├── pihole3
├── px
├── sftpgo_wsl
├── snowflake_prod.p8  # Snowflake private keys
└── snowflake_qa.p8
```

### Database Credentials
```
db/
├── noe-tracker-connection
└── noe-tracker-password
```

### Cloud Credentials
```
gcloud/
└── application_default_credentials

snowflake/
└── temporary_credential
```

### Work Credentials
```
work/
└── jira-api-token
```

## Updated Aliases

All SSH aliases now use pass instead of `~/.ssh`:

```bash
# Old way (hardcoded paths):
alias nuc3="ssh -i ~/.ssh/nuc3 root@192.168.1.103"

# New way (from pass):
alias nuc3="ssh -i <(pass ssh/nuc3) root@192.168.1.103"
```

## Helper Functions

### `list_creds`
Show all available credentials in pass:
```bash
list_creds
```

### `pssh <key_name> <ssh_args>`
SSH with a key from pass (for ad-hoc connections):
```bash
pssh nuc2 root@192.168.1.102
pssh pihole root@pihole.local
```

### `get_snowflake_key [prod|qa]`
Get Snowflake private key:
```bash
get_snowflake_key prod   # Production key
get_snowflake_key qa     # QA key
```

### `export_snowflake_key [prod|qa]`
Export Snowflake key to temp file:
```bash
export_snowflake_key prod
# Snowflake key exported to: /tmp/snowflake_prod.p8
# export SNOWFLAKE_PRIVATE_KEY_PATH=/tmp/snowflake_prod.p8
```

### `get_gcloud_creds`
Get Google Cloud credentials:
```bash
get_gcloud_creds
```

### `export_gcloud_creds`
Export GCloud credentials to standard location:
```bash
export_gcloud_creds
# GCloud credentials exported to: ~/.config/gcloud/application_default_credentials.json
```

## Environment Variables from Pass

Already configured in `.zshrc`:

```bash
export JIRA_API_TOKEN=$(pass work/jira-api-token)
```

You can add more as needed:
```bash
export DB_PASSWORD=$(pass db/noe-tracker-password)
export SNOWFLAKE_PRIVATE_KEY_PATH=<(pass ssh/snowflake_prod.p8)
```

## Adding New Credentials

### Add SSH Key
```bash
pass insert ssh/new-server
# Paste the private key, press Ctrl+D when done
```

### Add Password/Token
```bash
pass insert work/new-api-token
# Enter the token, press Enter
```

### Add Multi-line Credential
```bash
pass insert -m db/new-connection
# Paste the connection string or JSON
# Press Ctrl+D when done
```

## Syncing Changes

Pass automatically commits to Git:
```bash
pass git push    # Push changes
pass git pull    # Pull latest changes
```

## Security Notes

1. **GPG Passphrase Required**: You'll need to enter `CelestialPhoenix2025!Rising` when using pass
2. **GPG_TTY**: Already set in `.zshrc` for proper passphrase prompts
3. **No Plaintext**: Credentials are never stored unencrypted
4. **Temporary Files**: Process substitution `<(pass ...)` creates ephemeral files that auto-delete

## Migration from ~/.ssh

If you still have keys in `~/.ssh`, migrate them:

```bash
# For each private key:
pass insert -m ssh/keyname < ~/.ssh/keyname

# Verify it worked:
pass ssh/keyname

# Remove from ~/.ssh (keep a backup first!):
mv ~/.ssh ~/.ssh.backup
```

## Troubleshooting

### "gpg: decryption failed: No secret key"
Your GPG keys aren't imported:
```bash
gpg --import ~/.password-store/gpg-backup-all-keys.asc
```

### "gpg: public key decryption failed: Inappropriate ioctl for device"
GPG_TTY not set (already in .zshrc, but manually set if needed):
```bash
export GPG_TTY=$(tty)
```

### SSH alias not working
Make sure pass returns the key correctly:
```bash
pass ssh/nuc3  # Should show the private key
```

## References

- [Pass Homepage](https://www.passwordstore.org/)
- [Pass Repository](https://github.com/AnveshJarabani/pass)
- [GPG Backup Guide](../GPG-RESTORE-INSTRUCTIONS.md)
