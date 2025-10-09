FROM python:3.14.0-slim-trixie

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH="/home/duser/.local/bin:/usr/local/cargo/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:/home/duser/code/.dockervenv/lib/python3.14/site-packages"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m -s /bin/bash duser

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-python.sh && \
    rm -rf /root/scripts

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

USER duser
WORKDIR /home/duser
RUN git config --global --add safe.directory /code

CMD ["python"]
