#!/bin/sh
echo "Setting up directory structure..."
./setup_directories.sh $1
./download-resolve.sh $1
chmod +x ./DaVinci_Resolve_*_Linux.run
./setup_resolve.sh
install -Dm755 resolve.sh /app/bin/resolve.sh
