# Expected Demo Analysis

## Query

```text
請用 codebase-T100版 分析 demo 裡 \[業務人員](xmda002) 與 \[業務部門](xmda003) 的來源、寫入點與待驗證項目。
```

## Expected Direction

- 找到 `examples/demo-t100/source/axmt500_sample.4gl`。
- 找到 `input_sales_owner()` 使用 local variables `l_xmda002` 與 `l_xmda003`，再寫入 `xmda_t.xmda002` 與 `xmda_t.xmda003`。
- 找到 `validate_order_owner()` 檢查 `xmda002` / `xmda003` 不得為空。
- 找到 `examples/demo-t100/source/axmt500_sample.per` 中的 `formonly.xmda002` 與 `formonly.xmda003`。
- 明確標示 demo synthetic，不代表正式 T100 行為。
- DB / runtime 證據必須列為待驗證。

## Graph Search Boundary

2026-07-09 local `dev` build 驗證：

- `index_repository` demo source OK：`nodes=8`、`edges=11`。
- `search_graph` query `axmt500` OK，會回傳 demo functions 與 `xmda_t` table node。
- `search_graph` query `input_sales_owner` OK。
- `search_graph` query `validate_order_owner` OK。
- `search_graph` query `xmda_t` OK。
- `search_graph` query `xmda002` 回傳 0 筆。

因此回答欄位問題時，不應宣稱 graph search 已直接命中 `xmda002` / `xmda003`。正確作法是先用 graph 找到候選程式、function 或 table，再回 source snippet / 原始檔確認欄位讀寫。

## Answer Structure

```text
結論：

一、用途 / 角色

二、行為差異 / 影響範圍

三、source 證據

四、DB / runtime 證據

五、待驗證與風險

一句話總結：
```
