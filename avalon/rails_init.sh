#!/bin/bash

# sendmail needs this to work
line=$(head -n 1 /etc/hosts)
line2=$(echo $line | awk '{print $2}')
echo "$line $line2.localdomain" >> /etc/hosts
service sendmail start

# batch ingest cronjob wouldn't autorun without this
touch /var/spool/cron/crontabs/app

chmod 0777 -R /masterfiles
chown -R app /masterfiles
cd /home/app/avalon

su app
# BACKGROUND=yes QUEUE=* bundle exec rake resque:work
RAILS_ENV=development bundle exec rake db:migrate
RAILS_ENV=development bundle exec script/delayed_job -n2 start
exit

cd public/assets/mediaelement_rails
if [ ! -e flashmediaelement.swf ]; then
  ln -s flashmediaelement-*.swf flashmediaelement.swf
fi
