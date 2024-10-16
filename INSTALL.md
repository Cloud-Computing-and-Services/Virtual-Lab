
---


---

<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Flag_of_the_United_Kingdom_%281-2%29.svg/255px-Flag_of_the_United_Kingdom_%281-2%29.svg.png" alt="enter image description here"></p>
<h1 id="department-engineering-informatics-and-computers">Department of Informatics and Computer Engineering Science</h1>
<h1 id="cloud-computing-and-services">Cloud Computing and Services</h1>
<h1 id="create-virtual-lab">Create Virtual Lab</h1>
<h1 id="work-items">Work items</h1>
<p><strong>Lab Manager:</strong> Anagnostopoulos Apostolos<br>
<strong>Delivery date:</strong> 25/6/2024<br>
<strong>Submission Deadline:</strong> 25/6/2024</p>
<h1 id="team-elements">Team Details</h1>
<ul>
<li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled=""> 

<strong>Student 1</strong></li>
</ul>
<p><strong>Name:</strong> Athanasiou Vasileios Evangelos<br>
<strong>Student ID:</strong> 19390005</p> <strong>
<ul>
<li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled=""> 

<strong>Student 2</strong></li>
</ul>
<p><strong>Name:</strong> Theocharis Georgios<br>
<strong>Student ID:</strong> 19390283</p> <strong>
<h1 id="installation-and-configuration instructions">Installation and Configuration Instructions</h1>
<p>The shell scripts <a href="http://up.sh">up.sh</a> and <a href="http://down.sh">down.sh</a> automate the process of automatically running services and shutting them down respectively.</p>
<h2 id="up.sh"><a href="http://up.sh">up.sh</a></h2>

[source, bash]  
----
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
(cd $MYSQL &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Starting phpMyAdmin..."
(cd $PHPMYADMIN &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Starting WordPress..."
(cd $WORDPRESS &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)
}

up_containers

exit 0
---
<ul>
<li>
<p><strong>NETWORK:</strong> The name of the Docker network to be created.</p>
</li>
<li>
<p><strong>WORDPRESS:</strong> The filepath where the docker-compose files for running the Wordpress service are located</p>
</li>
<li>
<p><strong>MYSQL:</strong> The filepath where the docker-compose files for running the MySQL service are located</p> </p>
</li>
<li>
<p><strong>PHPMYADMIN:</strong> The relative path to the phpMyAdmin Docker installation directory.</p>
</li>
<li>
<p><strong>COMPOSE_FILE:</strong> The name of the main Docker Compose file that creates the image of each service and configures the network.</p>
</li>
<li>
<p><strong>COMPOSE_FILE_OVERRIDE:</strong> The name of the Docker Compose override file that contains all the configs for each service.</p>


<h2 id="down.sh"><a href="http://down.sh">down.sh</a></h2>

<pre><code>#!/bin/benter code hereash

NETWORK="vlab_network"
WORDPRESS="../Wordpress"
MYSQL="../MySQL"
PHPMYADMIN="../phpMyAdmin"
COMPOSE_FILE="docker-compose.yaml"
COMPOSE_FILE_OVERRIDE="docker-compose.override.yaml"

down_containers() {
echo "Stopping WordPress..."
(cd $WORDPRESS &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

echo "Stopping phpMyAdmin..."
(cd $PHPMYADMIN &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

echo "Stopping MySQL..."
(cd $MYSQL &amp;&amp; docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE down)

docker network rm $NETWORK 


}

down_containers

exit 0
</code></pre>
</li>
</ul>
<p>To install and configure this project, follow these steps:</p>
<ol>
<li>
<p>Clone the repository by pressing the command</p>
<pre><code>git clone https://github.com/Cloud-Computing-and-Services/Virtual-Lab.git
</code></pre>
</li>
<li>
<p>Go to the project directory by pressing the command</p>
<pre><code>cd Virtual-Lab
</code></pre>
</li>
<li>
<p>Go to the <strong>install</strong> directory, where the bash scripts that automate the startup and shutdown of the project are located</p>
<pre><code> cd install
</code></pre>
</li>
<li>
<p>Start the project by running the bash script by pressing the command</p>
<pre><code>./up.sh
</code></pre>
</li>
<li>
<p>Open your browser and visit the services at the following links</p>
</li>
</ol>
<ul>
<li class="task-list-item">
<p><input type="checkbox" class="task-list-item-checkbox" disabled=""> <strong>Wordpress</strong></p>
<p><a href="http://localhost:8080">http://localhost:8080</a></p>
</li>
<li class="task-list-item">
<p><input type="checkbox" class="task-list-item-checkbox" disabled=""> <strong>MySQL</strong></p>
<p><a href="http://localhost:3306">http://localhost:3306</a></p>
</li>
<li class="task-list-item">
<p><input type="checkbox" class="task-list-item-checkbox" disabled=""> <strong>phpMyAdmin</strong></p>
<p><a href="http://localhost:8081">http://localhost:8081</a></p>
</li>
</ul>
<p>Use phpMyAdmin to manage the MySQL database and configure the database for WordPress.</p>
<p>To stop the services from running follow these steps:</p>
<ol>
<li>
<p>Go to the <strong>install</strong> directory, where the bash scripts that automate starting and stopping the project are located</p>
<pre><code>cd install
</code></pre>
</li>
<li>
<p>Terminate the project by running the bash script by pressing the command</p>
<pre><code>./down.sh
</code></pre>
</li>
</ol>
<p>To summarize, with the above shell scripts we can create or remove the containers of the 3 services of the application. Removing the containers includes removing the network that the containers communicate with. The data volumes remain as they are.</p>


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTYwNjMzMTE1MCwtMzE4MDU0NTY4XX0=
-->