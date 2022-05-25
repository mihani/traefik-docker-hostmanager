DC = docker compose

install-hostmanager:
	docker network create hostmanager
	$(DC) up -d

hostmanager:
	$(DC) up -d
