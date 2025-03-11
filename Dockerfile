# Dockerfile for Proxmox Backup Client, also contains a few other scripts

# base image
ARG DEBIAN_VERSION="bookworm"
FROM debian:${DEBIAN_VERSION}

ARG DEBIAN_VERSION

# credit 
LABEL maintainer="Cornelius-Figgle"

# create working directories
WORKDIR /app
RUN mkdir ./data
COPY ./scripts/* .

# instructions taken and modified from https://pbs.proxmox.com/docs/installation.html#proxmox-backup-client-only-repository
RUN apt-get update && \
apt-get install -y wget && \
wget https://enterprise.proxmox.com/debian/proxmox-release-${DEBIAN_VERSION}.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-${DEBIAN_VERSION}.gpg && \
echo "deb http://download.proxmox.com/debian/pbs-client ${DEBIAN_VERSION} main" > /etc/apt/sources.list.d/pbs-client.list && \
apt-get update && \
apt-get install -y proxmox-backup-client

# the actual backup (leverages ENV vars)
CMD proxmox-backup-client backup $(./data-iterator.sh) --ns ${PBS_NS}
