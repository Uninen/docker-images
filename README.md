# Docker Images

Purpose-built images for (audio-related) Python projects.

These images aremostly based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding a non-root user and basic dependencies needed for most Django / Python / Node projects. The images are designed to be complete and secure enough **for production**.

The images are regularly re-built to keep up with security updates. Combine with automatically polled image updates in your production (for example with [Traefik](https://traefik.io/) + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

## Features

- Slimmer than `python` base images but still include production deps
- Built for **linux/amd64 and linux/arm64 platforms**
- Latest `pip`, `uv` or `pip-tools`, PostgreSQL 16 client and essential system packages preinstalled
- Non-root `duser` user added (home at `/home/duser/`)
- Python-related environment variables and paths set
- Python built with PGO + Link-Time-Optimization flags
- Based on Debian 12 (bookworm) base image

See package lists at [sripts/](scripts/) for details of the actual preinstalled packages.

## Images

| Name                   | Description                                                                                 |
| ---------------------- | ------------------------------------------------------------------------------------------- |
| `python`               | Python, build tools, uv, PosgreSQL dependencies.                                            |
| `python-audio`         | Python, build tools, uv, PosgreSQL, tools for audio manipulation.                           |
| `python-postgis`       | Python, build tools, PosgreSQL + PostGIS dependencies.                                      |
| `python-postgis-node ` | Python, build tools, uv, PosgreSQL + PostGIS dependencies, and Node 20 + pnpm.              |
| `python-dev`           | Development image based on `python-postgis-node` with Playwright, uv, Rye + dev packages.   |
| `node`                 | Node 20, latest pnpm 8 installed via corepack.                                              |
| `nginx-ffmpeg`         | Nginx, nginx-http-flv-module, ffmpeg from [deb-multimedia](https://www.deb-multimedia.org/) |

## Using

Maintained images and tags:

- `uninen/python-dev:latest` (legacy tags: `3.11`)
- `uninen/python:3.12` (legacy tags: `3.11`)
- `uninen/python-audio:3.12`
- `uninen/python-postgis:3.11`
- `uninen/python-postgis-node:3.11`
- `uninen/node:20`
- `uninen/nginx-ffmpeg:latest`

See `py-test-app/` for example usage in a project.

## Building Manually

If you don't yet have a builder ready, first run `docker buildx create --use` then;

### python-dev (tags: latest, 3.11)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f python-dev.Dockerfile -t uninen/python-dev:latest . --push
```

### python (tags: 3.12, 3.11)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f python-3.12.Dockerfile -t uninen/python:3.12 . --push
```

### python-audio (tags: 3.12)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f python-audio.Dockerfile -t uninen/python-audio:3.12 . --push
```

### python-postgis (tags: 3.11)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-3.11.Dockerfile -t uninen/python-postgis:3.11 . --push
```

### python-postgis-node (tags: 3.12, 3.11)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-node.Dockerfile -t uninen/python-postgis-node:3.12 . --push
```

### node (tags: 20)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f node-20.Dockerfile -t uninen/node:20 . --push
```

### nginx-ffmpeg (tags: latest)

```sh
docker buildx build --platform linux/amd64,linux/arm64 -f nginx-ffmpeg.Dockerfile -t uninen/node:20 . --push
```

## TODO

- Separate audio-related images

## License

[MIT](./LICENCE)

---

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)
