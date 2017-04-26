FROM        phusion/passenger-ruby22
MAINTAINER  Michael B. Klein <michael.klein@northwestern.edu>
RUN         apt-get update && apt-get upgrade -y
RUN         apt-get install -y mediainfo ffmpeg x264 cmake pkg-config lsof sendmail yaz libyaz4-dev unzip default-jre-headless
RUN         apt-get clean
RUN         ln -s /usr/bin/lsof /usr/sbin/ && \
            rm /etc/nginx/sites-enabled/default && \
            rm -f /etc/service/nginx/down && \
            ln -s /etc/nginx/sites-available/avalon /etc/nginx/sites-enabled/avalon && \
            chown app:docker_env /etc/container_environment.sh
ARG         AVALON_REPO=https://github.com/ualbertalib/avalon.git
ARG         AVALON_BRANCH=master
ARG         APP_UID
ARG         APP_GID
WORKDIR     /home/app
USER        app
# Will copy these files to source dir in rails_init.sh
RUN         mkdir /home/app/config
ADD         Gemfile.local /home/app/config/
RUN         mkdir /home/app/config/config
ADD         config/* /home/app/config/config/

ARG         RAILS_ENV=development
ARG         BASE_URL
ARG         DATABASE_URL
ARG         SECRET_KEY_BASE
USER        root
ADD         ./avalon.conf /etc/nginx/sites-available/avalon
ADD         ./nginx_env.conf /etc/nginx/main.d/env.conf
ADD         rails_init.sh /etc/my_init.d/30_rails_init.sh
