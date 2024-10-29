FROM python:3.13.0-slim

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:/home/duser/.cargo/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV DEBIAN_FRONTEND=noninteractive
ENV VIRTUAL_ENV="/home/duser/.local"
ENV UV_NO_CACHE=1

RUN useradd -m -s /bin/bash duser

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-python.sh && \
    /root/scripts/prep-audio.sh && \
    rm -rf /root/scripts

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER duser
WORKDIR /home/duser
RUN uv venv .local && \
    git config --global --add safe.directory /code

CMD ["python"]
