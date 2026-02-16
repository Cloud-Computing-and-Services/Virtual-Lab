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
  Student ID: 19390005
</p>

<p align="center">
  <a href="https://github.com/Ath21" target="_blank">GitHub</a> ·
  <a href="https://www.linkedin.com/in/vasilis-athanasiou-7036b53a4/" target="_blank">LinkedIn</a>
</p>

<p align="center">
  <strong>Georgios Theocharis</strong><br>
  Student ID: 19390283
</p>

<p align="center">
  <a href="https://github.com/geotheo01" target="_blank">GitHub</a>
</p>

<p align="center">
  Supervisor: Vasileios Mamalis, Professor
</p>
<p align="center">
  <a href="https://ice.uniwa.gr/en/emd_person/vassilios-mamalis/" target="_blank">UNIWA Profile</a>
</p>

<p align="center">
  Co-supervisor: Apostolos Anagnostopoulos, Special Technical Laboratory Staff<br>
</p>

<p align="center">
  <a href="https://ice.uniwa.gr/emd_person/17574/" target="_blank">UNIWA Profile</a>
</p>

<p align="center">
  Athens, June 2024
</p>

---

# Project Overview

This project was created for the cloud computing lab and provides a virtual lab environment using Docker. Its purpose is to facilitate the development and management of various applications by providing many features and services. This README file briefly describes the project, its features, and the services used.

---

## Table of Contents

| Section | Folder / File | Description |
|------:|---------------|-------------|
| 1 | `assign/` | Virtual Lab assignment material |
| 1.1 | `assign/exercise-2024.adoc.pdf` | Assignment description in English |
| 1.2 | `assign/άσκηση-2024.adoc.pdf` | Assignment description in Greek |
| 2 | `src/` | Source files and installation scripts for the lab environment |
| 2.1 | `src/install/` | Scripts for environment setup |
| 2.1.1 | `down.sh` | Script to bring down the lab environment |
| 2.1.2 | `up.sh` | Script to start the lab environment |
| 2.2 | `src/MySQL/` | MySQL service configuration |
| 2.2.1 | `docker-compose.yaml` | Default MySQL Compose configuration |
| 2.2.2 | `docker-compose.override.yaml` | Overrides for MySQL Compose setup |
| 2.3 | `src/phpMyAdmin/` | phpMyAdmin service configuration |
| 2.3.1 | `docker-compose.yaml` | Default phpMyAdmin Compose configuration |
| 2.3.2 | `docker-compose.override.yaml` | Overrides for phpMyAdmin Compose setup |
| 2.4 | `src/Wordpress/` | Wordpress service configuration |
| 2.4.1 | `docker-compose.yaml` | Default Wordpress Compose configuration |
| 2.4.2 | `docker-compose.override.yaml` | Overrides for Wordpress Compose setup |
| 3 | `INSTALL.md` | Instructions to install and set up the Virtual Lab |
| 4 | `README.md` | Repository overview and usage instructions |

---

### Features

The Docker project has the following features:

- **Individual Networks**: Each virtual lab creates its own network, allowing secure communication between containers.
- **Data Preservation**: Provides storage for persistent data management, ensuring that data is preserved even if containers are restarted or stopped.
- **Automatic Service Startup and Shutdown**: Use shell scripts to automatically run and shutdown services without manual intervention.
- **Service Isolation**: Each service runs in a separate container. WordPress is the main application, while MySQL manages the database. phpMyAdmin provides a graphical interface to manage the MySQL database.
- **Resource Management**: Configure resources for optimal allocation and prevent memory problems. Docker Compose files define resource limits for all containers.

---

### Used Services

The Docker project uses the following services:

- **WordPress**: A popular content management system for creating and managing websites.
- **MySQL**: A popular open-source relational database management system.
- **phpMyAdmin**: A graphical interface for MySQL database management, simplifying database administration.

---

### Detailed Description of Services

#### WordPress Container

The WordPress container is the main page for the project, allowing the creation and management of web pages.

**Configuration**

To implement the WordPress container, we use two Docker Compose files: `docker-compose.yaml` and `docker-compose.override.yaml`.

**docker-compose.override.yaml**

