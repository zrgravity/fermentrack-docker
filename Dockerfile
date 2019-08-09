FROM ubuntu:latest

# Install pre-requesites
RUN apt-get update
RUN apt-get install -y git-core build-essential python-dev python-virtualenv

# Install fermentrack
RUN git clone https://github.com/thorrak/fermentrack-tools.git fermentrack-tools
RUN fermentrack-tools/install.sh -n

# Setup persistent storage (mountable directories)
VOLUME ["/home/fermentrack/fermentrack/data", "/home/fermentrack/fermentrack/collected_static", "/var/log/nginx"]

# Define default command.
CMD ["nginx"]

# Setup ports
EXPOSE 80
