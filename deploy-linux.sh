#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/VSCode-Config"
VSCODE_CONFIG="$HOME/.config/Code/User"

echo "Deploying VS Code configuration..."

mkdir -p "$VSCODE_CONFIG"

cp -v "$CONFIG_DIR/settings.json" "$VSCODE_CONFIG/"
cp -v "$CONFIG_DIR/keybindings.json" "$VSCODE_CONFIG/"

if [ -d "$CONFIG_DIR/snippets" ]; then
    rm -rf "$VSCODE_CONFIG/snippets"
    cp -rv "$CONFIG_DIR/snippets" "$VSCODE_CONFIG/"
fi

echo "Done."