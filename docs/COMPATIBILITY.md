# 相容性

`codebase-T100版` 是 workflow scaffold，不綁定特定 upstream binary build。它預期 upstream engine 提供一組穩定的 MCP / CLI 介面。

## 已知上游

| 專案 | 角色 | 備註 |
|---|---|---|
| `DeusData/codebase-memory-mcp` | 原始 engine | code graph MCP 專案 |
| `win4r/codebase-memory-mcp-pro` | 社群 fork | agent-native workflow 與 graph tool 強化 |

## 預期 command 介面

```bash
codebase-memory-mcp --help
codebase-memory-mcp --ui=true --port=9749
```

本 scaffold 預期 help output 會包含或等價支援：

- `--ui=true`
- `--port=N`
- `index_repository`
- `search_graph`
- `query_graph`
- `trace_path`
- `get_code_snippet`
- `get_graph_schema`
- `get_architecture`

## Port

預設 UI port 是 `9749`。

若 port 衝突：

```bash
CODEBASE_MEMORY_MCP_PORT=9750 ./scripts/setup-plugin.sh
```

## `.mcp.json` 與 `.mcp.example.json`

repo 只追蹤 `.mcp.example.json`。實際使用者本機的 `.mcp.json` 由 `scripts/setup-plugin.sh` 產生，並被 `.gitignore` 排除。

這樣做是為了避免把本機絕對路徑、私人 binary path、workspace 設定提交到公開 repo。

## 驗證邊界

本 scaffold 的 CI 只能驗證公開文件、JSON、demo source 與敏感字掃描。它無法驗證使用者本機是否已安裝 upstream engine。

使用者需要自行執行：

```bash
codebase-memory-mcp --help
./scripts/setup-plugin.sh
./scripts/validate-public.sh
```

再依 `examples/demo-t100/README.md` 做端到端測試。
