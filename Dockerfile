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
RUN sed -i 's/sudo -u ${fermentrackUser} -H/gosu ${fermentrackUser}/g' fermentrack-tools/install.sh
#RUN sed -i 's/service nginx restart/service nginx disable/g' fermentrack-tools/install.sh
RUN sed -i 's:/etc/nginx/sites-available/default-fermentrack:/etc/nginx/conf.d/default.conf:g' fermentrack-tools/install.sh
RUN bash fermentrack-tools/install.sh -n

# Redirect circusd logs
RUN sed -i 's:$(circus.env.HOME)/fermentrack/log/circusd.log::g' /home/fermentrack/fermentrack/circus.ini

# Setup persistent storage (mountable directories)
VOLUME ["/home/fermentrack/fermentrack/data", "/home/fermentrack/fermentrack/collected_static"]

COPY docker_cmd.sh /
RUN chmod +x /docker_cmd.sh
CMD /docker_cmd.sh
