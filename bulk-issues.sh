#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI 'gh' is required. https://cli.github.com/" >&2
  exit 2
fi

if [ $# -lt 2 ]; then
  echo "Usage: $0 owner/repo issues.csv" >&2
  exit 2
fi

REPO="$1"
CSV="$2"
IFS=$'\n'
tail -n +2 "$CSV" | while read -r line; do
  title=$(echo "$line" | cut -d',' -f1)
  body=$(echo "$line" | cut -d',' -f2- | sed 's/\\n/\n/g')
  labels=""
  if [[ "$title" == *"|"* ]]; then
    labels=$(echo "$title" | cut -d'|' -f2)
    title=$(echo "$title" | cut -d'|' -f1)
  fi
  if [ -n "$labels" ]; then
    gh issue create -R "$REPO" -t "$title" -b "$body" -l "$labels"
  else
    gh issue create -R "$REPO" -t "$title" -b "$body"
  fi
done
