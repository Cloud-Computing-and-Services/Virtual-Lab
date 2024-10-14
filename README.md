
---


---

<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/255px-Flag_of_the_United_Kingdom_%281-2%29.svg.png" alt="enter image description here"></p>
<h2 id="department-engineering-informatics-and-computers">Department of Computer Engineering and Computer Science</h2>
<h3 id="cloud-computing-and-services laboratory">Cloud Computing and Services Laboratory</h3>
<h3 id="create-virtual-lab">Create Virtual Lab</h3>
<hr>
<h3 id="team-members">Team Members</h3>
<ul>
<li>Athanasiou Vasileios Evangelos | ice19390005</li>
<li>Theocharis Georgios | 19390283</li>
</ul>
<hr>
<h3 id="introduction">Introduction</h3>
<p>This project was created for the cloud computing lab and provides a virtual lab environment using Docker. Its purpose is to facilitate the development and management of various applications by providing many features and services. This README file briefly describes the project, its features and the services used.</p>
<hr>
<h3 id="features">Features</h3>
<p>The Docker project has the following features:</p>
<ul>
<li><strong>Individual Networks</strong>: Each virtual lab creates its own network, allowing secure communication between containers.</li>
<li><strong>Data Preservation</strong>: Provides storage for persistent data management, ensuring that data is preserved even if containers are restarted or stopped.</li>
<li><strong>Automatic Service Startup and Shutdown</strong>: Use shell scripts to automatically run and shutdown services without manual intervention.</li>.
<li><strong>Service Isolation</strong>: Each service runs in a separate container. WordPress is the main application, while MySQL manages the database. phpMyAdmin provides a graphical interface to manage the MySQL database.</li> The server is the main server.
<li><strong>Resource Management</strong>: Configure resources for optimal allocation and prevent memory problems. Docker Compose files define resource limits for all containers.</li>
</ul>
<hr>
<h3 id="used-services">Used Services</h3>
<p>The Docker project uses the following services:</p>
<ul>
<li><strong>WordPress</strong>.
<li><strong>MySQL</strong>: A popular open source relational database management system.</li>
<li><strong>phpMyAdmin</strong>: A graphical interface for MySQL database management, simplifying database administration.</li>
</ul>
<hr>
<h3 id="detailed-description-of-services">Detailed Description of Services</h3>
<h4 id="wordpress-container">WordPress Container</h4>
<p>The WordPress container is the main page for the project, allowing the creation and management of web pages.</p>
<p><strong>Configuration</strong></p>
<p>To implement the WordPress container, we use two Docker Compose files: <code>docker-compose.yaml</code> and <code>docker-compose.override.yaml</code>.</p>
<p><strong>docker-compose.override.yaml</strong></p>
<pre><code>
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

</code></pre>
<ul>
<li><strong><strong>container_name</strong>: Specify the name of the WordPress container as "wordpress".</li>
<li><strong>ports</strong>: We map port 8080 on the host to port 80 on the container, allowing access to WordPress via <a href="http://localhost:8080">http://localhost:8080</a>.</li>
<li><strong>restart</strong>: We ensure that the container restarts automatically if it stops or encounters an error.</li>
<li><strong>volumes</strong>: We create a volume named "/wp_data" and mount it in the container's "/var/www/html" directory. This allows WordPress files to be stored outside the container, preserving the data even if the container is stopped or removed.</li>
<li><strong><strong>environment</strong>: The environment variables are used to specify the connection between WordPress and the MySQL container.</li>
<li><strong>deploy</strong>: We set the resource limits for the container, including CPU and memory limitations.</li>
<li><strong>network</strong>: We connect the WordPress container to the "wordpressNetwork" network.</li>
</ul>.
<p><strong>docker-compose.yaml</strong></p>.
<pre><code>version: '3.8'

services:

wordpress:
image: wordpress:latest


