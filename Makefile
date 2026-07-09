.PHONY: init validate smoke

init:
	./scripts/setup-plugin.sh

validate:
	./scripts/validate-public.sh

smoke:
	codebase-memory-mcp --help
	codebase-memory-mcp --ui=true --port=9749 --help
