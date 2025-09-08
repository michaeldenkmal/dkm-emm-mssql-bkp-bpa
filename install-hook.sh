#!/bin/bash

HOOK_SRC=".githooks/pre-commit"
HOOK_TARGET=".git/hooks/pre-commit"

if [ ! -d ".git/hooks" ]; then
    echo "❌ Kein Git-Repository. Bitte zuerst 'git init' ausführen."
    exit 1
fi

cp "$HOOK_SRC" "$HOOK_TARGET"
chmod +x "$HOOK_TARGET"

echo "✅ Pre-Commit-Hook wurde erfolgreich installiert!"

