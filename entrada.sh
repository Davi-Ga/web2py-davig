if [ "$UWSGI_OPTIONS" == '' ]; then
  UWSGI_OPTIONS='--master --thunder-lock --enable-threads'
fi

selectVersion() {
  if [ "$WEB2PY_VERSION" != '' ]; then
    git checkout $WEB2PY_VERSION
  fi
}

