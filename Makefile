.PHONY: update-deps

MODULES := $(shell find . -name go.mod -exec dirname {} \;)

update-deps:
	@for module in $(MODULES); do \
		echo "Fetching dependencies for $$module"; \
		cd $$module && go get -u && go get -u all && go mod tidy; \
		cd - > /dev/null; \
	done

.PHONY: set-precommit-hooks
set-precommit-hooks:
	chmod ug+x .githooks/pre-commit && command -v git >/dev/null && git config core.hooksPath .githooks || true
