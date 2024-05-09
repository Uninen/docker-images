FROM uninen/python-postgis-node:3.12

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:/home/duser/.cargo/bin:/home/duser/.rye/shims:${PATH}"
ENV PYTHONPATH="/home/duser/.local/lib:${PYTHONPATH}"
ENV DEBIAN_FRONTEND=noninteractive
ENV RYE_TOOLCHAIN="/home/duser/.local/bin/python"
ENV RYE_INSTALL_OPTION="--yes"

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-dev.sh && \
    rm -rf /root/scripts

USER duser

WORKDIR /home/duser

RUN curl -sSf https://rye-up.com/get | bash && \
    mkdir -p /home/duser/.local/share/bash-completion/completions && \
    rye self completion > /home/duser/.local/share/bash-completion/completions/rye.bash && \
    rye config --set-bool behavior.use-uv=true && \
    rye pin cpython@3.12.3

CMD ["python"]
