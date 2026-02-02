#!/bin/bash

mkdir -p ./{config/{jellyfin,immich,n8n,radarr,prowlarr,qbittorrent,vaultwarden,bazarr,unmanic,sonarr},data/{movies,tvshows,photos,downloads,vault},cache/unmanic}

sudo chown -R $USER:$USER .
chmod -R 777 .

echo "✅ Directories ready for the full suite."