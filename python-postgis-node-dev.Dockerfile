FROM registry.gitlab.com/uninen/docker-images/python-postgis-node:3.11

ENV DOCKER_BUILDKIT=1
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/root/.local/lib:/code/:/code/pylib:${PYTONPATH}"
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY scripts/install-audiowaveform.sh .
COPY scripts/install-dev-deps.sh .
RUN ./install-dev-deps.sh

CMD ["python"]
