# Traefik Docker Hostmanager

## Requirements

* [Docker](https://docs.docker.com/engine/install/)

## Usage

### First time

Create `hostmanager` network then run container

```shell
docker network create hostmanager && docker run -d --name traefik-docker-hostmanager -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -p 443:443 -p 8080:8080 --network hostmanager mihani/traefik-docker-hostmanager
```

### Every time

```shell
docker run -d --name traefik-docker-hostmanager -v /var/run/docker.sock:/var/run/docker.sock -p 80:80 -p 443:443 -p 8080:8080 --network hostmanager mihani/traefik-docker-hostmanager
```

You can run previous commands with docker option `--restart=always` to start container at OS start 
