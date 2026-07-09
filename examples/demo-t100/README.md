# Synthetic T100 Demo

這是一組公開安全、合成的 T100-like demo。它只用來展示 `codebase-T100版` 的調查流程，不代表任何真實 T100 標準程式或客製程式。

## Source

```text
examples/demo-t100/source/axmt500_sample.4gl
examples/demo-t100/source/axmt500_sample.per
```

## 目標問題

```text
請分析 demo 裡 \[業務人員](xmda002) 與 \[業務部門](xmda003) 的來源、寫入點與待驗證項目。
```

## 若 upstream CLI 支援單次 tool 呼叫

可先嘗試建立 demo index：

```bash
codebase-memory-mcp cli index_repository '{"repo_path":"examples/demo-t100/source","name":"codebase-t100-demo","mode":"fast"}'
```

再搜尋已驗證的 demo program / function / table：

```bash
codebase-memory-mcp cli search_graph '{"project":"codebase-t100-demo","query":"axmt500"}'
codebase-memory-mcp cli search_graph '{"project":"codebase-t100-demo","query":"input_sales_owner"}'
codebase-memory-mcp cli search_graph '{"project":"codebase-t100-demo","query":"xmda_t"}'
```

注意：在 2026-07-09 本機 `dev` build 驗證時，`search_graph` 查 `xmda002` 回傳 0 筆。這不代表 source 沒有該欄位，只代表該 upstream graph search 不保證欄位 token 可直接檢索。欄位證據仍應回到 source snippet 或原始檔確認。

不同 upstream fork 的 CLI JSON schema 可能不同；若 CLI 不支援，請改由 Codex / MCP tool 呼叫 `index_repository` 與 `search_graph`。

## 預期分析方向

1. 找到 `axmt500_sample.4gl`。
2. 找到 `input_sales_owner()` 使用 local variables `l_xmda002` / `l_xmda003`，再寫入 `xmda002` 與 `xmda003`。
3. 找到 `validate_order_owner()` 檢查兩欄不得空白。
4. 找到 `axmt500_sample.per` 的 `formonly.xmda002` 與 `formonly.xmda003`。
5. 回到 source 說明 demo 是 synthetic，不代表正式 T100 標準行為。
6. 把 DB / runtime 證據列為待驗證，而不是直接宣稱已證實。

更完整的預期分析請看：

```text
examples/demo-t100/expected-output.md
```

## 預期輸出格式

```text
結論：

一、用途 / 角色

二、行為差異 / 影響範圍

三、source 證據

四、DB / runtime 證據

五、待驗證與風險

一句話總結：
```
