.PHONY: build build-push run help package clean setup verify list-remote count version

DIST_IMAGE := ghcr.io/mrzgamingv20-cyber/ezos:latest
VERSION ?= 3.0

help:
	@echo "EZOS Build Commands"
	@echo ""
	@echo "  make build        - Build EZOS Docker image locally"
	@echo "  make build-push   - Build and push to GHCR"
	@echo "  make run          - Run EZOS container"
	@echo "  make package      - Build all .tar.gz packages from .deb"
	@echo "  make verify       - Verify package checksums"
	@echo "  make list-remote  - List all available packages"
	@echo "  make setup-ezos   - Run EZOS first-boot setup"
	@echo "  make version      - Show EZOS version"
	@echo "  make clean        - Remove generated files"

build:
	docker build -t $(DIST_IMAGE) .

build-push:
	docker buildx build --platform linux/arm64 \
		-t $(DIST_IMAGE) --push .

run:
	docker run -it --rm $(DIST_IMAGE)

setup-ezos:
	docker run -it --rm $(DIST_IMAGE) setup-ezos

version:
	docker run -it --rm $(DIST_IMAGE) ezpkg version

package:
	cd packages && bash build-packages.sh

verify:
	cd packages && bash checksums.sh verify

list-remote:
	docker run -it --rm $(DIST_IMAGE) ezpkg list-remote

count:
	docker run -it --rm $(DIST_IMAGE) ezpkg repo count

clean:
	rm -rf packages/.debs/ packages/*.deb packages/CHECKSUMS.sha256
	rm -f packages/packages-list.gz
	@echo "Cleaned generated files."
