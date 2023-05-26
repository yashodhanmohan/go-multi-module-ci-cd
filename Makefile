.PHONY: update-deps

MODULES := $(shell find . -name go.mod -exec dirname {} \;)
REPO_ROOT := "github.com/yashodhanmohan/go-multi-module-ci-cd"

update-deps:
	@for module in $(MODULES); do \
		echo "Fetching dependencies for $$module"; \
		cd $$module && go get -u && go get -u all && go mod tidy; \
		cd - > /dev/null; \
	done

.PHONY: set-precommit-hooks
set-precommit-hooks:
	chmod ug+x .githooks/pre-commit && command -v git >/dev/null && git config core.hooksPath .githooks || true

.PHONY: local-overrides
local-overrides:
	@for package in packages/*; do \
		if [ -d "$$package" ]; then \
			echo "Processing package: $$package"; \
			for folder in packages/*; do \
				if [ -d "$$folder" ] && [ "$${folder%/}" != "$$package" ]; then \
					echo "Processing folder: $$folder and replacing package $$package" && \
					 echo =$(REPO_ROOT)/packages/$$package=../$$package \
				fi \
			done \
		fi \
	done