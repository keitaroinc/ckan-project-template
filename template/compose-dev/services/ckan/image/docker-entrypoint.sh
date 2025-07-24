#!/bin/sh
set -e

echo "Running pre-run checks..."

# Run any pre-run commands required by CKAN extensions.
sh /app/src/ckan/before-init.sh

python /app/src/ckan/prerun.py

# Now hand over to the main command passed by CMD
exec "$@"