#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_dir="${1:-$repo_root/codex-plugin}"
example_file="$plugin_dir/.mcp.example.json"
target_file="$plugin_dir/.mcp.json"
command_value="${CODEBASE_MEMORY_MCP_COMMAND:-codebase-memory-mcp}"
port_value="${CODEBASE_MEMORY_MCP_PORT:-9749}"

if [[ ! -f "$example_file" ]]; then
  echo "Missing $example_file" >&2
  exit 1
fi

python3 - "$example_file" "$target_file" "$command_value" "$port_value" <<'PY'
import json
import sys
from pathlib import Path

example_path = Path(sys.argv[1])
target_path = Path(sys.argv[2])
command_value = sys.argv[3]
port_value = sys.argv[4]

data = json.loads(example_path.read_text(encoding="utf-8"))
server = data["mcpServers"]["codebase_memory"]
server["command"] = command_value
server["args"] = ["--ui=true", f"--port={port_value}"]
target_path.write_text(
    json.dumps(data, ensure_ascii=False, indent=2) + "\n",
    encoding="utf-8",
)
PY

echo "Generated $target_file"
echo "command=$command_value"
echo "port=$port_value"
