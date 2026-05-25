.PHONY: check-external-tools healthcheck migration-status update-plugins verify verify-plugins upgrade

check-external-tools:
	bash scripts/check-external-tools.sh

healthcheck:
	bash scripts/healthcheck.sh

migration-status:
	bash scripts/check-migration-status.sh

update-plugins:
	bash scripts/update-plugins.sh

verify-plugins:
	bash scripts/verify-plugins.sh

verify: check-external-tools verify-plugins

upgrade: update-plugins verify
