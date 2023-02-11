# Bootstrap
Initial setup of the NAS ecosystem, allow services to be managed via docker.

## Pre-requisites

When exposing ports via MacVLAN instances, set up a MacVLAN network. As an example, with the following network setup:
- Interface to LAN: `bond0`
- Complete LAN subnet: `192.168.0.0/23`
- LAN gateway: `192.168.0.1`
- DHCP range: `192.168.0.0/24` (excluding gateway)
- MacVLAN interface name: `macvlan0` (user defined)
- MacVLAN range: `192.168.1.0/24` (should be outside of DHCP range)
- MacVLAN host IP: `192.168.1.1` (should be in the MacVLAN range)

```
ip link add macvlan0 link bond0 type macvlan mode bridge
ip addr add 192.168.1.0/32 dev macvlan0
ip link set macvlan0 up
ip route add 192.168.1.0/24 dev macvlan0
```

To run the boostrap stack, use a temporary portainer container:
```
docker run --rm -p 9443:9443 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer-ce:latest
```

### Environment variables
- `NASCOMPOSE_SERVICES`: Absolute path to the `services` folder

When using MacVLAN:
- `NASCOMPOSE_MACVLAN_IFACE`: Interface to use as MacVLAN bridge (`bond0`)
- `NASCOMPOSE_MACVLAN_SUBNET`: Subnet used by the interface (`192.168.0.0/23`)
- `NASCOMPOSE_MACVLAN_GATEWAY`: LAN gateway (`192.168.0.1`)
- `NASCOMPOSE_MACVLAN_RANGE`: MacVLAN range (`192.168.1.0/24`)
- `NASCOMPOSE_MACVLAN_HOST_IP`: MacVLAN host IP (`192.168.1.0`)
- `NASCOMPOSE_MACVLAN_PORTAINER_IP`: IP adress reserved for portainer (`192.168.1.3`)

## Docker
[`alpine/socat`](https://hub.docker.com/r/alpine/socat/) exposes the docker socket as a port.

### 🌐 Ports
- `2375 TCP`: Docker API

### 📂 Volumes
- `/var/run/docker.sock`: Socket file from host mounted as it to be exposed.

### 📒 Documentation
- [socat](https://linux.die.net/man/1/socat) manual

## Portainer
[`portainer/portainer-ce`](https://hub.docker.com/r/portainer/portainer-ce) is a docker instance manager.
Useful to manage the stacks/docker-compose configuration for the NAS.

Set up to use the port exposed via the `Docker` container. It displays information about all docker resources available on the host. \
It excludes all resources with the tag `nas-compose.boostrap: true`.

Each service (except `bootstrap/docker-compose.yaml`) needs to be added as a [stack](https://docs.portainer.io/user/docker/stacks/add), with the right environment variables set.

### 🌐 Ports
The instance is exposed either directly (when using `MacVLAN`), otherwise it is exposed from the host machine
- `9443 TCP`: HTTPs (self-signed) access to the web interface

### 📂 Volumes
- ⚠️ `portainer_data`: All configuration and application data related to portainer. **It contains sensitive files**

### 🔒 Secrets
- `portainer_password`: Admin default admin's password

### 📒 Documentation
- [Portainer](https://docs.portainer.io/) official documentation
