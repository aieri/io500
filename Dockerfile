FROM ubuntu:24.04

COPY . io500/

RUN <<EOF
apt update
apt install -y libopenmpi-dev pkg-config make git

# Do the io500 installation
cd io500 && ./prepare.sh

# Mark openmpi as manually installed to prevent purging
apt install -y openmpi-bin

# Cleanup packages not needed at runtime
apt remove --purge -y libopenmpi-dev git pkg-config make
apt autoremove -y
apt clean
EOF

ENV PATH=/io500:$PATH

ENTRYPOINT ["io500"]

LABEL org.opencontainers.image.source=https://github.com/aieri/io500
LABEL org.opencontainers.image.description="OCI image for the io500 benchmark"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.ref.name="io500"
LABEL org.opencontainers.image.version="io500-sc25_v1"
