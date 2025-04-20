ARG NGINX_VERSION=1.27.5
ARG HTTP_FLV_MODULE_VERSION=1.2.12
ARG HTTP_PORT=8099
ARG HTTPS_PORT=4435
ARG RTMP_PORT=1935

###################################################
# Base image
FROM debian:bookworm AS base-image

ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT} \
    DEBIAN_FRONTEND=noninteractive

# FFmpeg details: https://www.deb-multimedia.org/dists/stable/main/binary-amd64/package/ffmpeg
RUN apt-get update && apt-get install -y ca-certificates wget gnupg libpcre3 && \
    echo deb http://www.deb-multimedia.org bookworm main non-free | tee /etc/apt/sources.list.d/deb-multimedia.list && \
    wget https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2024.9.1_all.deb && \
    dpkg -i deb-multimedia-keyring_2024.9.1_all.deb && \
    apt-get update && \
    apt-get install -y ffmpeg && \
    rm deb-multimedia-keyring_2024.9.1_all.deb && \
    apt-get remove ca-certificates wget gnupg --allow-remove-essential --purge -y -q && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache

###################################################
# Build image
FROM debian:bookworm AS build-image

ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT}

RUN apt-get update && \
    apt-get install wget g++ make openssl libssl-dev zlib1g-dev libpcre3 libpcre3-dev -y

###################################################
# Build
FROM build-image AS build-stage

ARG NGINX_VERSION
ARG HTTP_FLV_MODULE_VERSION
ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT
ARG TARGETARCH # Declare the automatic build argument

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT} \
    MAKEFLAGS="-j$(nproc)"
# CFLAGS/LDFLAGS will be set conditionally in the RUN command

# Download Nginx and the module
RUN cd /tmp && \
    wget --no-verbose https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
    && wget --no-verbose https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${HTTP_FLV_MODULE_VERSION}.tar.gz \
    && tar -zxvf v${HTTP_FLV_MODULE_VERSION}.tar.gz

# Configure, compile, and install Nginx with conditional flags
RUN set -eux; \
    cd /tmp/nginx-${NGINX_VERSION}; \
    \
    # Define base flags applicable to all architectures
    NGINX_CFLAGS="-O3 -flto -fomit-frame-pointer -pipe"; \
    NGINX_LDFLAGS="-Wl,-O1"; \
    \
    # Add architecture-specific optimizations
    echo "Building for TARGETARCH=${TARGETARCH}"; \
    if [ "${TARGETARCH}" = "amd64" ]; then \
    echo "Applying Skylake optimizations for amd64"; \
    NGINX_CFLAGS="${NGINX_CFLAGS} -march=skylake -mtune=skylake"; \
    elif [ "${TARGETARCH}" = "arm64" ]; then \
    echo "Applying generic ARMv8 optimizations for arm64"; \
    # You can add generic ARM optimizations if desired, e.g.:
    # NGINX_CFLAGS="${NGINX_CFLAGS} -march=armv8-a+crc -mtune=generic"; \
    # For now, we'll stick to the base flags for simplicity on ARM
    else \
    echo "Using generic optimizations for ${TARGETARCH}"; \
    fi; \
    \
    echo "Final CFLAGS: ${NGINX_CFLAGS}"; \
    echo "Final LDFLAGS: ${NGINX_LDFLAGS}"; \
    \
    # Run configure with the determined flags
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
    --with-cc-opt="${NGINX_CFLAGS}" \
    --with-ld-opt="${NGINX_LDFLAGS}"; \
    \
    # Build and install
    make; \
    make install; \
    \
    # Strip the binary
    strip /usr/local/nginx/sbin/nginx;

#######################################
# Final
FROM base-image

ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT} \
    PATH="${PATH}:/usr/local/nginx/sbin"

COPY --from=build-stage /usr/local/nginx /usr/local/nginx
COPY --from=build-stage /etc/nginx /etc/nginx

EXPOSE $HTTP_PORT
EXPOSE $HTTPS_PORT
EXPOSE $RTMP_PORT

CMD ["nginx", "-g", "daemon off;"]
