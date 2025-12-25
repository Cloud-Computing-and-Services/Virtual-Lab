<p align="center">
  <img src="https://www.especial.gr/wp-content/uploads/2019/03/panepisthmio-dut-attikhs.png" alt="UNIWA" width="150"/>
</p>

<p align="center">
  <strong>UNIVERSITY OF WEST ATTICA</strong><br>
  SCHOOL OF ENGINEERING<br>
  DEPARTMENT OF COMPUTER ENGINEERING AND INFORMATICS
</p>

<hr/>

<p align="center">
  <strong>Cloud Computing and Services</strong>
</p>

<h1 align="center" style="letter-spacing: 1px;">
  Virtual Lab – Dockerized Cloud Services
</h1>

<p align="center">
  <strong>Vasileios Evangelos Athanasiou</strong><br>
  Student ID: 19390005<br>
  <strong>Georgios Theocharis</strong><br>
  Student ID: 19390283<br>  
</p>

<p align="center">
  Supervisor: Apostolos Anagnostopoulos, Special Technical Laboratory Staff<br>
</p>

<p align="center">
  Athens, June 2024
</p>

# Installation and Configuration Instructions

The shell scripts [up.sh](src/install/) and [down.sh](src/install/) automate the process of automatically running services and shutting them down respectively.

## up.sh

```bash
#!/bin/bash

NETWORK="vlab_network"
WORDPRESS="../Wordpress"
MYSQL="../MySQL"
PHPMYADMIN="../phpMyAdmin"
COMPOSE_FILE="docker-compose.yaml"
COMPOSE_FILE_OVERRIDE="docker-compose.override.yaml"

up_containers() {
docker network create $NETWORK 

echo "Starting MySQL..."
(cd $MYSQL && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Starting phpMyAdmin..."
(cd $PHPMYADMIN && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Starting WordPress..."
(cd $WORDPRESS && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)
}

up_containers

exit 0
```
- **NETWORK:** The name of the Docker network to be created.
- **WORDPRESS:** The filepath where the docker-compose files for running the Wordpress service are located.
- **MYSQL:** The filepath where the docker-compose files for running the MySQL service are located.
- **PHPMYADMIN:** The relative path to the phpMyAdmin Docker installation directory.
- **COMPOSE_FILE:** The name of the main Docker Compose file that creates the image of each service and configures the network.
- **COMPOSE_FILE_OVERRIDE:** The name of the Docker Compose override file that contains all the configs for each service.

## down.sh
```bash
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
```
To install and configure this project, follow these steps:

1. Clone the repository by running the command
```
git clone https://github.com/Cloud-Computing-and-Services/Virtual-Lab.git
```
2. Go to the project directory by pressing the command
```
cd Virtual-Lab/src
```
3. Go to the install directory, where the bash scripts that automate the startup and shutdown of the project are located
```
cd install
```
4. Start the project by running the bash script by pressing the command
```
./up.sh
```
5. Open your browser and visit the services at the following links:
- Wordpress
http://localhost:8080

- MySQL
http://localhost:3306

- phpMyAdmin
http://localhost:8081

Use phpMyAdmin to manage the MySQL database and configure the database for WordPress.

To stop the services from running, follow these steps:

1. Go to the `install` directory, where the bash scripts that automate starting and stopping the project are located
```
cd install
```
2. Terminate the project by running the bash script by pressing the command
```
./down.sh
```
To summarize, with the above shell scripts we can create or remove the containers of the 3 services of the application. Removing the containers includes removing the network that the containers communicate with. The data volumes remain as they are.