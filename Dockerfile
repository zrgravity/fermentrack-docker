FROM nginx

# Install pre-requesites
RUN apt-get update && apt-get install -y \
    avrdude \
    bash \
    bluez \
    build-essential \
    cron \
    git-core \
    gosu \
    libbluetooth3 \
    libcap2-bin \
    python-dev \
    python-virtualenv \
    python3-dev \
    python3-numpy \
    python3-scipy \
    python3-venv \
    python3-zmq \
    redis-server \
    wget \
&& rm -rf /var/lib/apt/lists/*

# Install fermentrack
RUN git clone https://github.com/thorrak/fermentrack-tools.git fermentrack-tools
WORKDIR fermentrack-tools
RUN install.sh -n; exit 0
RUN sed -i 's:/etc/nginx/sites-available/default-fermentrack:/etc/nginx/conf.d/default.conf:g' fermentrack-tools/install.sh

# Setup persistent storage (mountable directories)
VOLUME ["/home/fermentrack/fermentrack/data", "/home/fermentrack/fermentrack/collected_static"]
