FROM revolutionsystems/python:3.11.5-wee-lto-optimized

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTONPATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m -s /bin/bash duser

COPY scripts/install-audiowaveform.sh .
COPY scripts/install-deps-postgis-node.sh .
RUN ./install-deps-postgis-node.sh

CMD ["python"]
