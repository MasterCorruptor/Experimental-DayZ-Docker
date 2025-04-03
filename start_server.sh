#!/bin/bash

# Last ned mods
./download_mods.sh

# Opprett systemiske lenker for mods og .bikey-filer
./opprett_symlink.sh

# Sett opp modifikasjonene som skal brukes
MOD_LIST=""
while IFS= read -r MOD; do
    # Ignorerer tomme linjer og linjer som begynner med #
    if [[ ! "$MOD" =~ ^#.*$ ]] && [[ ! -z "$MOD" ]]; then
        MOD_LIST+="@workshop/$MOD;"
    fi
done < mods.txt

# Fjern siste semikolon
MOD_LIST=${MOD_LIST%?}

# Start serveren med mods
./DayZServer_x64 -config=serverDZ.cfg -mod=$MOD_LIST -port=2302 -profiles=./profiles -dologs -adminlog -netlog -freezecheck
