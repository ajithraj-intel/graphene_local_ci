FROM ubuntu:21.04

# Add steps here to set up dependencies
RUN apt-get update && env DEBIAN_FRONTEND=noninteractive apt-get install -y \
    autoconf \
    bc \
    bison \
    build-essential \
    cargo \
    clang \
    curl \
    flex \
    gawk \
    gdb \
    gettext \
    git \
    jq \
    libaio1 \
    libapr1-dev \
    libaprutil1-dev \
    libcjson-dev \
    libcurl4-openssl-dev \
    libelf-dev \
    libevent-dev \
    libexpat1 \
    libexpat1-dev \
    libjpeg-dev \
    libmemcached-tools \
    libnss-mdns \
    libnss-myhostname \
    libnuma1 \
    libomp-dev \
    libpcre2-dev \
    libpcre3-dev \
    libprotobuf-c-dev \
    libssl-dev \
    libunwind8 \
    libxfixes3 \
    libxi6 \
    libxml2-dev \
    libxrender1 \
    libxxf86vm1 \
    linux-headers-generic \
    libjudy-dev \
    libpixman-1-dev \
    libipsec-mb-dev \
    lsb-release \
    lsof \
    musl \
    musl-tools \
    nasm \ 
    net-tools \
    netcat-openbsd \
    ninja-build \
    nodejs \
    openjdk-11-jdk \
    pkg-config \
    protobuf-c-compiler \
    protobuf-compiler \
    pylint3 \
    python \
    python3-apport \
    python3-apt \
    python3-breathe \
    python3-click \
    python3-cryptography \
    python3-jinja2 \
    python3-lxml \
    python3-numpy \
    python3-pip \
    python3-protobuf \
    python3-pyelftools \
    python3-pytest \
    python3-pytest-xdist \
    python3-recommonmark \
    python3-scipy \
    python3-sphinx-rtd-theme \
    python3-toml \
    r-base \
    sqlite3 \
    shellcheck \
    sphinx-doc \
    texinfo \
    uthash-dev \
    vim \
    wget \
    zlib1g \
    sudo \
    zlib1g-dev

# Install wrk2 benchmark. This benchmark is used in `benchmark-http.sh`.
RUN git clone https://github.com/giltene/wrk2.git \
    && cd wrk2 \
    && git checkout 44a94c17d8e6a0bac8559b53da76848e430cb7a7 \
    && make \
    && cp wrk /usr/local/bin \
    && cd .. \
    && rm -rf wrk2

# NOTE about meson version: we support "0.55 or newer", so in CI we pin to latest patch version of
# the earliest supported minor version (pip implicitly installs latest version satisfying the
# specification)
RUN python3 -m pip install -U \
    asv \
    'meson>=0.55,<0.56'  \
    torchvision \
    pillow

# Add the user UID:1000, GID:1000, home at /intel
RUN groupadd -r intel -g 1000 && useradd -u 1000 -r -g intel -G sudo -m -d /intel -c "intel Jenkins" intel && \
    chmod 777 /intel

# Make sure /intel can be written by intel
RUN chown 1000 /intel 

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'http_proxy="http://proxy-dmz.intel.com:911/"\nhttps_proxy="http://proxy-dmz.intel.com:912/"' >> /etc/environment

# Blow away any random state
RUN rm -f /intel/.rnd

# Make a directory for the intel driver
RUN mkdir -p /opt/intel && chown 1000 /opt/intel

# Make a directory for the Gramine installation
RUN mkdir -p /home/intel/gramine_install && chown 1000 /home/intel/gramine_install

# Set the working directory to intel home directory
WORKDIR /intel

# Specify the user to execute all commands below
USER intel

# Set environment variables.
ENV HOME /intel

# Define default command.
CMD ["bash"]
