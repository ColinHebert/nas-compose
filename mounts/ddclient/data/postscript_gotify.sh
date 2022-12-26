#!/bin/bash
curl "$GOTIFY_ADDRESS/message" \
    -X POST \
    -H "X-Gotify-Key: $GOTIFY_TOKEN" \
    -F "title=IP Address updated" \
    -F "message=IP address detected as $1" \
    -F "priority=5"
