#!/bin/bash

NETWORK="vlab_network"
WORDPRESS="../Wordpress"
MYSQL="../MySQL"
PHPMYADMIN="../phpMyAdmin"
COMPOSE_FILE="docker-compose.yaml"
COMPOSE_FILE_OVERRIDE="docker-compose.override.yaml"

down_containers() {
    echo "Stopping WordPress..."
    (cd $WORDPRESS && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

    echo "Stopping phpMyAdmin..."
    (cd $PHPMYADMIN && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

    echo "Stopping MySQL..."
    (cd $MYSQL && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

    docker network rm $NETWORK 
   
}

down_containers

exit 0

