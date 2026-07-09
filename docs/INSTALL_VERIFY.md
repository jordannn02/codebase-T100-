# 安裝與驗證

這份文件補上最小 smoke test，讓使用者確認 `codebase-T100版` 不只是文件，也能作為可驗證的 Codex / MCP scaffold。

## 1. 確認 upstream engine

`codebase-T100版` 不包含 engine，請先安裝 `codebase-memory-mcp` 或相容 fork。

```bash
codebase-memory-mcp --help
```

至少要看到：

```text
--ui=true
--port=N
index_repository
search_graph
query_graph
trace_path
get_code_snippet
```

## 2. 產生 MCP 設定

```bash
./scripts/setup-plugin.sh
```

這會產生：

```text
codex-plugin/.mcp.json
```

預設內容會使用：

```bash
codebase-memory-mcp --ui=true --port=9749
```

若 binary 不在 PATH：

```bash
CODEBASE_MEMORY_MCP_COMMAND=/absolute/path/to/codebase-memory-mcp ./scripts/setup-plugin.sh
```

## 3. 驗證 repo scaffold

```bash
./scripts/validate-public.sh
```

驗證項目包含：

- `plugin.json` 合法 JSON。
- `.mcp.example.json` 合法 JSON。
- 沒有未替換的 repo owner 佔位字串。
- 沒有常見私人路徑、host、credential pattern。
- demo source 存在。

## 4. 啟動 MCP UI

```bash
codebase-memory-mcp --ui=true --port=9749
```

再開：

```text
http://127.0.0.1:9749/
```

如果 9749 被占用，改用其他 port，並重新產生 `.mcp.json`：

```bash
CODEBASE_MEMORY_MCP_PORT=9750 ./scripts/setup-plugin.sh
```

## 5. 用 demo 做端到端檢查

請看：

```text
examples/demo-t100/README.md
```

demo 只使用合成 `.4gl` / `.per`，用來驗證流程，不代表任何真實 T100 客製邏輯。

如果 upstream CLI schema 與本 scaffold 相容，可以嘗試：

```bash
make demo-index
make demo-search
```

本 repo 的 `make demo-search` 使用已驗證可回傳結果的 `axmt500` query。欄位 token 例如 `xmda002` 仍需要回 source snippet 或原始檔確認；不要把 graph search 0 筆解讀成欄位不存在。

如果你的 upstream fork CLI schema 不同，可以先看：

```bash
make demo-note
```

## 6. 確認 Codex / agent 讀到 plugin

在 Codex 內使用 `codebase-T100版` 或 `codebase-t100` 相關 prompt 時，應該看到 agent 先使用 codebase-memory graph，再回 source 做確認。

最小驗證 prompt：

```text
請用 codebase-T100版 分析 examples/demo-t100/source 裡 xmda002 的來源與寫入點。
```

預期行為：

- 先找 demo source。
- 說明 `xmda002` 是合成欄位示例。
- 區分 graph / source / 待驗證；欄位命中需回原始檔或 source snippet 確認。
- 不宣稱 demo 等同真實 T100 行為。
