FROM python:3
LABEL AUTHOR "Davi Galdino <davigaldinoky@gmail.com>"

RUN apt_get update && apt-get -y install \
    gcc \
    git \
    libpcre3-dev \
    && pip install uwsgi \
    && git clone --recursive https://github.com/web2py/web2py.git $WEB2PY_ROOT \
    && mv $WEB2PY_ROOT/handlers/wsgihandler.py $WEB2PY_ROOT \
    && groupadd -g 1000 web2py \
    && useradd -r -u 1000 -g web2py web2py \
    && chown -R web2py:web2py $WEB2PY_ROOT


COPY entrada.sh /usr/local/bin/

ENTRYPOINT ["entrada.sh"]
CMD ["https"]

EXPOSE 80:80