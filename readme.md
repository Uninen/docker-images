# Docker Images

The philosophy behind these images is to be as light as possible, yet complete enough **for production** to make the build process as fast as possible.

These images are regularly re-built (automatically every first Tuesday of the month + manually every now and then) to keep up with **security updates**. Combine with automatically polled image updates in your production (for example with Traefik + [Watchtower](https://containrrr.dev/watchtower/)) and you get automatic security updates in production.

Contributions welcome!

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

- Figure out build cache issue to be able to use caching w/ non-root images

## License

[MIT](./LICENCE)

----

Follow [@Uninen on Twitter](https://twitter.com/uninen) | [GitHub](https://github.com/Uninen)