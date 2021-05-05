FROM ubuntu:20.04

WORKDIR /opt
COPY conf /opt/conf

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -qq install -y \
    python3 python3-dev python3-venv \
    gcc g++ nginx vim

RUN cd /opt && \
  python3 -m venv env && \
  . ./env/bin/activate && \
  pip install --upgrade pip setuptools wheel && \
  pip install Django uwsgi

RUN cp conf/website_nginx.conf /etc/nginx/sites-available/ && \
  ln -s /etc/nginx/sites-available/website_nginx.conf /etc/nginx/sites-enabled/

COPY entrypoint.sh /

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]

