#!/bin/sh
set -e
if [ -z "$PORT" ]; then PORT=1880; fi
export PORT
if [ ! -f $SNAP_DATA/settings.js ]; then
    if [ -f $SNAP_USER_DATA/settings.js ]; then
        echo "MIGRATE - Move settings.js to "$SNAP_DATA
        mv $SNAP_USER_DATA/* $SNAP_DATA/
    else
        echo "NEW - Copy settings.js to "$SNAP_DATA
        cp $SNAP/lib/node_modules/node-red/settings.js $SNAP_DATA/
    fi
fi
echo NOW STARTING NODE-RED : $SNAP/bin/node-red -u $SNAP_DATA on port $PORT
"$SNAP"/bin/node "$SNAP"/lib/node_modules/.bin/node-red -u "$SNAP_DATA" "$SNAP_DATA/flows.json"
