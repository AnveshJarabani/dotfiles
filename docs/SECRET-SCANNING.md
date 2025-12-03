# 🔐 Secret Scanning & Security

This repository uses automated secret scanning to prevent sensitive data from being committed.

## 🛡️ Protection Layers

### 1. **Pre-commit Hook** (Local)
Scans before you commit:
```bash
# Install the hook
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# Now every commit is scanned automatically!
```

### 2. **GitHub Actions** (Remote)
Scans every push and PR automatically:
- ✅ Gitleaks secret scanner
- ✅ TruffleHog verified secrets
- ✅ Email detection
- ✅ API key/token detection
- ✅ Private key detection
- ✅ Suspicious comment detection

### 3. **Branch Protection** (Recommended)
Set up in GitHub repo settings:
1. Go to Settings → Branches
2. Add rule for `main` branch
3. Require status checks:
   - ✅ `secret-scan`
   - ✅ `sensitive-data-scan`
4. Enable "Require branches to be up to date"

## 🔍 What Gets Scanned

### ❌ Blocked (Will Fail)
- Emails in code (except docs)
- API keys/tokens (GitHub, Jira, AWS, etc.)
- Private keys (SSH, GPG, etc.)
- Hardcoded passwords

### ⚠️ Warned
- Suspicious comments (e.g., `comm: TmuxNavigateLef`)
- TODO/FIXME with sensitive keywords

### ✅ Allowed
- Emails in documentation (`.md` files)
- References to `pass` commands: `$(pass git/personal/email)`
- Example/placeholder values
- Comments in docs

## 🚀 How It Works

### Pre-commit (Local)
```bash
# When you run: git commit

1. Hook runs automatically
2. Scans staged files
3. Checks for secrets
4. ❌ Blocks commit if secrets found
5. ✅ Allows commit if clean
```

### GitHub Actions (Remote)
```bash
# When you: git push or open PR

1. Workflow triggers
2. Runs multiple scanners in parallel
3. Scans entire repository + history
4. ❌ Fails workflow if secrets found
5. 💬 Comments on PR with results
6. 🚫 Blocks merge (if branch protection enabled)
```

## 📝 Configuration Files

- `.github/workflows/secret-scan.yml` - GitHub Actions workflow
- `.gitleaks.toml` - Gitleaks configuration
- `.git-hooks/pre-commit` - Pre-commit hook script

## 🔧 Setup Instructions

### Local Development
```bash
# 1. Install gitleaks (optional but recommended)
brew install gitleaks  # macOS
# or
wget https://github.com/gitleaks/gitleaks/releases/download/v8.18.0/gitleaks_8.18.0_linux_x64.tar.gz
tar -xzf gitleaks_8.18.0_linux_x64.tar.gz
sudo mv gitleaks /usr/local/bin/

# 2. Install pre-commit hook
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# 3. Test it
git add .
git commit -m "test"  # Will be scanned!
```

### GitHub Repository
```bash
# 1. Push these files to your repo
git add .github/workflows/secret-scan.yml .gitleaks.toml
git commit -m "Add secret scanning"
git push

# 2. Enable branch protection (Settings → Branches)
# - Require status checks: secret-scan, sensitive-data-scan
# - Require approvals: 1
# - Enable for administrators: Yes

# 3. Done! All pushes/PRs will be scanned
```

## 🎯 What Happens When Secrets Are Found

### Pre-commit Hook
```bash
❌ PRE-COMMIT FAILED: Secrets detected!

Found emails in staged files:
scripts/bin/git-profile:8:        email = "user@example.com"

Please remove sensitive data before committing.
Use 'pass' to store secrets securely instead.
```

### GitHub Actions
```bash
❌ Security Scan Failed!

⚠️ Secrets or sensitive data detected. Please review:
- Email found in: scripts/bin/git-profile:8
- Token found in: config/api.yml:15

[View Workflow Run](link)
```

### PR Comment
```
❌ Security Scan Failed!

⚠️ Secrets or sensitive data detected. Please review the 
workflow logs and remove any sensitive information before merging.

[View Workflow Run](link)
```

## ✅ Best Practices

### DO ✅
- Store secrets in `pass`: `$(pass git/personal/email)`
- Use PLACEHOLDER in committed configs
- Document examples in `.md` files
- Use env vars loaded from pass

### DON'T ❌
- Hardcode emails in scripts
- Commit API tokens
- Include private keys
- Write passwords in comments

## 🔄 Updating Scanners

### Update Gitleaks Rules
Edit `.gitleaks.toml`:
```toml
[[rules]]
id = "custom-pattern"
description = "My custom secret pattern"
regex = '''mypattern[0-9]+'''
tags = ["custom"]
```

### Update GitHub Actions
Edit `.github/workflows/secret-scan.yml`:
```yaml
- name: 🔍 Custom Scan
  run: |
    grep -r "my-pattern" . || exit 1
```

## 📊 Scan Results

Check scan results:
- **Local**: Terminal output during commit
- **GitHub**: Actions tab → Secret Scan workflow
- **PR**: Automated comment with results

## 🆘 Troubleshooting

### False Positives
Add to `.gitleaks.toml` allowlist:
```toml
[allowlist]
regexes = [
  '''your-false-positive-pattern''',
]
```

### Skip Pre-commit (Emergency Only)
```bash
# NOT RECOMMENDED!
git commit --no-verify -m "message"
```

### Test Scanners Locally
```bash
# Test gitleaks
gitleaks detect --config .gitleaks.toml --verbose

# Test pre-commit hook
.git-hooks/pre-commit
```

## 📚 Resources

- [Gitleaks Documentation](https://github.com/gitleaks/gitleaks)
- [TruffleHog Documentation](https://github.com/trufflesecurity/trufflehog)
- [GitHub Branch Protection](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches)

---

**🔒 Your dotfiles are protected at every step! 🔒**
