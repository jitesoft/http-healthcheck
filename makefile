ifeq ($(OS),Windows_NT)
    CUR_DIR = $(shell sh -c pwd)
else
    CUR_DIR = CURDIR
endif

.PHONY: alpine win darwin createdir build
ARCHS := amd64 arm64 ppc64le s390x 386


build: createdir $(ARCHS) win darwin
	@echo "Complete!"

win:
	@docker run --rm -v $(CUR_DIR):/go/src/github.com/jitesoft/http-healthcheck jitesoft/go:latest-ubuntu /bin/bash -c 'cd /go/src/github.com/jitesoft/http-healthcheck; GOOS=windows GOARCH=amd64 go build --ldflags="-s -w"'
	@tar -czf bin/http-healthcheck-windows-amd64.tar.gz http-healthcheck.exe
	@echo "Compiled binary for windows - amd64."

darwin:
	@docker run --rm -v $(CUR_DIR):/go/src/github.com/jitesoft/http-healthcheck jitesoft/go:latest-ubuntu /bin/bash -c 'cd /go/src/github.com/jitesoft/http-healthcheck; GOOS=darwin GOARCH=amd64 go build --ldflags="-s -w"'
	@tar -czf bin/http-healthcheck-darwin-amd64.tar.gz http-healthcheck
	@echo "Compiled binary for darwin - amd64."

createdir:
	@rm -rf bin
	@mkdir -p bin

$(ARCHS):
	@docker run --rm -v $(CUR_DIR):/go/src/github.com/jitesoft/http-healthcheck jitesoft/go:latest-ubuntu /bin/bash -c 'cd /go/src/github.com/jitesoft/http-healthcheck; GOARCH=$@ go build --ldflags="-s -w"'
	@tar -czf bin/http-healthcheck-linux-$@.tar.gz http-healthcheck
	@echo "Compiled binary for $@."
	@docker run --rm -v $(CUR_DIR):/go/src/github.com/jitesoft/http-healthcheck jitesoft/go:latest /bin/ash -c 'cd /go/src/github.com/jitesoft/http-healthcheck; GOARCH=$@ go build --ldflags="-s -w"'
	@tar -czf bin/http-healthcheck-linux-musl-$@.tar.gz http-healthcheck
	@echo "Compiled binary for musl - $@."
