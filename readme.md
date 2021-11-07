# Docker Images

This repo hosts the default base images I use in my projects. The idea is to keep them in one place and to improve and automate the process as much as possible. Contributions welcome!

## Building

docker build -f python-39.Dockerfile -t registry.gitlab.com/uninen/docker-images/python:3.9 .
docker push registry.gitlab.com/uninen/docker-images/python:3.9