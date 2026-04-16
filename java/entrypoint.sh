#!/bin/bash

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

if [ -z "${TIMEZONE}" ]; then
  #TZ=${TIMEZONE}
fi

# shellcheck disable=SC2086
exec env ${PARSED}
