NETWORK := vlab_network

WORDPRESS := ../Wordpress
MYSQL := ../MySQL
PHPMYADMIN := ../phpMyAdmin

up:
	docker network create $(NETWORK)
	cd $(WORDPRESS) && docker compose -f docker-compose.yaml up --build
	cd $(MYSQL) && docker compose -f docker-compose.yaml up --build
	cd $(PHPMYADMIN) && docker compose -f docker-compose.yaml up --build

down:
	cd $(MYSQL) && docker compose -f docker-compose.yaml down
	cd $(PHPMYADMIN) && docker compose -f docker-compose.yaml down
	cd $(WORDPRESS) && docker compose -f docker-compose.yaml down
	docker network rm $(NETWORK)
