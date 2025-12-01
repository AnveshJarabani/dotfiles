# GitHub Copilot Config

This directory contains GitHub Copilot configuration files.

## Sensitive Files (Not Tracked)

The following files contain OAuth tokens and are git-ignored:
- `apps.json` - OAuth tokens for GitHub authentication
- `*.db` - Local database files

## Setup

After stowing this package, you'll need to authenticate GitHub Copilot:
1. Install GitHub Copilot extension in your editor
2. Run authentication through the extension
3. The `apps.json` file will be created automatically with your token

## Tracked Files

- `fallbackContextProviderDocumentSymbols/` - Symbol lookup cache
- `symbolDatabaseLookup.json` - Database lookup configuration
- `versions.json` - Version tracking
