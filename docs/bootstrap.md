# Bootstrap

Set up a MacVLAN network

As an example, with the following network setup:
- interface to LAN: `bond0`
- Complete LAN subnet: `192.168.0.0/23`
- LAN gateway: `192.168.0.1`
- DHCP range: `192.168.0.0/24` (excluding gateway)
- MacVLAN interface name: `macvlan0` (user defined)
- MacVLAN range: `192.168.1.0/24` (should be outside of DHCP range)
- MacVLAN host IP: `192.168.1.1` (should be in the MacVLAN range)

```
docker network create -d macvlan -o parent=bond0 --subnet=192.168.0.0/23 --gateway=192.168.0.1 --ip-range=192.168.1.0/24 --aux-address "nas=192.168.1.1" macvlan
ip link add macvlan0 link bond0 type macvlan mode bridge
ip addr add 192.168.1.1/32 dev macvlan0
ip link set macvlan0 up
```

Run portainer once
```
docker run --rm -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce:latest
```

### Environment variables
- `NASCOMPOSE_SERVICES`: Absolute path to the `services` folder

## Docker
[`alpine/socat`](https://hub.docker.com/r/alpine/socat/) exposes the docker socket as a port.

### 🌐 Ports
- `2375 TCP`: Docker API

### 📂 Volumes
- `/var/run/docker.sock`: Socket file from host mounted as it to be exposed.

### 📒 Documentation
- [socat](https://linux.die.net/man/1/socat) manual

## Traefik
[`traefik`](https://hub.docker.com/_/traefik) is a reverse proxy for docker services.

### 🌐 Ports
- `80 TCP`: HTTP access. Should always redirect to HTTPs
- `443 TCP`: HTTPs access

### 📂 Volumes
- `traefik_dynamic_config`: Folder containing the dynamic configuration for `File` provider. See [traefik documentation](https://doc.traefik.io/traefik/providers/file/).

### 📝 Configs
- `traefik_config`: Static configuration from `File` provider. See [traefik documentation](https://doc.traefik.io/traefik/providers/file/).

### 🔒 Secrets
- `traefik_password`: Basic Auth username/password to access Traefik. Encoded using htpasswd (or [equivalent](https://hostingcanada.org/htpasswd-generator/)), use BCrypt at least.
- `traefik_tls_cert`: Self-signed certificate for Traefik. Particularly useful in development to avoid generating new certificates on each restart.
- `traefik_tls_key`: Self-signed private key for Traefik. Used with `traefik_tls_cert`.

### 📒 Documentation
- [Traefik](https://doc.traefik.io/) official documentation

## Portainer
[`portainer/portainer-ce`](https://hub.docker.com/r/portainer/portainer-ce) is a docker instance manager.
Useful to manage the stacks/docker-compose configuration for the NAS.

Set up to use the port exposed via the `Docker` container. It displays information about all docker resources available on the host. \
It excludes all resources with the tag `nas-compose.boostrap: true`.

Each compose file (except the `bootstrap.docker-compose.yaml`) need to be added as a [stack](https://docs.portainer.io/user/docker/stacks/add), with the right environment variables set.


### 🌐 Ports
- `9443 TCP`: HTTPs (self-signed) access to the web interface

### 📂 Volumes
- ⚠️ `portainer_data`: All configuration and application data related to portainer. **It contains sensitive files**

### 🔒 Secrets
- `portainer_password`: Admin default admin's password

### 📒 Documentation
- [Portainer](https://docs.portainer.io/) official documentation
