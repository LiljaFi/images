#!/bin/bash
cd /home/container

# Output current PHP version
php -v

# Replace Pterodactyl startup variables
MODIFIED_STARTUP=$(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo "Starting with: ${MODIFIED_STARTUP}"

# Run the startup command
eval ${MODIFIED_STARTUP}
