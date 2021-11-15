# Docker Images

This repo hosts the default base images I use in my projects. The idea is to keep them in one place and to improve and automate the process as much as possible. Contributions welcome!

## Building

### Python
docker build -f python-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python:3.9

### Python-postgis
docker build -f python-postgis-3.9.Dockerfile -t registry.gitlab.com/uninen/docker-images/python-postgis:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python-postgis:3.9

## TODO

- Figure out build cache issue to be able to use caching w/ non-root images
