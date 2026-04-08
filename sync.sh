#!/bin/bash
# Obsidian vault daily sync — commits and pushes any changes
set -euo pipefail

VAULT_DIR="/opt/obsidian-vault"
cd "$VAULT_DIR"

# Pull first to avoid conflicts
git pull --rebase origin main 2>/dev/null || true

# Check for changes
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    echo "$(date -u '+%Y-%m-%d %H:%M UTC') — No changes to sync"
    exit 0
fi

# Stage everything and commit
git add -A
TIMESTAMP=$(date -u '+%Y-%m-%d %H:%M UTC')
git commit -m "Vault sync — $TIMESTAMP"
git push origin main

echo "$TIMESTAMP — Synced and pushed"
