if [ "$UWSGI_OPTIONS" == '' ]; then
  UWSGI_OPTIONS='--master --thunder-lock --enable-threads'
fi