networks:
vlab_network:
name: vlab_network
driver: bridge
</code></pre>
<ul>
<li>We run the WordPress service using the WordPress Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.</li>
<li>With <strong>"networks"</strong> we connect the WordPress container to the "vlab_network" network. We name the network separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"</li>.
</ul>
<p>Together, these Docker Compose files configure and deploy the WordPress container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.</p>
<hr>
<h4 id="mysql-container">MySQL Container</h4>.
<p>The MySQL container hosts the database used by WordPress.</p>
<p><strong>Configuration</strong></p>
<p>To implement the MySQL container, we use two Docker Compose files: <code>docker-compose.yaml</code> and <code>docker-compose.override.yaml</code>.<br>
<strong>docker-compose.override.yaml</strong></p>
<pre><code>version: '3.8'

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

</code></pre>
<ul>
<li><strong><strong>container_name</strong>: Specify the name of the MySQL container as "mysql".</li>
<li><strong>ports</strong>: We map the host port 3306 to the container port 3306, allowing access to the database through the MySQL client.</li>
<li><strong>restart</strong>: We ensure that the container restarts automatically if it stops or encounters an error.</li>
<li><strong>volumes</strong>: We create a volume named "/db_data" and mount it in the container's "/var/lib/mysql" directory. This allows the database data to be stored outside the container, preserving the data even if the container is stopped or removed.</li>
<li><strong><strong>environment</strong>: The environment variables are used to specify the database parameters.</li>
<li><strong>deploy</strong>: We set the resource limits for the container, including CPU and memory constraints.</li>
<li><strong>network</strong>: We connect the MySQL container to the "vlab_network" network.</li>
</ul>.
<p><strong>docker-compose.yaml</strong></p>.
<pre><code>version: '3.8'

services:

database:
image: mysql:5.7


networks:
vlab_network:
driver: bridge
external: true
</code></pre>
<ul>
<li>We run the MySQL service using the MySQL Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.</li>
<li>With <strong>"networks"</strong> we connect the MySQL container to the "vlab_network" network. We define the network name separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"</li>.
</ul>
<p>Together, these Docker Compose files configure and deploy the MySQL container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.</p>
<hr>
<h4 id="phpmyadmin-container">phpMyAdmin Container</h4>.
<p>The phpMyAdmin container provides a graphical interface for managing the MySQL database.</p>
<p><strong>Configuration</strong></p>.
<p>To implement the phpMyAdmin container, we use two Docker Compose files: <code>docker-compose.yaml</code> and <code>docker-compose.override.yaml</code>.<br>
<strong>docker-compose.override.yaml</strong></p>
<pre><code>version: '3.8'

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
</code></pre>
<ul>
<li><strong><strong>container_name</strong>: Specify the name of the phpMyAdmin container as "phpmyadmin".</li>
<li><strong>ports</strong>: We map port 8081 on the host to port 80 on the container, allowing access to phpMyAdmin via <a href="http://localhost:8081">http://localhost:8081</a>.</li>
<li><strong><strong>restart</strong>: We ensure that the container restarts automatically if it stops or encounters an error.</li>
<li><strong>environment</strong>: With the environment variables we specify the connection parameters to the MySQL container.</li>
<li><strong>deploy</strong>: We set the resource limits for the container, including CPU and memory constraints.</li>
<li><strong>network</strong>: We connect the phpMyAdmin container to the "vlab_network" network.</li>
</ul>.
<p><strong>docker-compose.yaml</strong></p>.
<pre><code>version: '3.8'

services:

phpmyadmin:
image: phpmyadmin/phpmyadmin


networks:
vlab_network:
driver: bridge
external: true
</code></pre>
<ul>
<li>We run the phpMyAdmin service using the phpMyAdmin Docker Image, which is pulled from Docker Hub with the latest tag if the image does not already exist on the machine.</li>
<li>With <strong>"networks"</strong> we connect the phpMyAdmin container to the "vlab_network" network. We define the network name separately in the networks section, specifying its name as "vlab_network" and the driver as "bridge"</li>.
</ul>
<p>Together, these Docker Compose files configure and deploy the phpMyAdmin container, ensuring that it is connected to the specified network and has access to the necessary resources and volumes.</p>

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTI4MzQ5OTQ1NCwtMTYyMjMzMDYxMSwtMT
M2MDgyMDY5Nl19
-->