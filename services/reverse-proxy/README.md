# Reverse-Proxy
Creates a reverse proxy to expose other services running in the NAS

## Traefik
[`traefik`](https://hub.docker.com/_/traefik) is a reverse proxy for docker services.

### 🌐 Ports
- `80 TCP`: HTTP access. Should always redirect to HTTPs
- `443 TCP`: HTTPs access

### 📂 Volumes
- `traefik_dynamic_config`: Folder containing the dynamic configuration for `File` provider. See [traefik documentation](https://doc.traefik.io/traefik/providers/file/).

### 📝 Configs
- `traefik.yml`: [Static configuration file](https://doc.traefik.io/traefik/providers/file/)
- `dynamic/authelia.yml`: [HTTP ForwardAuth](https://doc.traefik.io/traefik/middlewares/http/forwardauth/) middlewares to authenticate via the authentication service (Authelia)
- `dynamic/hsts.yml`: Set of HTTP headers to enable [HSTS](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security)
- `dynamic/htransformation.yml`: HTTP header conversion via [htransformation](https://github.com/tommoulard/htransformation) to enable authentication on some services
- `dynamic/portainer.yml`: Route exposing Portainer
- `dynamic/synology.yml`: Route exposing the Synology DSM interface of the host
- `dynamic/tls.yml`: [TLS](https://doc.traefik.io/traefik/https/tls/) configuration of the instance
- `dynamic/traefik.yml`: Route exposing the Traefik API/Dashboard
- `dynamic/qbittorrent-api.yml`: Special case exposing the API of qBittorrent with BasicAuth managed by the Authentication service

### 🔒 Secrets
- `traefik_tls_cert`: Self-signed certificate for Traefik. Particularly useful in development to avoid generating new certificates on each restart.
- `traefik_tls_key`: Self-signed private key for Traefik. Used with `traefik_tls_cert`.

### 📒 Documentation
- [Traefik](https://doc.traefik.io/) official documentation
