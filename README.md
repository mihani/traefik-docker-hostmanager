# Traefik Docker Hostmanager

## Requirements

* [Docker](https://docs.docker.com/engine/install/)

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

By default you didn't precise name for the default network and docker compose use `default` as name for network. Now we need to name you internal network and add `hostmanager` as external network.
```yaml
networks:
  internal-project-network:
    name: internal-project-network
    external: false
  hostmanager:
    external: true
```

#### 2. Add network at your container

You need to add the previous networks on each containers you need to detect by Traefik

```yaml
networks:
  - internal-project-network
  - hostmanager
```

#### 3. Add label on container

You need to tell at Traefik which container needs routing from Traefik. Traefik use [docker label system](https://docs.docker.com/config/labels-custom-metadata/) to recognize and redirect the request to the good service.
```yaml
labels:
  - "traefik.enable=true"
  - "traefik.http.routers.{service-name}.rule=Host(`my-webserver.localhost`)"
  - "traefik.http.routers.{service-name}.tls=true"
```
The previous label is the minimum you need to use. Thanks to ``"traefik.http.routers.{service-name}.rule=Host(`my-webserver.localhost`)"`` that add the url you will use to call the container in your web browser.


Now you just need to call name use in `Host` rule to access at you container.
