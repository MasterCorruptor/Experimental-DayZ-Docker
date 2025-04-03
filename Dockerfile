# Bruk en Ubuntu base image
FROM ubuntu:20.04

# Installere nødvendige pakker
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    lib32gcc1 \
    lib32stdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Opprette kataloger og flytte SteamCMD zip-fil
RUN mkdir -p /home/kjetil/dayz_docker/steamcmd /home/kjetil/dayz_docker/server /home/kjetil/dayz_docker/steamapps/workshop/content/221100
COPY steamcmd.zip /home/kjetil/dayz_docker/steamcmd/steamcmd.zip

# Installere SteamCMD
RUN cd /home/kjetil/dayz_docker/steamcmd && \
    unzip steamcmd.zip && \
    chmod +x steamcmd.sh && \
    ./steamcmd.sh +login anonymous +force_install_dir /home/kjetil/dayz_docker/server +app_update 223350 validate +quit

# Definere arbeidskatalog
WORKDIR /home/kjetil/dayz_docker/server

# Kopiere skript for å laste ned mods og starte serveren
COPY download_mods.sh /home/kjetil/dayz_docker/server/
COPY start_server.sh /home/kjetil/dayz_docker/server/
COPY opprett_symlink.sh /home/kjetil/dayz_docker/server/
COPY serverDZ.cfg /home/kjetil/dayz_docker/server/
COPY mods.txt /home/kjetil/dayz_docker/server/

# Gjøre skriptene kjørbare
RUN chmod +x /home/kjetil/dayz_docker/server/download_mods.sh /home/kjetil/dayz_docker/server/start_server.sh /home/kjetil/dayz_docker/server/opprett_symlink.sh

# Definere kommando for å kjøre startskriptet
CMD ["./start_server.sh"]
