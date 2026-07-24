#!/usr/bin/env nix-shell
#!nix-shell -p _1password-cli bash -i bash

set -euo pipefail

SSH_KEY_PATH="$HOME/.ssh/id_ed25519"

op account add \
  --address appsilon.1password.com \
  --email pawel.chabros@appsilon.com
eval "$(op signin --account appsilon.1password.com)"

mkdir -p "$(dirname "$SSH_KEY_PATH")"
op read 'op://Employee/id_ed25519/private key' >"$SSH_KEY_PATH"
chmod 600 "$SSH_KEY_PATH"

./rebuild
