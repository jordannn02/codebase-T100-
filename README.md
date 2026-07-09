# codebase-T100版

`codebase-T100版` 是面向 T100 / TIPTOP / Genero 4GL 調查工作的中文 code graph MCP 工作流包裝。

它不是一套重新實作的 code graph engine，也不是 upstream 專案改名重發。它的定位是把 `codebase-memory-mcp` / `codebase-memory-mcp-pro` 這類本機 code graph 能力，整理成 T100 顧問、ERP 工程師、內部維運人員可以安裝、驗證、套用的中文 scaffold。

## 使用前提：自備授權的 T100 原始碼

下載這個 repo 不會取得任何 T100 / TIPTOP 原始碼。若要分析真實系統，使用者需要在本機另行準備一份自己有權限使用的私有 T100 source tree。

建議原則：

- 真實 T100 source 放在本 repo 外面，例如 `/path/to/authorized-t100-source`。
- source tree 至少應包含要分析的 `.4gl`、`.per`、客製程式、共用 include / library；若要追完整影響範圍，建議準備接近完整的 AP source mirror。
- 使用 upstream engine 對私有 source 目錄建立 index，再用 `codebase-T100版` 的 prompt / workflow 來分析。
- 不要把真實 T100 source、客戶客製邏輯、正式 DB 輸出、截圖或內部文件 commit 到這個公開 repo。

最小概念流程：

```bash
codebase-memory-mcp cli index_repository '{"repo_path":"/path/to/authorized-t100-source","name":"my-t100","mode":"fast"}'
```

若只想測試安裝與流程，可以直接使用本 repo 內的 synthetic demo，不需要任何真實 T100 source。

## 專案狀態

| 面向 | 狀態 |
|---|---|
| T100 workflow 包裝 | 可用，文件與 prompt 已整理 |
| Codex plugin scaffold | 可用，提供 setup 與驗證腳本 |
| 可執行 demo | 提供合成 4GL / PER 範例與預期調查流程 |
| CI / validation | 提供 GitHub Actions 與本機 validation script |
| 完整 engine | 不包含，請另外安裝 upstream `codebase-memory-mcp` 系列工具 |
| T100 原始碼 | 不包含，需由使用者自行準備授權的私有 source tree |

## 這個工具能做什麼

- 對 T100 / TIPTOP / Genero 4GL 專案套用 code graph source tracing 工作流。
- 幫 AI agent 先用 graph 找程式、函式、表欄位與呼叫路徑，再回原始碼確認。
- 把 ERP 調查輸出整理成顧問式格式：用途、行為差異、source 證據、DB / runtime 證據、待驗證與風險。
- 提供公開安全的 Codex plugin scaffold，不包含私人 source、正式 DB、內部 host 或公司文件。
- 提供 synthetic demo，讓使用者理解裝好後應該怎麼驗證。

## 快速開始

```bash
git clone https://github.com/jordannn02/codebase-T100-.git
cd codebase-T100-
```

先確認本機已安裝 upstream engine：

```bash
codebase-memory-mcp --help
```

初始化 Codex plugin 設定：

```bash
./scripts/setup-plugin.sh
```

執行公開版驗證：

```bash
./scripts/validate-public.sh
```

若你想指定 binary 或 port：

```bash
CODEBASE_MEMORY_MCP_COMMAND=/path/to/codebase-memory-mcp CODEBASE_MEMORY_MCP_PORT=9749 ./scripts/setup-plugin.sh
```

## Demo

此 repo 提供一組合成的 T100-like 範例，不含任何真實客戶資料：

- `examples/demo-t100/source/axmt500_sample.4gl`
- `examples/demo-t100/source/axmt500_sample.per`
- `examples/demo-t100/README.md`

示意調查任務：

```text
請用 codebase-T100版 分析 demo 裡 \[業務人員](xmda002) 與 \[業務部門](xmda003) 的來源、寫入點與待驗證項目。
```

## T100版新增的重點

### T100 / TIPTOP / 4GL 導向

原版 code graph 工具是通用的；T100版把預設使用情境改成 ERP source tracing：

- 程式 ID，例如 `axmt500`、`cxmta41`、`asft311`。
- T100 / TIPTOP 的 `.4gl`、`.per`、客製 `csub_*`、標準與客製差異。
- 表名、欄位代號、狀態碼、site、ENT、單據號等 ERP 錨點。
- 需求、畫面、資料庫、source code 之間的交叉驗證。

### 固定證據階梯

T100版預設不把 graph 查詢結果直接當最終結論：

1. 圖譜先找可能的程式、函式、表、欄位與呼叫路徑。
2. 回到原始碼片段確認實際條件與分支。
3. 必要時再對照 schema、手冊、runtime 畫面或只讀 SQL。
4. 最後輸出時標明哪些是 source 已證實，哪些仍是推論或待驗證。

### 中文顧問式輸出

- 先給結論與影響範圍。
- 保留精確錨點：程式名、檔案、表名、欄位、單據、條件。
- 欄位用可讀格式，例如 `\[客戶編號](xmda004)`。
- 區分「用途」、「行為差異」、「風險」、「待驗證項目」。

## 專案結構

```text
codex-plugin/                  Codex plugin scaffold
docs/                          T100 workflow, compatibility, install verification
examples/demo-t100/            Synthetic 4GL / PER demo
scripts/setup-plugin.sh        Generates codex-plugin/.mcp.json
scripts/validate-public.sh     JSON lint + public-safety scan
.github/workflows/validate.yml CI validation
```

## 相容性

請看 `docs/COMPATIBILITY.md`。目前公開版只依賴 upstream engine 應提供以下介面：

- `codebase-memory-mcp --help`
- `codebase-memory-mcp --ui=true --port=9749`
- MCP tools such as `index_repository`, `search_graph`, `query_graph`, `trace_path`, `get_code_snippet`

若你的 upstream fork command 或 tools 名稱不同，請調整 `codex-plugin/.mcp.json`。

## 與原版的關係

本專案尊重原始專案與社群 fork 的工作成果。

- 原始 engine：`DeusData/codebase-memory-mcp`
- 社群 fork：`win4r/codebase-memory-mcp-pro`
- 授權：原專案採 MIT License

`codebase-T100版` 只主張本 repo 內 T100 領域化文件、中文工作流、plugin scaffold、demo 與公開安全整理方式的新增整理。若未來直接包含 upstream 程式碼，必須保留原始 MIT License、copyright notice、來源連結與修改說明。

## 不適合拿來做什麼

- 不適合宣傳成完整 code graph engine。
- 不適合直接取代工程師 review。
- 不適合只靠 graph 結果就更新正式資料。
- 不適合公開內部 T100 source、正式 DB 查詢結果或客戶客製邏輯。
- 不適合把私有 source tree 放進公開 repo 或任何會被 git 追蹤的位置。

## 版本

目前建議公開標籤：

```text
v0.1.0-public-safe-scaffold
```

詳見 `CHANGELOG.md`。
