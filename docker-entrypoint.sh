#!/bin/sh

# default container parameter
export NCDU_WEB_VIEWER_SCAN_FROM=${NCDU_WEB_VIEWER_SCAN_FROM:='folder'}

# Charge la crontab depuis le template
if [ "$NCDU_WEB_VIEWER_SCAN_FROM" = "dump" ]; then
    # execute ncdu and inject the dump file
    echo "Feature activated: NCDU_WEB_VIEWER_SCAN_FROM=dump"
    exec node . --port 3000 --base / --command 'ncdu -f /ncdu-dump.json'
else
    # execute ncdu on the folder
    echo "Feature activated: NCDU_WEB_VIEWER_SCAN_FROM=folder"
    exec node . --port 3000 --base / --command 'ncdu /folder-to-scan/'
fi
