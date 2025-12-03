# SSH Configuration

This directory contains the SSH config file managed by GNU Stow.

## What's Included

- `config` - SSH client configuration file with all host definitions

## What's NOT Included (Security)

❌ **SSH Private Keys** - Stored securely in `pass` (password manager)
❌ **SSH Public Keys** - Generated from private keys, not in dotfiles
❌ **known_hosts** - Machine-specific, not shared

## Usage

The SSH config uses ssh-agent with keys loaded from pass:

```bash
# Load all SSH keys from pass into ssh-agent
ssh-load

# List loaded keys
ssh-list

# Clear all keys
ssh-clear
```

## Stow

```bash
cd ~/dotfiles
stow ssh
```

This will symlink `~/.ssh/config` to your dotfiles.

## Security Notes

- SSH keys are encrypted in `pass` with GPG
- Keys are loaded into memory (ssh-agent) on demand
- No plaintext keys stored on disk
- Config file is safe to commit (no secrets)
