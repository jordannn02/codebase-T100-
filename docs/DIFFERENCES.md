# 與原版不同的地方

這份差異說明的目的，是清楚標示 `codebase-T100版` 的新增價值與上游來源，避免讓人誤解成抄襲或冒名。

## 原版重點

原始 `codebase-memory-mcp` / `codebase-memory-mcp-pro` 是通用 code intelligence MCP 工具：

- 本機索引程式碼。
- 建立 code graph。
- 搜尋函式、類別、呼叫鏈、路由與架構關係。
- 提供 MCP tools 給 AI coding agent 使用。
- 提供 graph visualization UI。

## T100版重點

T100版把通用能力轉成 ERP 調查工作流：

| 面向 | 原版 | codebase-T100版 |
|---|---|---|
| 使用者 | 通用 AI coding agent 使用者 | T100 顧問、ERP 工程師、內部維運 |
| 語言與文件 | 英文為主 | 中文說明與中文 prompt |
| 領域 | 通用程式碼 | T100 / TIPTOP / Genero 4GL / PER |
| 輸出 | code graph 查詢結果 | 顧問式影響分析與工程交接格式 |
| 證據 | 圖譜與 source 為主 | graph + source + schema + runtime + SQL 分層 |
| 安全邊界 | 通用開源專案 | 明確排除客戶資料、正式 DB、內部路徑 |

## 本版新增內容

- T100 evidence ladder：先 graph，再 source，再 schema / runtime / SQL。
- T100 欄位呈現規則：`\[欄位名稱](field_code)`。
- T100 影響分析格式：用途、行為差異、風險、待驗證項目。
- 中文 plugin skill 範本。
- 公開前檢查清單。
- 非抄襲與上游歸屬說明。

## 本版沒有宣稱的事

- 沒有宣稱原始 code graph engine 是本版作者原創。
- 沒有移除原作者歸屬。
- 沒有把上游 repo 改名後重新發布成自己的原創作品。
- 沒有公開私人 T100 source 或客戶資料。

