# Http-HealthCheck

A simple program written in Go to allow healtchecks against a http endpoint.  
To pass URI to the target, supply the uri as the first argument on invocation:

```bash
./http-healtcheck https://jitesoft.com
```

In case the page have an error (500) the call will exit with exit code 1, in case it does not have a 500 error, it will
exit with exit code 0.  
To specify a specific set of acceptable status codes, supply a go-compatible regular expression as the second argument:

```bash
./http-healtcheck https://jitesoft.com [2]{1}[0-9]{2} # Only accept 2xx responses!
```

The default regexp test is: `[2-4]{1}[0-9]{2}` which allows for any 2xx - 4xx page (just checking so that the server responds on http queries).

## Development

Clone, there are no dependencies, so just go!

## Building

The supplied makefile will (by invoking docker) build the binaries for linux, windows and darwin. The linux and darwin
binaries are only built in amd64 version, while the linux binaries are built for amd64, arm64, ppc64le, s390x and 386 for
both standard linux and linux distros using musl (like alpine linux). Binaries will be placed in the `bin` directory
and are named as following: `http-healthcheck-<OS>(-musl)-<ARCH>(.ext?)`.

Examples:

```
bin/http-healthcheck-windows-amd64.exe
bin/http-healthcheck-linux-arm64
bin/http-healthcheck-linux-musl-s390x
bin/http-healthcheck-dawrin-amd64
```