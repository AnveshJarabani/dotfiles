# 🔐 Secret Scanning Enabled!

This repository automatically scans for secrets and sensitive data.

## ⚡ Quick Setup

```bash
# Install pre-commit hook (local protection)
cp .git-hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

# That's it! Now every commit is scanned.
```

## 🛡️ Protection Enabled

✅ **Pre-commit Hook** - Scans before you commit (local)  
✅ **GitHub Actions** - Scans every push/PR (remote)  
✅ **Branch Protection** - Blocks merge if secrets found  

## 📚 Full Documentation

See [docs/SECRET-SCANNING.md](docs/SECRET-SCANNING.md) for complete details.

---

**No secrets will ever reach your public repo!** 🚀
