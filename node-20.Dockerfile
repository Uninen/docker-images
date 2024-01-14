FROM bitnami/node:20
ENV DOCKER_BUILDKIT=1
ENV PATH="/home/duser/.local/bin:${PATH}"
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd -m -s /bin/bash duser

RUN corepack enable
RUN corepack prepare pnpm@latest-8 --activate

CMD ["node"]