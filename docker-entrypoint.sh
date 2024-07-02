#!/bin/sh

# default container parameter
export NCDU_WEB_VIEWER_SCAN_FROM=${NCDU_WEB_VIEWER_SCAN_FROM:='folder'}
export NCDU_WEB_VIEWER_READONLY=${NCDU_WEB_VIEWER_READONLY:='yes'}

# Charge la crontab depuis le template
if [ "$NCDU_WEB_VIEWER_SCAN_FROM" = "dump" ]; then
    # execute ncdu and inject the dump file
    echo "Feature activated: NCDU_WEB_VIEWER_SCAN_FROM=dump"
    exec node . --port 3000 --base / --command 'ncdu -f /ncdu-dump.json'
else
    # execute ncdu on the folder
    if [ "$NCDU_WEB_VIEWER_READONLY" = "no" ]; then
        echo "Feature activated: NCDU_WEB_VIEWER_SCAN_FROM=folder"
        exec node . --port 3000 --base / --command 'ncdu /folder-to-scan/'
    else
        echo "Feature activated: NCDU_WEB_VIEWER_SCAN_FROM=folder (with NCDU_WEB_VIEWER_READONLY=yes)"
        exec node . --port 3000 --base / --command 'ncdu -r /folder-to-scan/'
    fi  
fi
