FROM python:3
LABEL AUTHOR "Davi Galdino <davigaldinoky@gmail.com>"

ENV WEB2PY_ROOT=/opt/web2py

ENV WEB2PY_VERSION=2.22.3-stable
ENV WEB2PY_PASSWORD=

ENV WEB2PY_ADMIN_SECURITY_BYPASS=
ENV UWSGI_OPTIONS=

WORKDIR $WEB2PY_ROOT

RUN apt-get update && apt-get -y upgrade && apt-get -y install && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*\
    gcc \
    git \
    libpcre3-dev \
    && pip install uwsgi \
    && pip install GitPython \
    && pip install pyDAL \
    && pip install yatl \
    && git clone --recursive https://github.com/Davi-Ga/web2py.git $WEB2PY_ROOT \
    && mv $WEB2PY_ROOT/handlers/wsgihandler.py $WEB2PY_ROOT\
    && groupadd -g 1000 web2py \
    && useradd -r -u 1000 -g web2py web2py \
    && chown -R web2py:web2py $WEB2PY_ROOT

COPY entrada.sh /usr/local/bin/

ENTRYPOINT ["entrada.sh"]

USER web2py

EXPOSE 8080 9090

CMD ["http"]

