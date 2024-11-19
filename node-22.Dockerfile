FROM bitnami/node:22
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m -s /bin/bash duser

RUN corepack enable && \
    corepack prepare pnpm@latest-9 --activate && \
    npx playwright install --with-deps

ADD ./scripts /root/scripts/
RUN /root/scripts/prep-node.sh && rm -rf /root/scripts

CMD ["node"]