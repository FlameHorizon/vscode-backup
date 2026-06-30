#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/VSCode-Config"
VSCODE_CONFIG="$HOME/.config/Code/User"

echo "Backing up VS Code configuration..."

mkdir -p "$CONFIG_DIR"

cp -v "$VSCODE_CONFIG/settings.json" "$CONFIG_DIR/"
cp -v "$VSCODE_CONFIG/keybindings.json" "$CONFIG_DIR/"

if [ -d "$VSCODE_CONFIG/snippets" ]; then
    rm -rf "$CONFIG_DIR/snippets"
    cp -rv "$VSCODE_CONFIG/snippets" "$CONFIG_DIR/"
fi

echo "Done."