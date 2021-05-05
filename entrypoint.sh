#!/bin/bash

cd /opt
. ./env/bin/activate

django-admin.py startproject website && cd website
python manage.py migrate

# modify allowed hosts
# add static path to setting.py
sed -i "s/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \[\'0.0.0.0\'\]/g" website/settings.py
sed -i '12i import os' website/settings.py
echo 'STATIC_ROOT = os.path.join(BASE_DIR, "static/")' >> website/settings.py
python manage.py collectstatic


/etc/init.d/nginx start
cd /opt/website && uwsgi --ini /opt/conf/website_uwsgi.ini

exec "$@"
