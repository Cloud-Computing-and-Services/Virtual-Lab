![Alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/255px-Flag_of_the_United_Kingdom_%281-2%29.svg.png)

# Department of Informatics and Computer Engineering 

# Cloud Computing and Services

# Create Virtual Lab

# Work items

**Lab Manager:** [Anagnostopoulos Apostolos](https://ice.uniwa.gr/emd_person/17574/)  
**Delivery date:** 25/6/2024  
**Submission Deadline:** 25/6/2024

# Team Details

- [ ] **Student 1**  
**Name:** Athanasiou Vasileios Evangelos  
**Student ID:** 19390005  

- [ ] **Student 2**  
**Name:** Theocharis Georgios  
**Student ID:** 19390283  

# Installation and Configuration Instructions

The shell scripts [up.sh](install/) and [down.sh](install/) automate the process of automatically running services and shutting them down respectively.

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
cd Virtual-Lab
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