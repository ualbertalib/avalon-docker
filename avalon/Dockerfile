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
WORKDIR     /home/app
USER        app
RUN         git clone --branch=${AVALON_BRANCH} --depth=1 ${AVALON_REPO}
ADD         Gemfile.local /home/app/avalon/
ADD         config/* /home/app/avalon/config/
ARG         RAILS_ENV=production
RUN         cd avalon && \
              bundle config build.nokogiri --use-system-libraries && \
              bundle install --path=vendor/gems --without development test && \
              cd ..
ARG         BASE_URL
ARG         DATABASE_URL
ARG         SECRET_KEY_BASE
RUN         cd avalon && \
              mkdir -p tmp/pids && \
              bundle exec rake assets:precompile && \
              cd ..
USER        root
RUN         chown -R app:app /home/app/avalon
ADD         ./avalon.conf /etc/nginx/sites-available/avalon
ADD         ./nginx_env.conf /etc/nginx/main.d/env.conf
ADD         rails_init.sh /etc/my_init.d/30_rails_init.sh
