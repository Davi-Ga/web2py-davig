#!/bin/bash

# users can overwrite UWSGI_OPTIONS
if [ "$UWSGI_OPTIONS" == '' ]; then
  UWSGI_OPTIONS='--master --thunder-lock --enable-threads'
fi

selectVersion() {
  if [ "$WEB2PY_VERSION" != '' ]; then
    git checkout $WEB2PY_VERSION
  fi
}

# Run uWSGI using the uwsgi protocol
if [ "$1" = 'uwsgi' ]; then
  # switch to a particular Web2py version if specificed
  selectVersion
  # add an admin password if specified
  if [ "$WEB2PY_PASSWORD" != '' ]; then
    python -c "from gluon.main import save_password; save_password('$WEB2PY_PASSWORD',443)"
  fi
  # run uwsgi
  exec uwsgi --socket 0.0.0.0:9090 --protocol uwsgi --wsgi wsgihandler:application $UWSGI_OPTIONS
fi

# Run using the builtin Rocket web server
if [ "$1" = 'rocket' ]; then
  # switch to a particular Web2py version if specificed
  selectVersion
  # Use the -a switch to specify the password
  exec python web2py.py -a '$WEB2PY_PASSWORD' -i 0.0.0.0 -p 8080
fi

exec "$@"