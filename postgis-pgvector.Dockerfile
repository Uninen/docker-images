FROM kartoza/postgis:18-3.6
ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    postgresql-18-pgvector \
    && rm -rf /var/lib/apt/lists/*
