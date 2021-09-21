.PHONY: help

help: ## Print command list
	@perl -nle'print $& if m{^[a-zA-Z0-9_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

_prepare:
	@git submodule update --init --recursive

bootstrap: _prepare dotfiles _bootstrap macos

_bootstrap:
	@./install -c config/bootstrap.conf.yml

dotfiles:
	@./install

macos:
	@./etc/macos

brew:
	@./install -c config/packages.conf.yml

update:
	@make _prepare
	@./install -c config/update.conf.yml
