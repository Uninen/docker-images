FROM uninen/python-postgis-node:3.13

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:/home/duser/.cargo/bin:/home/duser/.rye/shims:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV DEBIAN_FRONTEND=noninteractive

USER root

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-dev.sh && \
    rm -rf /root/scripts

USER duser

WORKDIR /home/duser

CMD ["python"]
