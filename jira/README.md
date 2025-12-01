# Jira CLI Configuration

This directory contains configuration for the [Jira CLI](https://github.com/ankitpokhrel/jira-cli).

## Setup

1. Install the Jira CLI tool
2. Copy the template:
   ```bash
   cp .config/.jira/.config.yml.template .config/.jira/.config.yml
   ```
3. Edit `.config.yml` with your Jira details:
   - Your email address
   - Your organization's Atlassian URL
   - Your project key and board ID
4. Authenticate with Jira (the CLI will prompt for API token)

## Note

The actual `.config.yml` file is git-ignored to protect your credentials and company-specific configuration.
