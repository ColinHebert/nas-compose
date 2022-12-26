#!/bin/bash

if [ "$(cat /data/gotify_previous_ip || true)" != "$1" ]; then
    echo -n "$1" > /data/gotify_previous_ip

    curl -s "$GOTIFY_ADDRESS/message" \
        -X POST \
        -H "X-Gotify-Key: $GOTIFY_TOKEN" \
        -F "title=IP Address updated" \
        -F "message=IP address detected as $1" \
        -F "priority=5"
fi
