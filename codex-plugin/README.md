# Codex Plugin 範本

這個資料夾是公開安全的 plugin scaffold。

## 初始化

在 repo root 執行：

```bash
./scripts/setup-plugin.sh
```

它會從 `.mcp.example.json` 產生本機用的 `.mcp.json`。

如果 `codebase-memory-mcp` 不在 PATH：

```bash
CODEBASE_MEMORY_MCP_COMMAND=/absolute/path/to/codebase-memory-mcp ./scripts/setup-plugin.sh
```

如果 UI port 9749 被占用：

```bash
CODEBASE_MEMORY_MCP_PORT=9750 ./scripts/setup-plugin.sh
```

## 驗證

```bash
./scripts/validate-public.sh
```

更完整的安裝驗證請看：

```text
docs/INSTALL_VERIFY.md
```

## 注意

- 公開版不附私人 binary。
- 公開版不附正式環境設定。
- 公開版不附 source 索引資料。
- `.mcp.json` 是本機設定檔，已被 `.gitignore` 排除。
- `plugin.json` 仍指向 `./.mcp.json`，所以安裝前要先執行 setup。
