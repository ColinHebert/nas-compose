#!/bin/sh

# Workaround for https://github.com/haugene/docker-transmission-openvpn/pull/2480
if [[ -f /run/secrets/rpc_creds ]]; then
  export TRANSMISSION_RPC_USERNAME=$(head -1 /run/secrets/rpc_creds)
  export TRANSMISSION_RPC_PASSWORD=$(tail -1 /run/secrets/rpc_creds)
fi
echo "${TRANSMISSION_RPC_USERNAME}" > /config/transmission-credentials.txt
echo "${TRANSMISSION_RPC_PASSWORD}" >> /config/transmission-credentials.txt
