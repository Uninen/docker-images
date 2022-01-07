# Docker Images

These images are designed to be as light as possible, yet complete and secure enough **for production** to make the build process and testing as fast as possible.

The images are regularly re-built (automatically every first Tuesday of the month + manually every now and then) to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with Traefik + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic system security updates in production.

Contributions welcome!

## Features

- Based on Debian 8 base image
- Slimmer than `python-slim`
- Python built with PGO + Link-Time-Optimization flags
- Non-root user
- Python-related environment variables and paths set
- Latest `pip` + essential system packages preinstalled

See `sripts/` for details of the actual preinstalled packages.

## Images

These images are based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding non-root user, and basic dependencies needed for most Django projects.

| Name | Description | Size |
| --- | --- | --- |
| `python:3.9` | Python with build tools and PosgreSQL dependencies. Designed for Django. | ~173&nbsp;Mb |
| `python-postgis:3.9` | Python with build tools and PosgreSQL + PostGIS dependencies. Designed for Django + GeoDjango. | ~226&nbsp;Mb |

## Using

Just use one of the following image sources:

- `registry.gitlab.com/uninen/docker-images/python:3.9`
- `registry.gitlab.com/uninen/docker-images/python-postgis:3.9`

See `py-test-app/` for example usage in a project.

## Building

### python

```sh
docker build -f python-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python:3.9
```
### python-postgis

```sh
docker build -f python-postgis-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python-postgis:3.9
```
## TODO

- Add proper versioning (rename images + add explicit version number)
- Figure out build cache issue to be able to use caching w/ non-root images (see [./py-test-app/Dockerfile](./py-test-app/Dockerfile))

## License

[MIT](./LICENCE)

----

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)