# SnowSQL Configuration

This directory contains SnowSQL configuration managed with `pass` for security.

## Setup

1. **Store secrets in pass:**
   ```bash
   pass insert snowsql/username
   pass insert snowsql/qa/accountname
   pass insert snowsql/staging/accountname
   pass insert snowsql/prod/accountname
   ```

2. **Generate config from secrets:**
   ```bash
   ~/.snowsql/generate-config.sh
   ```

3. **Use stow to symlink:**
   ```bash
   cd ~/dotfiles
   stow snowsql
   ```

## Files

- `config.template` - Template with placeholders (version controlled)
- `generate-config.sh` - Script to generate config from pass (version controlled)
- `config` - Generated config with secrets (NOT version controlled, gitignored)

## Usage

Run `generate-config.sh` after any template changes or when setting up on a new machine.
