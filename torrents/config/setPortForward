#!/command/with-contenv bash
listen_port=$(python3 /py-natpmp/natpmp/natpmp_client.py -g 10.2.0.1 0 0 | sed -E 's/.*?public port ([0-9]+).*?/\1/')
curl -F "json={\"listen_port\": ${listen_port}}" http://localhost:8080/api/v2/app/setPreferences
