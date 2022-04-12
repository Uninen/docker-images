FROM revolutionsystems/python:3.10.4-wee-optimized-lto

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH="/home/duser/.local/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTONPATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --create-home duser

COPY scripts/install-deps.sh .
RUN ./install-deps.sh

CMD ["python"]
