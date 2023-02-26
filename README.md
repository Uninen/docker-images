# Docker Images

These images are designed for Django / Python / Vue stack, and for audio-relate

designed to be as light as possible, yet complete and secure enough **for production** to make the build process and testing as fast as possible.

The images are regularly re-built (automatically every first Tuesday of the month + manually every now and then) to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with Traefik + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic system security updates in production.

Contributions welcome!

## Features

- Based on Debian 11.6 (bullseye) base image
- Slimmer than `python-slim`
- Python built with PGO + Link-Time-Optimization flags
- Non-root user
- Python-related environment variables and paths set
- Latest `pip` + essential system packages preinstalled
- Built for linux/amd64 and linux/arm64 platforms

See `sripts/` for details of the actual preinstalled packages.

## Images

These images are based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding non-root user, and basic dependencies needed for most Django projects.

| Name                       | Description                                                                                                            | Size         |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ------------ |
| `python:3.10`              | Python with build tools and PosgreSQL dependencies. Designed for Django.                                               | ~176&nbsp;Mb |
| `python-postgis:3.11`      | Python with build tools, and PosgreSQL + PostGIS dependencies. Designed for Django + GeoDjango.                        | ~234&nbsp;Mb |
| `python-postgis-node:3.11` | Python with build tools, PosgreSQL + PostGIS dependencies, and Node 18 + pnpm. Designed for CI / testing environments. | ~280&nbsp;Mb |
| `python-postgis-node-dev`  | Development image based on `python-postgis-node` with git + dev packages added. Designed for developing + testing.     | ~451&nbsp;Mb |

## Using

Use one of the following image sources:

- `registry.gitlab.com/uninen/docker-images/python:3.10`
- `registry.gitlab.com/uninen/docker-images/python-postgis:3.11`
- `registry.gitlab.com/uninen/docker-images/python-postgis-node:3.11`
- `registry.gitlab.com/uninen/docker-images/python-postgis-node-dev:latest`

See `py-test-app/` for example usage in a project.

## Building

### python

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.11 --provenance false --push .
```

### python-postgis

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-postgis-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis:3.11 --provenance false --push .
```

### python-postgis-node

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-3.11.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis-node:3.11 --provenance false --push .
```

### python-postgis-node-dev

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-dev.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis-node-dev:latest --provenance false --push .
```

## TODO

- Figure out build cache issue to be able to use caching w/ non-root images (see [./py-test-app/Dockerfile](./py-test-app/Dockerfile))

## License

[MIT](./LICENCE)

---

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)
