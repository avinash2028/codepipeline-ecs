FROM ubuntu:22.04
RUN apt-get update && \
    apt-get install -y \
    nginx \
    && rm -rf /var/lib/apt/lists/*
COPY index.html /usr/share/nginx/html/index.html