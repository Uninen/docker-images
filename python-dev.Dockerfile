FROM uninen/python-postgis-node:3.13

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH="/home/duser/.local/bin:/usr/local/cargo/bin:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV DEBIAN_FRONTEND=noninteractive

USER root

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-dev.sh && \
    rm -rf /root/scripts

USER duser

WORKDIR /home/duser

CMD ["python"]
