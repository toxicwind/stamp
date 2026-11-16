#!/usr/bin/env bash
# lint-paths.sh — ghost-path lease enforcement for a pen (or all pens).
# FAILs if any file references /home/toxic/pens/Pens (the banned ghost path)
# or if /home/toxic/pens/Pens exists in ANY form. Exit 1 = violation.
# Usage: lint-paths.sh [pen...]   (default: all five pens)
set -u
PENS_DIR="/home/toxic/pens"
PENS="${*:-Pens geode barn ranch olympus}"
fail=0

if [ -e "$HOME/Pens" ]; then
  echo "FAIL: /home/toxic/pens/Pens EXISTS (single-truth lease violation) — remove it and find the re-creator"
  fail=1
fi

for pen in $PENS; do
  hits="$(rg -l --no-ignore --hidden -g '!.git' -g '!node_modules' -g '!vendor*' \
    -g '!qdrant_data' -g '!grafana' -g '!bun.lock' -g '!*.lock' \
    '/home/toxic/pens/Pens' "$PENS_DIR/$pen" 2>/dev/null)"
  if [ -n "$hits" ]; then
    echo "FAIL: $pen references banned ghost path /home/toxic/pens/Pens:"
    echo "$hits" | sed 's/^/  /'
    fail=1
  else
    echo "OK: $pen — no ghost-path refs"
  fi
done
exit $fail
