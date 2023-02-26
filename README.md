# Docker Images

These images are based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding a non-root user and basic dependencies needed for most Django / Python Vue projects. The images are designed to be light, yet complete and secure enough **for production**.

The images are regularly re-built to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with [Traefik](https://traefik.io/) + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

## Features

- Slimmer than `python-slim`
- Built for **amd64 and arm64 platforms**
- Python-related environment variables and paths set
- Latest `pip` + essential system packages preinstalled
- Non-root user
- Python built with PGO + Link-Time-Optimization flags
- Based on Debian 11.6 (bullseye) base image

See `sripts/` for details of the actual preinstalled packages.

## Images

| Name                      | Description                                                                                                        |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------ |
| `python`                  | Python, build tools, PosgreSQL dependencies. Designed for Django.                                                  |
| `python-postgis`          | Python, build tools, PosgreSQL + PostGIS dependencies. Designed for Django + GeoDjango.                            |
| `python-postgis-node `    | Python, build tools, PosgreSQL + PostGIS dependencies, and Node 18 + pnpm. Designed for CI / testing environments. |
| `python-postgis-node-dev` | Development image based on `python-postgis-node` with git + dev packages added. Designed for developing + testing. |

## Using

Use one of the following image sources:

- `registry.gitlab.com/uninen/docker-images/python:3.11`
- `registry.gitlab.com/uninen/docker-images/python-postgis:3.11`
- `registry.gitlab.com/uninen/docker-images/python-postgis-node:3.11`
- `registry.gitlab.com/uninen/docker-images/python-postgis-node-dev:latest`

See `py-test-app/` for example usage in a project.

## Building

### python (tags: 3.10, 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.11 --provenance false --push .
```

### python-postgis (tags: 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-postgis-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis:3.11 --provenance false --push .
```

### python-postgis-node (tags: 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis-node:3.11 --provenance false --push .
```

### python-postgis-node-dev (tags: latest)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-dev.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis-node-dev:latest --provenance false --push .
```

## TODO

- Figure out build cache issue to be able to use caching w/ non-root images (see [./py-test-app/Dockerfile](./py-test-app/Dockerfile))
- Add base images to separate audio-related packages

## License

[MIT](./LICENCE)

---

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)
