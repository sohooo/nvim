.PHONY: airgap-bundle check-external-tools healthcheck migration-status update-plugins verify verify-airgap-bundle verify-plugins upgrade

airgap-bundle:
	bash scripts/build-airgap-bundle.sh

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

verify-airgap-bundle:
	@test -n "$(TARBALL)" || { echo "usage: make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz" >&2; exit 2; }
	bash scripts/verify-airgap-bundle.sh $(TARBALL)

upgrade: update-plugins verify
