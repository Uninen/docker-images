# Version: 2025.04.1
ARG NGINX_VERSION=1.27.5
ARG HTTP_FLV_MODULE_VERSION=1.2.12
ARG HTTP_PORT=8099
ARG HTTPS_PORT=4435
ARG RTMP_PORT=1935

###################################################
# Base image (Runtime dependencies)
FROM python:3.13-slim-bookworm AS base-image

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1

# FFmpeg 6.1.2
# https://www.deb-multimedia.org/dists/stable-backports/main/binary-amd64/package/ffmpeg
# https://ffmpeg.org/index.html#news
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg ca-certificates libpcre3 moreutils && \
    echo "deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware" >> /etc/apt/sources.list && \
    echo "deb http://www.deb-multimedia.org bookworm main non-free" > /etc/apt/sources.list.d/deb-multimedia.list && \
    echo "deb http://www.deb-multimedia.org bookworm-backports main" >> /etc/apt/sources.list.d/deb-multimedia.list && \
    wget --no-verbose https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2024.9.1_all.deb -O /tmp/deb-multimedia-keyring.deb && \
    dpkg -i /tmp/deb-multimedia-keyring.deb && \
    rm /tmp/deb-multimedia-keyring.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends -t bookworm-backports \
    ffmpeg \
    intel-media-va-driver-non-free \
    libva-drm2 \
    libmfx1 && \
    apt-get purge -y --auto-remove wget gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /root/.cache

###################################################
# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN uv --version

###################################################
# Build dependencies image
FROM debian:bookworm-slim AS build-deps

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates g++ make openssl libssl-dev zlib1g-dev libpcre3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

###################################################
# Build Nginx stage
FROM build-deps AS build-stage

ARG NGINX_VERSION
ARG HTTP_FLV_MODULE_VERSION

# Hardcode optimizations for Intel Skylake (Xeon E3-1275v5 target)
ENV MAKEFLAGS="-j$(nproc)" \
    CFLAGS="-O3 -march=skylake -mtune=skylake -flto -fomit-frame-pointer -pipe" \
    CXXFLAGS="-O3 -march=skylake -mtune=skylake -flto -fomit-frame-pointer -pipe" \
    LDFLAGS="-Wl,-O1"

RUN cd /tmp && \
    wget --no-verbose https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
    && wget --no-verbose https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${HTTP_FLV_MODULE_VERSION}.tar.gz \
    && tar -zxvf v${HTTP_FLV_MODULE_VERSION}.tar.gz

RUN set -eux; \
    cd /tmp/nginx-${NGINX_VERSION}; \
    echo "Using hardcoded Skylake optimizations."; \
    echo "CFLAGS: ${CFLAGS}"; \
    echo "LDFLAGS: ${LDFLAGS}"; \
    ./configure \
    --prefix=/usr/local/nginx \
    --add-module=/tmp/nginx-http-flv-module-${HTTP_FLV_MODULE_VERSION} \
    --conf-path=/etc/nginx/nginx.conf \
    --with-threads \
    --with-file-aio \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-pcre-jit \
    --with-http_stub_status_module \
    # --with-debug \
    --with-cc-opt="${CFLAGS}" \
    --with-ld-opt="${LDFLAGS}"; \
    make; \
    make install; \
    strip /usr/local/nginx/sbin/nginx; \
    rm -rf /tmp/nginx-${NGINX_VERSION} /tmp/nginx-http-flv-module-${HTTP_FLV_MODULE_VERSION} /tmp/*.tar.gz

#######################################
# Final image
FROM base-image

ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT} \
    PATH="/usr/local/nginx/sbin:${PATH}"

COPY --from=build-stage /usr/local/nginx /usr/local/nginx
COPY --from=build-stage /etc/nginx /etc/nginx

EXPOSE $HTTP_PORT
EXPOSE $HTTPS_PORT
EXPOSE $RTMP_PORT

CMD ["nginx", "-g", "daemon off;"]