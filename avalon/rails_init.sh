#!/bin/bash

# sendmail needs this to work
line=$(head -n 1 /etc/hosts)
line2=$(echo $line | awk '{print $2}')
echo "$line $line2.localdomain" >> /etc/hosts
service sendmail start

# Make the userid consistent with host user (fixes permissions on bind mount)
[ "$APP_UID" == "" ] && echo "Empty APP_UID!" && exit 1
[ "$APP_GID" == "" ] && echo "Empty APP_GID!" && exit 1
if [ `id -u` != "$APP_UID" ]; then
  echo "app UID is now $APP_UID"
  usermod -u $APP_UID app
fi
if  [ `id -g` != "$APP_GID" ]; then
  echo "app GID is now $APP_GID"
  groupmod -g $APP_GID app
fi

chown -R ${APP_UID}:${APP_GID} /home/app

# batch ingest cronjob wouldn't autorun without this
touch /var/spool/cron/crontabs/app

chmod 0777 -R /masterfiles
chown -R app /masterfiles
cd /home/app/avalon
touch /home/app/avalon/log/development.log
touch /home/app/avalon/log/delayed_job.log
chmod 1777 /home/app/avalon/tmp
mkdir -p /home/app/avalon/tmp/cache
chmod 1777 /home/app/avalon/tmp/cache
chown -R app:app /home/app/avalon
cp /home/app/config/Gemfile.local /home/app/avalon/
cp /home/app/config/config/* /home/app/avalon/config/

su app
RAILS_ENV=development bundle config build.nokogiri --use-system-libraries && \
  bundle install --path=vendor/gems
mkdir -p tmp/pids
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec script/delayed_job -n2 start
exit

cd public/assets/mediaelement_rails
if [ ! -e flashmediaelement.swf ]; then
  ln -s flashmediaelement-*.swf flashmediaelement.swf
fi
