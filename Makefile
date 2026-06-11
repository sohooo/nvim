.PHONY: airgap-appimage airgap-bundle check-airgap-paths check-external-tools healthcheck migration-status update-plugins verify verify-airgap-appimage verify-airgap-bundle verify-plugins upgrade

airgap-appimage:
	bash scripts/build-airgap-appimage.sh

airgap-bundle:
	bash scripts/build-airgap-bundle.sh

check-external-tools:
	bash scripts/check-external-tools.sh

check-airgap-paths:
	bash scripts/test-airgap-paths.sh

healthcheck:
	bash scripts/healthcheck.sh

migration-status:
	bash scripts/check-migration-status.sh

update-plugins:
	bash scripts/update-plugins.sh

verify-plugins:
	bash scripts/verify-plugins.sh

verify: check-airgap-paths check-external-tools verify-plugins

verify-airgap-bundle:
	@test -n "$(TARBALL)" || { echo "usage: make verify-airgap-bundle TARBALL=dist/nvim-airgap-linux-x86_64-*.tar.gz" >&2; exit 2; }
	bash scripts/verify-airgap-bundle.sh $(TARBALL)

verify-airgap-appimage:
	@test -n "$(APPIMAGE)" || { echo "usage: make verify-airgap-appimage APPIMAGE=dist/nvim-airgap-linux-x86_64.AppImage" >&2; exit 2; }
	bash scripts/verify-airgap-appimage.sh $(APPIMAGE)

upgrade: update-plugins verify
