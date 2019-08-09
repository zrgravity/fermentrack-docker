FROM ubuntu:latest

# Install pre-requesites
RUN apt-get update
RUN apt-get install -y git-core build-essential python-dev python-virtualenv

# Install fermentrack
RUN git clone https://github.com/thorrak/fermentrack-tools.git fermentrack-tools
WORKDIR fermentrack-tools
RUN install.sh -n; exit 0
RUN tail install.log; exit 1

# Setup persistent storage (mountable directories)
VOLUME ["/home/fermentrack/fermentrack/data", "/home/fermentrack/fermentrack/collected_static", "/var/log/nginx"]

# Define default command. (CMD from https://github.com/nginxinc/docker-nginx/blob/master/stable/buster/Dockerfile)
CMD ["nginx", "-g", "daemon off;"]

# Setup ports
EXPOSE 80