```yaml
version: '3.8'

services: 
    wordpress:
        container_name: wordpress
        ports:
         - '8080:80'
        restart: always
        volumes:
         - /wp_data:/var/www/html
        environment:
         WORDPRESS_DB_HOST: database
         WORDPRESS_DB_USER: wordpress
         WORDPRESS_DB_PASSWORD: apostolos
         WORDPRESS_DB_NAME: wordpress
        deploy:
          resources:
            limits:
              cpus: '0.10'
              memory: 500M
            reservations:
              cpus: '0.05'
              memory: 50M 
        networks:
          - vlab_network
volumes:
    data:
      driver: local
```
- **container_name:** Specify the name of the WordPress container as "wordpress".
- **ports:** We map port 8080 on the host to port 80 on the container, allowing access to WordPress via http://localhost:8080.
- **restart:** We ensure that the container restarts automatically if it stops or encounters an error.
- **volumes:** We create a volume named "/wp_data" and mount it in the container's "/var/www/html" directory. This allows WordPress files to be stored outside the container, preserving the data even if the container is stopped or removed.
- **environment:** The environment variables are used to specify the connection between WordPress and the MySQL container.
- **deploy:** We set the resource limits for the container, including CPU and memory limitations.
- **network:** We connect the WordPress container to the "wordpressNetwork" network.

**docker-compose.yaml**
```yaml
version: '3.8'

services:

  wordpress:
    image: wordpress:latest
   
      
networks:
    vlab_network:
        name: vlab_network
        driver: bridge
```
- We run the WordPress service using the WordPress Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.
- With **"networks"** we connect the WordPress container to the "vlab_network" network. We name the network separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"

Together, these Docker Compose files configure and deploy the WordPress container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.

---

#### MySQL Container

The MySQL container hosts the database used by WordPress.

**Configuration**

To implement the MySQL container, we use two Docker Compose files: `docker-compose.yaml` and `docker-compose.override.yaml`.

**docker-compose.override.yaml**

```yaml
version: '3.8'

services: 
    database:
        container_name: mysql_database
        ports:
         - '3306:3306'
        restart: always
        volumes:
         - /db_data:/var/lib/mysql
        environment:
         MYSQL_ROOT_PASSWORD: apostolos
         MYSQL_DATABASE: wordpress
         MYSQL_USER: wordpress
         MYSQL_PASSWORD: apostolos
        
        deploy:
         resources:
            limits:
              cpus: '0.10'
              memory: 500M
            reservations:
              cpus: '0.05'
              memory: 50M         
        
        networks:
          - vlab_network

volumes:
    data:
        driver: local
```
- **container_name:** Specify the name of the MySQL container as "mysql".
- **ports:** We map the host port 3306 to the container port 3306, allowing access to the database through the MySQL client.
- **restart:** We ensure that the container restarts automatically if it stops or encounters an error.
- **volumes:** We create a volume named "/db_data" and mount it in the container's "/var/lib/mysql" directory. This allows the database data to be stored outside the container, preserving the data even if the container is stopped or removed.
- **environment:** The environment variables are used to specify the database parameters.
- **deploy:** We set the resource limits for the container, including CPU and memory constraints.
- **network:** We connect the MySQL container to the "vlab_network" network.

**docker-compose.yaml**
```yaml
version: '3.8'

services:

  database:
    image: mysql:5.7
   
      
networks:
    vlab_network:
        driver: bridge
        external: true
```
- We run the MySQL service using the MySQL Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.
- With **"networks"** we connect the MySQL container to the "vlab_network" network. We define the network name separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"

Together, these Docker Compose files configure and deploy the MySQL container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.

---

#### phpMyAdmin Container

The phpMyAdmin container provides a graphical interface for managing the MySQL database.

**Configuration**

To implement the phpMyAdmin container, we use two Docker Compose files: `docker-compose.yaml` and `docker-compose.override.yaml`.

**docker-compose.override.yaml**

```yaml
version: '3.8'

services: 
    phpmyadmin:
        container_name: phpMyAdmin_CLI
        ports:
         - '8081:80'
        restart: always
        environment:
          PMA_HOST: database
          PMA_USER: wordpress
          PMA_PASSWORD: apostolos
        deploy:
          resources:
            limits:
              cpus: '0.10'
              memory: 200M
            reservations:
              cpus: '0.05'
              memory: 50M         
 
        networks:
          - vlab_network
volumes:
    data:
      driver: local
```
- **container_name:** Specify the name of the phpMyAdmin container as "phpmyadmin".
- **ports:** We map port 8081 on the host to port 80 on the container, allowing access to phpMyAdmin via http://localhost:8081.
- **restart:** We ensure that the container restarts automatically if it stops or encounters an error.
- **environment:** With the environment variables we specify the connection parameters to the MySQL container.
- **deploy:** We set the resource limits for the container, including CPU and memory constraints.
- **network:** We connect the phpMyAdmin container to the "vlab_network" network.

**docker-compose.yaml**
```yaml
version: '3.8'

services:

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
   
      
networks:
    vlab_network:
        driver: bridge
        external: true
```
- We run the phpMyAdmin service using the phpMyAdmin Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.
- With **"networks"** we connect the phpMyAdmin container to the "vlab_network" network. We define the network name separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"

Together, these Docker Compose files configure and deploy the phpMyAdmin container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.
