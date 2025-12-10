#!/bin/bash
cd /home/container

# Create required directories
mkdir -p /home/container/logs /home/container/public /home/container/tmp

# Replace SERVER_PORT and WEB_ROOT in nginx config
sed -i "s/SERVER_PORT/${SERVER_PORT:-80}/g" /home/container/nginx.conf
sed -i "s/WEB_ROOT/${WEB_ROOT:-public}/g" /home/container/nginx.conf

# Create default index.php if not exists
if [ ! -f /home/container/${WEB_ROOT:-public}/index.php ]; then
    mkdir -p /home/container/${WEB_ROOT:-public}
    echo "<?php phpinfo();" > /home/container/${WEB_ROOT:-public}/index.php
fi

# Run composer install if composer.json exists
if [ -f /home/container/composer.json ]; then
    composer install --no-interaction
fi

# Output info
echo "Starting PHP-FPM + Nginx..."
echo "Web root: /home/container/${WEB_ROOT:-public}"
echo "Port: ${SERVER_PORT:-80}"

# Replace Pterodactyl startup variables and execute
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
eval ${MODIFIED_STARTUP}
