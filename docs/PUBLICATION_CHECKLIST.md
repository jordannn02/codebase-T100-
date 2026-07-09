# GitHub 公開前檢查清單

發布前請逐項確認。

## 內容邊界

- [ ] README 已說明 `codebase-T100版` 是 T100 領域包裝，不是原 engine 原創。
- [ ] NOTICE 已保留原始專案與社群 fork 歸屬。
- [ ] 未放入任何私人 source、正式 DB 結果、公司文件、會議紀錄或截圖。
- [ ] 範例使用假程式、假欄位或公開可接受的通用代號。
- [ ] 沒有本機絕對路徑，例如 `/Users/...`。
- [ ] 沒有 IP、host、VPN route、帳號、Keychain service 或密碼。

## 授權

- [ ] 如果沒有包含 upstream source，只需保留本 repo 授權與 NOTICE。
- [ ] 如果包含 upstream source，必須保留 upstream MIT License 與 copyright notice。
- [ ] 如果改了 upstream code，必須在 README 或 CHANGELOG 說明修改點。

## 技術檢查

優先跑自動化檢查：

```bash
./scripts/validate-public.sh
```

也可以手動確認：

建議發布前執行：

```bash
rg -n "/Users/|10\\.|172\\.|192\\.168\\.|password|passwd|secret|token|keychain|TCONN|topprd|ENT=|site=" .
```

```bash
find . -type f -maxdepth 4 | sort
```

若需要建立 GitHub repo：

```bash
git init
git add .
git commit -m "Initial public Chinese T100 edition"
```

## Release 檢查

- [ ] `CHANGELOG.md` 已更新。
- [ ] `docs/COMPATIBILITY.md` 已更新。
- [ ] `docs/INSTALL_VERIFY.md` 的 smoke test 仍符合目前 upstream command。
- [ ] `examples/demo-t100/` 不含真實客戶資料。
- [ ] tag 名稱與 `CHANGELOG.md` 一致，例如 `v0.1.0-public-safe-scaffold`。

## 建議 repo 描述

```text
codebase-T100版：面向 T100 / TIPTOP / Genero 4GL 的中文 code graph MCP 工作流包裝，基於上游 codebase-memory-mcp 系列工具的公開安全整理版。
```
