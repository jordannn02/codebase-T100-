.PHONY: init validate smoke demo-index demo-search demo-note

init:
	./scripts/setup-plugin.sh

validate:
	./scripts/validate-public.sh

smoke:
	codebase-memory-mcp --help
	codebase-memory-mcp --version

demo-index:
	codebase-memory-mcp cli index_repository '{"repo_path":"examples/demo-t100/source","name":"codebase-t100-demo","mode":"fast"}'

demo-search:
	codebase-memory-mcp cli search_graph '{"project":"codebase-t100-demo","query":"axmt500"}'

demo-note:
	@echo "Demo index/search depends on upstream CLI schema."
	@echo "demo-search uses axmt500 because it is verified on the local dev build."
	@echo "Field-token graph search such as xmda002 may return 0; confirm fields from source snippets."
	@echo "See examples/demo-t100/README.md and examples/demo-t100/expected-output.md."
