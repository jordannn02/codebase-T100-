---
name: codebase-t100
description: 中文 T100 / TIPTOP / Genero 4GL source tracing workflow for codebase-memory MCP.
---

# codebase-T100版

使用這個 skill 時，先把 codebase-memory MCP 的 graph 結果當作索引輔助，再回 source / schema / runtime 做確認。

## 適用情境

- 查 T100 / TIPTOP 程式影響範圍。
- 查 `.4gl`、`.per`、`csub_*`、標準與客製差異。
- 查表欄位 READS / WRITES / CALLS。
- 查某個參數、狀態碼、欄位改動會影響哪些流程。

## 工作流

1. 收集錨點：程式 ID、表名、欄位、site、ENT、單據或需求描述。
2. 使用 codebase-memory graph 找相關符號、呼叫路徑、欄位使用點。
3. 讀取原始碼片段，確認分支條件、過濾條件、客製覆寫。
4. 必要時再要求 schema、手冊、runtime 或只讀 SQL 證據。
5. 輸出時分清楚 source 已證實、DB 已證實、runtime 已證實、推論、待驗證。

## 輸出規則

- 保留精確錨點：程式名、檔案、函式、表名、欄位、條件。
- 欄位格式使用 `\[欄位名稱](field_code)`。
- 若欄位名稱未確認，寫 `\[欄位名稱待確認](field_code)`。
- 不要把 graph edge 當成最終 ERP 行為結論。
- 不要公開私人 source、正式 DB 結果、內部 host、帳號或單據。

## 建議回答結構

```text
結論：

一、用途 / 角色

二、行為差異 / 影響範圍

三、source 證據

四、DB / runtime 證據

五、待驗證與風險

一句話總結：
```

