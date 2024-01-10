# Docker Images

These images are based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding a non-root user and basic dependencies needed for most Django / Python / Node projects. The images are designed to be light, yet complete and secure enough **for production**.

The images are regularly re-built to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with [Traefik](https://traefik.io/) + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

## Features

- Slimmer than `python` base images but still include production deps
- Built for **linux/amd64 and linux/arm64 platforms**
- Latest `pip`, `pip-tools`, PostgreSQL 16 client and essential system packages preinstalled
- Non-root `duser` user added (homet at `/home/duser/`)
- Python-related environment variables and paths set
- Python built with PGO + Link-Time-Optimization flags
- Based on Debian 12 (bookworm) base image

See [sripts/](scripts/) for details of the actual preinstalled packages.

## Images

| Name                      | Description                                                                |
| ------------------------- | -------------------------------------------------------------------------- |
| `python`                  | Python, build tools, PosgreSQL dependencies.                               |
| `python-postgis`          | Python, build tools, PosgreSQL + PostGIS dependencies.                     |
| `python-postgis-node `    | Python, build tools, PosgreSQL + PostGIS dependencies, and Node 20 + pnpm. |
| `python-postgis-node-dev` | Development image based on `python-postgis-node` with git + dev packages.  |

## Using

Use one of the following image sources:

- `uninen/python:3.11`
- `uninen/python-postgis:3.11`
- `uninen/python-postgis-node:3.11`
- `uninen/python-postgis-node-dev:latest`

See `py-test-app/` for example usage in a project.

## Building Manually

### python (tags: 3.10, 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-3.11.Dockerfile -t uninen/python:3.11 --provenance false --push .
```

### python-postgis (tags: 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --progress=plain -f python-postgis-3.11.Dockerfile -t uninen/python-postgis:3.11 --provenance false --push .
```

### python-postgis-node (tags: 3.11)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-3.11.Dockerfile -t uninen/python-postgis-node:3.11 --provenance false --push .
```

### python-postgis-node-dev (tags: latest)

```sh
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node-dev.Dockerfile -t uninen/python-postgis-node-dev:latest --provenance false --push .
```

## TODO

- Add base images to separate audio-related packages (ffmpeg, audiowaveform)

## License

[MIT](./LICENCE)

---

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)
