FROM postgres:18-alpine AS builder

RUN apk add --no-cache \
    build-base \
    cmake \
    git \
    perl \
    postgresql-dev \
    cgal-dev \
    gdal-dev \
    proj-dev \
    geos-dev \
    protobuf-c-dev \
    libxml2-dev \
    json-c-dev \
    pcre2-dev \
    clang19-dev \
    llvm19-dev \
    autoconf \
    automake \
    libtool \
    cunit-dev \
    bison \
    flex

# Build PostGIS
RUN git clone --branch 3.6.2 --depth 1 https://github.com/postgis/postgis.git /tmp/postgis \
    && cd /tmp/postgis \
    && ./autogen.sh \
    && ./configure --without-protobuf-c --without-sfcgal \
    && make -j$(nproc) \
    && make install

# Build pgvector
RUN git clone --branch v0.8.2 --depth 1 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make -j$(nproc) \
    && make install

# Build h3-pg
RUN git clone --depth 1 https://github.com/zachasme/h3-pg.git /tmp/h3-pg \
    && cd /tmp/h3-pg \
    && cmake -B build -DCMAKE_BUILD_TYPE=Release -DFETCHCONTENT_QUIET=OFF \
    && cmake --build build --target install -j$(nproc)

# Build ogr_fdw
RUN git clone --branch v1.1.7 --depth 1 https://github.com/pramsey/pgsql-ogr-fdw.git /tmp/ogr_fdw \
    && cd /tmp/ogr_fdw \
    && make -j$(nproc) \
    && make install

# Build pointcloud
RUN git clone --branch v1.2.5 --depth 1 https://github.com/pgpointcloud/pointcloud.git /tmp/pointcloud \
    && cd /tmp/pointcloud \
    && autoreconf -fi \
    && ./configure \
    && make -j$(nproc) \
    && make install

# --- Final stage ---
FROM postgres:18-alpine

# Minimal runtime deps
RUN apk add --no-cache \
    gdal \
    geos \
    proj \
    libxml2 \
    json-c \
    protobuf-c

# Copy all built extensions
COPY --from=builder /usr/local/lib/postgresql/ /usr/local/lib/postgresql/
COPY --from=builder /usr/local/share/postgresql/extension/ /usr/local/share/postgresql/extension/

# Pre-bake the data directory with extensions so container startup skips initdb entirely
RUN apk add --no-cache su-exec \
    && echo "CREATE EXTENSION IF NOT EXISTS postgis;" \
            "CREATE EXTENSION IF NOT EXISTS vector;" \
            "CREATE EXTENSION IF NOT EXISTS h3;" \
            "CREATE EXTENSION IF NOT EXISTS ogr_fdw;" \
            "CREATE EXTENSION IF NOT EXISTS pointcloud;" \
       > /docker-entrypoint-initdb.d/10-create-extensions.sql \
    && PGDATA=/var/lib/postgresql/18/docker \
    && mkdir -p "$PGDATA" && chown postgres:postgres "$PGDATA" \
    && echo "postgres" > /tmp/pwfile && chown postgres:postgres /tmp/pwfile \
    && su-exec postgres initdb --username=postgres --pwfile=/tmp/pwfile --auth-host=scram-sha-256 -D "$PGDATA" \
    && rm /tmp/pwfile \
    && echo "host all all all scram-sha-256" >> "$PGDATA/pg_hba.conf" \
    && su-exec postgres pg_ctl -D "$PGDATA" start \
    && until pg_isready -U postgres; do sleep 0.2; done \
    && psql -U postgres -c "CREATE DATABASE test;" \
    && psql -U postgres -d test -f /docker-entrypoint-initdb.d/10-create-extensions.sql \
    && su-exec postgres pg_ctl -D "$PGDATA" stop -m fast \
    && rm /docker-entrypoint-initdb.d/10-create-extensions.sql

ENV POSTGRES_PASSWORD=postgres

# Healthcheck: pg_isready returns 0 when accepting connections
HEALTHCHECK --interval=1s --timeout=3s --start-period=3s --retries=3 \
    CMD pg_isready -U postgres || exit 1
