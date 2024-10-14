---


---
![Alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/255px-Flag_of_the_United_Kingdom_%281-2%29.svg.png)


# Department of Informatics and Computer Engineering

## Cloud Computing and Services Laboratory

### Virtual Lab Creation

---

## Team Members
- Athanasiou Vasileios Evangelos | ice19390005
- Theocharis Georgios | 19390283

---

## Introduction

This project was created for the Cloud Computing Laboratory and offers a virtual lab environment using Docker. The aim is to facilitate the development and management of various applications by providing numerous features and services. This README file provides an overview of the project, its features, and the services used.

---

## Features

The Docker project includes the following features:

- **Isolated Networks**: Each virtual lab creates its own network, allowing secure communication between containers.
- **Data Persistence**: It provides storage options for persistent data management, ensuring data retention even if containers are restarted or stopped.
- **Automatic Service Start and Stop**: Shell scripts are used to automatically start and stop services without manual intervention.
- **Service Isolation**: Each service runs in a separate container. WordPress is the main application, while MySQL manages the database. phpMyAdmin offers a graphical interface for managing the MySQL database.
- **Resource Management**: Resource configuration for optimal allocation and prevention of memory issues. Docker Compose files define resource limits for all containers.

---

## Services Used

The Docker project uses the following services:

- **WordPress**: A popular content management system for creating and managing websites.
- **MySQL**: A well-known open-source relational database management system.
- **phpMyAdmin**: A graphical interface for managing MySQL databases, simplifying database management.

---

## Detailed Description of Services

### WordPress Container

The WordPress container is the main page for the project, allowing for the creation and management of websites.

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






<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEzNjA4MjA2OTZdfQ==
-->