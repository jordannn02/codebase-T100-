#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 -m json.tool codex-plugin/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool codex-plugin/.mcp.example.json >/dev/null

if [[ -f codex-plugin/.mcp.json ]]; then
  python3 -m json.tool codex-plugin/.mcp.json >/dev/null
fi

tracked_files="$(mktemp)"
trap 'rm -f "$tracked_files"' EXIT

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git ls-files >"$tracked_files"
else
  find . -type f \
    ! -path './.git/*' \
    ! -path './codex-plugin/.mcp.json' \
    | sed 's#^\./##' >"$tracked_files"
fi

placeholder="YOUR""_ORG"
if xargs grep -n "$placeholder" <"$tracked_files"; then
  echo "Found repo owner placeholder" >&2
  exit 1
fi

secret_pattern='/Users/wangyukai|10\.211|10\.0|t100erp|tiptop@|dsdata|codex-taikang|BAQ_|ZS-|password\s*=|passwd\s*=|secret\s*=|token\s*='

filtered_files="$(mktemp)"
trap 'rm -f "$tracked_files" "$filtered_files"' EXIT

grep -v -E '^(scripts/validate-public.sh|docs/PUBLICATION_CHECKLIST.md)$' "$tracked_files" >"$filtered_files"

if xargs grep -n -E "$secret_pattern" <"$filtered_files"; then
  echo "Public-safety scan found a blocked pattern" >&2
  exit 1
fi

test -f examples/demo-t100/source/axmt500_sample.4gl
test -f examples/demo-t100/source/axmt500_sample.per

echo "validation ok"
