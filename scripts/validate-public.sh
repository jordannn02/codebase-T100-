#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

python3 -m json.tool codex-plugin/.codex-plugin/plugin.json >/dev/null
python3 -m json.tool codex-plugin/.mcp.example.json >/dev/null

if [[ -f codex-plugin/.mcp.json ]]; then
  python3 -m json.tool codex-plugin/.mcp.json >/dev/null
fi

placeholder="YOUR""_ORG"

if grep -R -n "$placeholder" \
  --exclude='validate-public.sh' \
  --exclude-dir='.git' .; then
  echo "Found repo owner placeholder" >&2
  exit 1
fi

secret_pattern='/Users/wangyukai|10\.211|10\.0|t100erp|tiptop@|dsdata|codex-taikang|BAQ_|ZS-|password\s*=|passwd\s*=|secret\s*=|token\s*='

if command -v rg >/dev/null 2>&1; then
  if rg -n "$secret_pattern" \
    --glob '!scripts/validate-public.sh' \
    --glob '!docs/PUBLICATION_CHECKLIST.md' \
    --glob '!codex-plugin/.mcp.json' \
    --glob '!.git/**' .; then
    echo "Public-safety scan found a blocked pattern" >&2
    exit 1
  fi
else
  if grep -R -n -E "$secret_pattern" \
    --exclude='validate-public.sh' \
    --exclude='PUBLICATION_CHECKLIST.md' \
    --exclude='.mcp.json' .; then
    echo "Public-safety scan found a blocked pattern" >&2
    exit 1
  fi
fi

test -f examples/demo-t100/source/axmt500_sample.4gl
test -f examples/demo-t100/source/axmt500_sample.per

echo "validation ok"
