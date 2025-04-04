#!/bin/bash

# Definer modifikasjonene som skal brukes
MOD_DIR="/home/kjetil/dayz_docker/server"

# Naviger gjennom hver mod i mods.txt
while IFS= read -r MOD; do
    # Ignorerer tomme linjer og linjer som begynner med #
    if [[ ! "$MOD" =~ ^#.*$ ]] && [[ ! -z "$MOD" ]]; then
        MOD_PATH="$MOD_DIR/steamapps/workshop/content/221100/$MOD"
        
        # Opprett systemiske lenker for mod-mappen
        ln -s "$MOD_PATH" "$MOD_DIR/$MOD"

        # Sjekk etter forskjellige varianter av "keys"-mappen
        if [ -d "$MOD_PATH/keys" ]; then
            KEYS_DIR="$MOD_PATH/keys"
        elif [ -d "$MOD_PATH/Keys" ]; then
            KEYS_DIR="$MOD_PATH/Keys"
        elif [ -d "$MOD_PATH/KEYS" ]; then
            KEYS_DIR="$MOD_PATH/KEYS"
        else
            echo "Ingen 'keys'-mappe funnet for mod: $MOD"
            continue
        fi

        # Opprett systemiske lenker for .bikey-filer
        ln -s "$KEYS_DIR"/* "$MOD_DIR/keys/"
        
        # Verifisere de opprettede lenkene
        echo "Verifiserte lenker for mod: $MOD"
        ls -l "$MOD_DIR/keys/"
    fi
done < mods.txt
