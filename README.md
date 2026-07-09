# codebase-T100版

`codebase-T100版` 是一個面向 T100 / TIPTOP / Genero 4GL 專案的本機程式碼圖譜分析工具包裝版。

它的底層概念來自開源的 `codebase-memory-mcp` / `codebase-memory-mcp-pro`：把程式碼索引成本機 knowledge graph，讓 AI agent 可以用 MCP 工具查詢函式、類別、呼叫關係、資料流、路由、架構分層與影響範圍。

本版不是要取代或冒充原專案；重點是把那套 codebase graph 能力整理成適合 T100 顧問、ERP 工程師與內部維運人員使用的中文工作流。

## 這個工具能做什麼

- 對大型程式庫建立本機程式碼圖譜，不需要把 source 上傳到外部服務。
- 搜尋程式、函式、類別、變數、路由、表欄位相關符號。
- 追呼叫關係：誰呼叫誰、某個功能改了會影響哪些上游或下游。
- 查資料流與跨服務關係，輔助判斷參數、欄位、狀態碼的影響範圍。
- 用 Cypher 類查詢做更精準的圖譜分析，例如找高複雜度函式、熱點、跨檔案依賴。
- 讀取原始碼片段與附近上下文，減少 AI agent 盲目逐檔搜尋。
- 開啟本機 graph UI，視覺化檢查程式節點與關係。

## T100版新增的重點

`codebase-T100版` 的改良重點不在「重寫原本的引擎」，而是在「把原本的 code graph 能力變成 T100 可落地使用的調查流程」。

### 1. T100 / TIPTOP / 4GL 導向

原版是通用程式碼圖譜工具；T100版把預設使用情境改成 ERP source tracing：

- 程式 ID，例如 `axmt500`、`cxmta41`、`asft311`。
- T100 / TIPTOP 的 `.4gl`、`.per`、客製 `csub_*`、標準與客製差異。
- 表名、欄位代號、狀態碼、site、ENT、單據號等 ERP 錨點。
- 需求、畫面、資料庫、source code 之間的交叉驗證。

### 2. 固定的證據階梯

T100版預設不把 graph 查詢結果直接當最終結論，而是要求分層驗證：

1. 圖譜先找可能的程式、函式、表、欄位與呼叫路徑。
2. 回到原始碼片段確認實際條件與分支。
3. 必要時再對照 schema、手冊、runtime 畫面或只讀 SQL。
4. 最後輸出時標明哪些是 source 已證實，哪些仍是推論或待驗證。

### 3. 中文顧問式輸出

T100版的回答格式偏向工程交接與顧問調查：

- 先給結論與影響範圍。
- 保留精確錨點：程式名、檔案、表名、欄位、單據、條件。
- 欄位用可讀格式，例如 `\[客戶編號](xmda004)`。
- 區分「用途」、「行為差異」、「風險」、「待驗證項目」。

### 4. Codex plugin / skill 包裝

本公開版提供一份乾淨的 Codex plugin 範本，讓使用者可以把本機已安裝的 `codebase-memory-mcp` 接成 `codebase-T100版` 工作流。

範本只描述公開流程，不包含私人主機、正式資料庫、公司 source、密碼、Keychain service 或內部單據。

### 5. 公開安全邊界

本版特別把「能公開」與「不能公開」分清楚：

- 可以公開：中文說明、T100 調查方法、通用範例 prompt、plugin scaffold。
- 不應公開：客戶 source、正式 DB 連線、內部單據、公司名稱對照、IP、帳號、密碼、截圖、transcript。

## 與原版的關係

本專案尊重原始專案與社群 fork 的工作成果。

- 原始引擎：`DeusData/codebase-memory-mcp`
- 社群 fork：`win4r/codebase-memory-mcp-pro`
- 授權：原專案採 MIT License

`codebase-T100版` 的定位是「T100 領域化包裝與中文工作流」，不是宣稱原始 engine、索引器、graph UI 或 MCP 核心工具為本專案原創。

如果未來這個 repo 直接包含任何 upstream 程式碼，必須保留原始 MIT License、copyright notice、來源連結與修改說明。

## 快速使用方式

先安裝或建置原本的 `codebase-memory-mcp` / `codebase-memory-mcp-pro`，確認本機可以執行：

```bash
codebase-memory-mcp --help
```

再把本 repo 的 `codex-plugin/` 範本複製到你的 Codex plugin 安裝位置，並依照你的本機 binary 路徑調整 `.mcp.example.json`。

啟動 MCP 後，可用這類中文任務：

```text
請用 codebase-T100版 查 axmt500 的訂單來源欄位，列出相關 4GL、表名、欄位與呼叫路徑。
```

```text
請追 cxmta41 裡 xmeyuc020 的計算邏輯，先用 graph 找路徑，再用原始碼片段驗證。
```

```text
請分析 asft311 若要先進先出，可能需要看哪些批號日期欄位與相關程式。
```

## 不適合拿來做什麼

- 不適合直接取代工程師 review。
- 不適合只靠 graph 結果就更新正式資料。
- 不適合公開內部 T100 source 或 DB 查詢結果。
- 不適合把客戶客製邏輯當成通用標準功能對外宣稱。

## 公開版狀態

目前這份 repo 是「公開安全整理版」：

- 已提供中文 README。
- 已提供 T100 工作流文件。
- 已提供 plugin scaffold。
- 已提供公開前檢查清單。
- 未包含 upstream engine source。
- 未包含任何私人正式環境資訊。

