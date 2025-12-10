#!/bin/bash

# Create required directories
mkdir -p /home/container/logs /home/container/public /tmp

# Replace SERVER_PORT in nginx config
sed -i "s/SERVER_PORT/${SERVER_PORT:-80}/g" /etc/nginx/nginx.conf

# Create default index.php if not exists
if [ ! -f /home/container/public/index.php ]; then
    echo "<?php phpinfo();" > /home/container/public/index.php
fi

# Run composer install if composer.json exists
if [ -f /home/container/composer.json ]; then
    cd /home/container && composer install --no-interaction
fi

# Start supervisor
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
