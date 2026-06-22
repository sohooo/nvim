.PHONY: airgap-appimage airgap-bundle check-airgap-paths check-doc-links check-external-tools healthcheck lint-shell migration-status update-plugins verify verify-airgap-appimage verify-airgap-bundle verify-healthcheck verify-plugins upgrade

airgap-appimage:
	bash scripts/build-airgap-appimage.sh

airgap-bundle:
	bash scripts/build-airgap-bundle.sh

check-external-tools:
	bash scripts/check-external-tools.sh

check-doc-links:
	bash scripts/check-doc-links.sh

check-airgap-paths:
	bash scripts/test-airgap-paths.sh

healthcheck:
	bash scripts/healthcheck.sh

lint-shell:
	bash scripts/lint-shell.sh

migration-status:
	bash scripts/check-migration-status.sh

update-plugins:
	bash scripts/update-plugins.sh

verify-plugins:
	bash scripts/verify-plugins.sh

verify-healthcheck:
	bash scripts/verify-healthcheck.sh

verify: check-airgap-paths check-doc-links check-external-tools lint-shell verify-healthcheck verify-plugins

verify-airgap-bundle:
	@test -n "$(TARBALL)" || { echo "usage: make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz" >&2; exit 2; }
	bash scripts/verify-airgap-bundle.sh $(TARBALL)

verify-airgap-appimage:
	@test -n "$(APPIMAGE)" || { echo "usage: make verify-airgap-appimage APPIMAGE=dist/nvim-airgap-linux-x86_64.AppImage" >&2; exit 2; }
	bash scripts/verify-airgap-appimage.sh $(APPIMAGE)

upgrade: update-plugins verify
