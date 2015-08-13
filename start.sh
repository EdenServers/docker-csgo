#!/bin/bash
cd /server/csgo && ./steamcmd.sh +login anonymous \
                 +force_install_dir /server/csgo \
                 +app_update 740 validate \
                 +quit

cd /server/csgo && ./srcds_run -game csgo -console -usercon +game_type $GAME_TYPE \
                               +game_mode $GAME_MODE \
                               +mapgroup $MAPGROUP \
                               +map $MAP
