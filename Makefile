.PHONY: update-plugins verify-plugins upgrade

update-plugins:
	bash scripts/update-plugins.sh

verify-plugins:
	bash scripts/verify-plugins.sh

upgrade: update-plugins verify-plugins
