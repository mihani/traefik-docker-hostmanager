# Traefik Docker Hostmanager

## Requirements

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://docs.docker.com/compose/install)

## Usage

### Install

Create `hostmanager` network then run container

```shell
docker network create hostmanager && docker run -d --name traefik-docker-hostmanager --restart=always -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -p 443:443 -p 8080:8080 --network hostmanager mihani/traefik-docker-hostmanager
```

In previous commands docker option `--restart=always` allow to start container when Docker Engine start

### Traefik Dashboard

You can access to traefik dashboard with this url : `https://traefikboard.localhost`

### Edit your docker-compose

#### 1. Edit your network declaration

By default, you didn't precise name for the default network and docker compose use `default` as name for network. Now we need to name you internal network and add `hostmanager` as external network.
```yaml
networks:
  internal-project-network-name:
    name: internal-project-network-name
    external: false
  hostmanager:
    external: true
```

#### 2. Add network at your container

You need to add the previous networks on each container you need to detect by Traefik

```yaml
networks:
  - internal-project-network-name
  - hostmanager
```

#### 3. Add label on container

You need to tell at Traefik which container needs routing from Traefik. Traefik use [docker label system](https://docs.docker.com/config/labels-custom-metadata/) to recognize and redirect the request to the good service.
:rotating_light: On your host label, you need to keep the keywork `localhost`
```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.{service-name}.rule=Host(`custom-name.localhost`)"
  - "traefik.http.routers.{service-name}.tls=true"
```
The previous label is the minimum you need to use. Thanks to ``"traefik.http.routers.{service-name}.rule=Host(`custom-name.localhost`)"`` that add the url you will use to call the container in your web browser.

Example of service declaration with minimal information needed :
```yaml
  whoami:
    image: whoami/image
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.whoami.rule=Host(`whoami.localhost`)"
      - "traefik.http.routers.whoami.tls=true"
    networks:
      - hostmanager
      - internal-project-network-name
#   Rest of docker-compose configuration
```

Now you just need to call name use in `Host` rule to access at you container, in your favorite browser.
