ARG NGINX_VERSION=1.25.3
ARG HTTP_FLV_MODULE_VERSION=1.2.11
ARG HTTP_PORT=8099
ARG HTTPS_PORT=4435
ARG RTMP_PORT=1935

###################################################
# Base image
FROM debian:bookworm as base-image

ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT}

# FFmpeg details: https://www.deb-multimedia.org/dists/stable/main/binary-amd64/package/ffmpeg
RUN apt-get update && apt-get install -y ca-certificates wget gnupg libpcre3 && \
    echo deb http://www.deb-multimedia.org bookworm main non-free | tee /etc/apt/sources.list.d/deb-multimedia.list && \
    wget https://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb && \
    dpkg -i deb-multimedia-keyring_2016.8.1_all.deb && \
    apt-get update && \
    apt-get install -y ffmpeg && \
    rm deb-multimedia-keyring_2016.8.1_all.deb && \
    apt-get remove ca-certificates wget gnupg --allow-remove-essential --purge -y -q && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /root/.cache

###################################################
# Build image
FROM debian:bookworm as build-image

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
FROM build-image as build-stage

ARG NGINX_VERSION
ARG HTTP_FLV_MODULE_VERSION
ARG HTTP_PORT
ARG HTTPS_PORT
ARG RTMP_PORT

ENV HTTP_PORT=${HTTP_PORT} \
    HTTPS_PORT=${HTTPS_PORT} \
    RTMP_PORT=${RTMP_PORT}

RUN cd /tmp && \
  wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar -zxvf nginx-${NGINX_VERSION}.tar.gz \
  && wget https://github.com/winshining/nginx-http-flv-module/archive/refs/tags/v${HTTP_FLV_MODULE_VERSION}.tar.gz \
  && tar -zxvf v${HTTP_FLV_MODULE_VERSION}.tar.gz

RUN cd /tmp/nginx-${NGINX_VERSION} && \
  ./configure \
  --prefix=/usr/local/nginx \
  --add-module=/tmp/nginx-http-flv-module-${HTTP_FLV_MODULE_VERSION} \
  --conf-path=/etc/nginx/nginx.conf \
  --with-threads \
  --with-file-aio \
  --with-http_ssl_module \
  --with-debug \
  --with-http_stub_status_module \
  --with-cc-opt="-Wimplicit-fallthrough=0" && \
  make && \
  make install

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
