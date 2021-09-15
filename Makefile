include srcs/.env

COMPOSE_FILE	= ./srcs/docker-compose.yml
VOLUMES			= $(shell docker volume ls -q)

up: $(DATA_DIR) host
	docker-compose -f $(COMPOSE_FILE) up --build -d

host:
	echo "127.0.0.1 $(DOMAIN_NAME)" | sudo tee -a /etc/hosts

down:
	docker-compose -f $(COMPOSE_FILE) down

nginx wordpress mariadb:
	docker-compose -f $(COMPOSE_FILE) exec $@ /bin/sh

clean: down
	docker volume rm $(VOLUMES)

$(DATA_DIR):
	mkdir -p $(DATA_DIR)/db-data $(DATA_DIR)/wp-data

re: down up
