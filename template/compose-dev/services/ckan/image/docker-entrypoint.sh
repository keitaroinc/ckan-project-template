#!/bin/sh
set -e

echo "Running pre-run checks..."
python prerun.py

# Now hand over to the main command passed by CMD
exec "$@"