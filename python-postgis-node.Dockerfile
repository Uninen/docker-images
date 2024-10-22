FROM python:3.12.7-slim

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:/home/duser/.cargo/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV DEBIAN_FRONTEND=noninteractive
ENV VIRTUAL_ENV="/home/duser/.local"

RUN useradd -m -s /bin/bash duser

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-postgis-node.sh && \
    rm -rf /root/scripts

USER duser
WORKDIR /home/duser
ADD --chmod=755 https://astral.sh/uv/install.sh /home/duser/install.sh
RUN /home/duser/install.sh && \
    rm /home/duser/install.sh && \
    uv venv .local && \
    git config --global --add safe.directory /code

CMD ["python"]
