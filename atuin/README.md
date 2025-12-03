# Atuin - Shell History Management

Magical shell history with sync, search, and statistics.

## What's Included

- `config.toml` - Atuin configuration
- `themes/onedark.toml` - OneDark color theme
- `ALIASES.md` - Quick reference for all shell aliases

## Features

✅ **Encrypted sync** - History syncs across machines  
✅ **Fuzzy search** - Ctrl+R for powerful search  
✅ **Context-aware** - Filter by directory, session, or global  
✅ **Statistics** - See most used commands  
✅ **Private** - Encrypted with your key  

## Usage

```bash
# Search history (configured as Ctrl+R)
<Ctrl+R>

# List all history
atuin history list

# Get last command
atuin history last

# Show stats
atuin stats

# Sync history
atuin sync

# Search for specific command
<Ctrl+R> then type to filter
```

## Key Bindings

- `Ctrl+R` - Open Atuin search
- `Enter` - Execute selected command
- `Tab` - Edit command before executing
- Arrow keys - Navigate results
- `Esc` - Cancel search

## Filter Modes

- **Global** - Search all history
- **Host** - Filter by current machine
- **Session** - Current shell session only
- **Directory** - Commands run in current dir
- **Workspace** - Commands in current git repo

## Configuration Highlights

```toml
# Auto-accept on Enter
enter_accept = true

# OneDark theme
theme.name = "onedark"

# Sync enabled (v2)
sync.records = true
```

## Sync Setup

```bash
# Register account
atuin register -u <username> -e <email>

# Login
atuin login -u <username>

# Sync
atuin sync
```

## Alias Reference

See [ALIASES.md](./ALIASES.md) for a complete list of all shell aliases that you can search for in Atuin.

## Tips

1. **Use fuzzy search** - Type any part of the command
2. **Filter by context** - Use directory/session filters
3. **Check stats** - `atuin stats` shows most used commands
4. **Sync regularly** - History auto-syncs on new commands
5. **Tab to edit** - Hit Tab instead of Enter to modify command

## Stow

```bash
cd ~/dotfiles
stow atuin
```

This will symlink `~/.config/atuin/` to your dotfiles.

## Documentation

- [Official Documentation](https://atuin.sh)
- [GitHub Repository](https://github.com/atuinsh/atuin)
- [Alias Reference](./ALIASES.md)

---

*Last updated: 2025-12-03*
