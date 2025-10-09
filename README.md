# Docker Images

Purpose-built opinionated images for (audio-related) Python projects.

These images are mostly based on Python slim, adding a non-root user and basic dependencies needed for most Django / Python / Node projects. The images are designed to be complete and secure enough **for production**.

The images are regularly re-built to keep up with security updates. Combine with automatically polled image updates in your production (for example with [Traefik](https://traefik.io/) + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

## Features

- Built for **linux/amd64 and linux/arm64 platforms**
- Latest `uv`, PostgreSQL 17 client and essential system packages preinstalled
- Non-root `duser` user added (home at `/home/duser/`)
- Python-related environment variables and paths set
- Based on Debian 13 (trixie) base image

See package lists at [sripts/](scripts/) for details of the actual preinstalled packages.

## Images

| Name                    | Description                                                                                                  |
| ----------------------- | ------------------------------------------------------------------------------------------------------------ |
| `python`                | Python, build tools, uv, PostgreSQL 17 dependencies.                                                         |
| `python-audio`          | Python image packages + tools for audio manipulation.                                                        |
| `python-postgis`        | Python image packages + PostGIS dependencies.                                                                |
| `python-postgis-mysql ` | Python image packages + PostGIS & MySQL dependencies.                                                        |
| `python-dev`            | Development image based on `python-postgis` with Node 24, Playwright, uv + dev packages.                     |
| `node`                  | Node 24 and pnpm 10.                                                                                         |
| `nginx-ffmpeg`          | Nginx, nginx-http-flv-module, ffmpeg from [deb-multimedia](https://www.deb-multimedia.org/), Python 3.14, uv |

## Using

Maintained images and tags:

- `uninen/python-dev:latest` (legacy tags: `3.13`, `3.12`, `3.11`)
- `uninen/python:3.14` (legacy tags: `3.13`, `3.12`, `3.11`)
- `uninen/python-audio:3.14` (legacy tags: `3.13`, `3.12`)
- `uninen/python-postgis:3.14` (legacy tags: `3.13`, `3.12`, `3.11`)
- `uninen/python-postgis-mysql:3.14` (legacy tags: `3.13`)
- `uninen/node:24` (legacy tags: `22`, `20`)
- `uninen/nginx-ffmpeg:latest` (legacy tags: `3.13`)

See `py-test-app/` for example usage in a project.

## Building Manually

If you don't yet have a builder ready, first run `docker buildx create --use` then;

### python-dev (tags: latest, 3.12, 3.11)

```sh
# test
docker build -f python-dev.Dockerfile -t uninen/python-dev:latest .

# prod
docker buildx build --platform linux/amd64,linux/arm64 -f python-dev.Dockerfile -t uninen/python-dev:latest . --push
```

### python (tags: 3.14, 3.13, 3.12, 3.11)

```sh
# test
docker build -f python-3.14.Dockerfile -t uninen/python:3.14 .

# prod
docker buildx build --platform linux/amd64,linux/arm64 -f python-3.14.Dockerfile -t uninen/python:3.14 . --push
```

### python-audio (tags: 3.14, 3.13, 3.12)

```sh
# test
docker build -f python-audio.Dockerfile -t uninen/python-audio:3.14 .

# prod
docker buildx build --platform linux/amd64,linux/arm64 -f python-audio.Dockerfile -t uninen/python-audio:3.14 . --push
```

### python-postgis (tags: 3.14, 3.13, 3.12, 3.11)

```sh
# test
docker build -f python-postgis-3.14.Dockerfile -t uninen/python-postgis:3.14 .

# prod
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-3.14.Dockerfile -t uninen/python-postgis:3.14 . --push
```

### python-postgis-mysql (tags: 3.14, 3.13)

```sh
# test
docker build -f python-postgis-mysql.Dockerfile -t uninen/python-postgis-mysql:3.14 .

# prod
docker buildx build --platform linux/amd64,linux/arm64 -f python-postgis-mysql.Dockerfile -t uninen/python-postgis-mysql:3.14 . --push
```

### node (tags: 24, 22)

```sh
# test
docker build -f node-24.Dockerfile -t uninen/node:24 .
# prod
docker buildx build --platform linux/amd64,linux/arm64 -f node-24.Dockerfile -t uninen/node:24 . --push
```

### nginx-ffmpeg (tags: latest, 3.13)

```sh
# test
docker buildx build --platform linux/amd64 -f nginx-ffmpeg.Dockerfile -t uninen/nginx-ffmpeg:latest .
# prod
docker buildx build --platform linux/amd64 -f nginx-ffmpeg.Dockerfile -t uninen/nginx-ffmpeg:latest . --push
```

## Testing

```sh
cd py-test-app
docker compose build
docker compose up
```

## Common Issues

- In case of GPG signature errors from apt, try `docker builder prune` on macOS

## License

[MIT](./LICENCE)

---

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)
