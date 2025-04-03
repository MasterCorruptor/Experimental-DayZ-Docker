#!/bin/bash

# Definer SteamCMD-katalog og serverkatalog
STEAMCMD_DIR="/home/kjetil/dayz_docker/steamcmd"
SERVER_DIR="/home/kjetil/dayz_docker/server"

# Logg inn i SteamCMD og last ned mods
while IFS= read -r MOD; do
    # Ignorerer tomme linjer og linjer som begynner med #
    if [[ ! "$MOD" =~ ^#.*$ ]] && [[ ! -z "$MOD" ]]; then
        $STEAMCMD_DIR/steamcmd.sh +login anonymous +workshop_download_item 221100 $MOD +quit
    fi
done < mods.txt
