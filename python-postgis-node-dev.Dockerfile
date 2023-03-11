FROM uninen/python-postgis-node:3.11

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/root/.local/bin:/usr/local/bin:${PATH}"
ENV PYTHONPATH="/root/.local/lib:/code/:/code/pylib:${PYTONPATH}"
ENV DEBIAN_FRONTEND=dialog

COPY scripts/install-dev-deps.sh .
RUN ./install-dev-deps.sh

CMD ["python"]
