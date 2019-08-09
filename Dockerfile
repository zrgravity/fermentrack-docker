FROM nginx

# Install pre-requesites
RUN apt-get update
RUN apt-get install -y git-core build-essential python-dev python-virtualenv

# Install fermentrack
RUN git clone https://github.com/thorrak/fermentrack-tools.git fermentrack-tools
WORKDIR fermentrack-tools
RUN install.sh -n; exit 0
RUN sed -i 's:/etc/nginx/sites-available/default-fermentrack:/etc/nginx/conf.d/default.conf:g' fermentrack-tools/install.sh

# Setup persistent storage (mountable directories)
VOLUME ["/home/fermentrack/fermentrack/data", "/home/fermentrack/fermentrack/collected_static"]
