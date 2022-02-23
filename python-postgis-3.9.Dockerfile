FROM revolutionsystems/python:3.9.9-wee-optimized-lto

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/home/duser/.local/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTONPATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --create-home duser

COPY scripts/install-deps-postgis.sh .
RUN ./install-deps-postgis.sh

CMD ["python"]
