# Changelog

## v0.1.0-public-safe-scaffold - 2026-07-09

第一個公開安全 scaffold 版本。

### Added

- 中文 README，明確說明 `codebase-T100版` 是 T100 工作流包裝，不是完整 engine。
- Codex plugin scaffold。
- `scripts/setup-plugin.sh` 自動產生 `codex-plugin/.mcp.json`。
- `scripts/validate-public.sh` 做 JSON lint、佔位符檢查與公開安全掃描。
- GitHub Actions validation workflow。
- Synthetic T100-like demo source：`.4gl` 與 `.per`。
- Demo expected-output note.
- 安裝驗證文件：`docs/INSTALL_VERIFY.md`。
- 相容性文件：`docs/COMPATIBILITY.md`。
- Compatibility Tested Matrix.

### Changed

- Demo `.4gl` now uses local variable names `l_xmda002` / `l_xmda003` to avoid confusing column-vs-variable assignments.
- Public-safety scan pattern is aligned more closely with `docs/PUBLICATION_CHECKLIST.md`.
- `Makefile` includes optional `demo-index`, `demo-search`, and `demo-note` targets; `demo-search` uses the verified `axmt500` query.
- Compatibility docs now record the field-token graph search boundary for `xmda002`.

### Boundaries

- 不包含 upstream engine source。
- 不包含私人 T100 source、正式 DB 結果、公司文件、截圖、host route 或 credential。
- 不把 graph 查詢結果當成 ERP 行為最終證據。
