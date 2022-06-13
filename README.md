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
