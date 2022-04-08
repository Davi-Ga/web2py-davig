#!/bin/bash

# Usuários podem sobrescrever o UWSGI_OPTIONS.
if [ "$UWSGI_OPTIONS" == '' ]; then
  UWSGI_OPTIONS='--master --thunder-lock --enable-threads'
fi

#Realiza um checkout da versão.
selectVersion() {
  if [ "$WEB2PY_VERSION" != '' ]; then
    git checkout $WEB2PY_VERSION
  fi
}

# Execute o uWSGI usando o seu protocolo.
if [ "$1" = 'uwsgi' ]; then
  # Troque para a versão particular do Web2Py caso seja especificado.
  selectVersion
  # Adiciona a senha do administrador caso seja especificado.
  if [ "$WEB2PY_PASSWORD" != '' ]; then
    python -c "from gluon.main import save_password; save_password('$WEB2PY_PASSWORD',443)"
  fi
  # Execute o uWSGI
  exec uwsgi --socket 0.0.0.0:9090 --protocol uwsgi --wsgi wsgihandler:application $UWSGI_OPTIONS
fi

# Execute uWSGI usando HTTP.
if [ "$1" = 'http' ]; then
  # Altera a versão particular do Web2Py caso especificado.
  selectVersion
  # Desabilita a proteção HTTP.
  if [ "$WEB2PY_ADMIN_SECURITY_BYPASS" = 'true' ]; then
    if [ "$WEB2PY_PASSWORD" == '' ]; then
      echo "ERROR - WEB2PY_PASSWORD not specified"
      exit 1
    fi
    echo "WARNING! - Admin Application Security over HTTP bypassed"
    python -c "from gluon.main import save_password; save_password('$WEB2PY_PASSWORD',8080)"
    sed -i "s/elif not request.is_local and not DEMO_MODE:/elif False:/" \
      $WEB2PY_ROOT/applications/admin/models/access.py
    sed -i "s/is_local=(env.remote_addr in local_hosts and client == env.remote_addr)/is_local=True/" \
      $WEB2PY_ROOT/gluon/main.py
  fi
  # Execute o uWSGI.
  exec uwsgi --http 0.0.0.0:8080 --wsgi wsgihandler:application $UWSGI_OPTIONS
fi

# Execute usando uma contrução do Rocket Web Server.
if [ "$1" = 'rocket' ]; then
  # Troque para a versão particular do Web2Py caso especificado.
  selectVersion
  # Use o -a para trocar a senha específica.
  exec python web2py.py -a '$WEB2PY_PASSWORD' -i 0.0.0.0 -p 8080
fi
##Executa os comandos
exec "$@"