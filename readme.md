# Docker Images

The philosophy behind these images is to be as light as possible, yet complete enough **for production** to make the build process as fast as possible.

These images are regularly re-built to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with Traefik + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

## Images

These images are based on [RevSys Python Builds](https://github.com/revsys/optimized-python-docker), adding non-root user, and basic dependencies needed for most Django projects.

- `python:3.9` - Python 3.9 with build tools and PosgreSQL dependencies. Designed for Django. ~173 Mb
- `python-postgis:3.9` - Python 3.9 with build tools and PosgreSQL + PostGIS dependencies. Designed for Django + GeoDjango. ~226 Mb

## Building

### python
docker build -f python-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python:3.9

### python-postgis
docker build -f python-postgis-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python-postgis:3.9

## TODO

- Figure out build cache issue to be able to use caching w/ non-root images

## License

[MIT](./LICENCE)

----

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)