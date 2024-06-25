---


---

<p><img src="https://x2e5r7b9.rocketcdn.me/wp-content/uploads/2020/02/LOGO-STAMP-white.png" alt="enter image description here"></p>
<h1 id="τμήμα-μηχανικών-πληροφορικής-και-υπολογιστών">Τμήμα Μηχανικών Πληροφορικής και Υπολογιστών</h1>
<h1 id="υπολογιστική-νέφους-και-υπηρεσίες">Υπολογιστική Νέφους και Υπηρεσίες</h1>
<h1 id="δημιουργία-εικονικού-εργαστηρίου">Δημιουργία Εικονικού Εργαστηρίου</h1>
<h1 id="στοιχεία-εργασίας">Στοιχεία Εργασίας</h1>
<p><strong>Υπεύθυνος Εργαστηρίου:</strong> Αναγνωστόπουλος Απόστολος<br>
<strong>Ημερομηνία Παράδοσης:</strong> 25/6/2024<br>
<strong>Προθεσμία Υποβολής:</strong> 25/6/2024</p>
<h1 id="στοιχεία-ομάδας">Στοιχεία Ομάδας</h1>
<ul>
<li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled=""> <strong>Φοιτητής 1</strong></li>
</ul>
<p><strong>Ονοματεπώνυμο:</strong> Αθανασίου Βασίλειος Ευάγγελος<br>
<strong>Αριθμός Μητρώου:</strong> 19390005</p>
<ul>
<li class="task-list-item"><input type="checkbox" class="task-list-item-checkbox" disabled=""> <strong>Φοιτητής 2</strong></li>
</ul>
<p><strong>Ονοματεπώνυμο:</strong> Θεοχάρης Γεώργιος<br>
<strong>Αριθμός Μητρώου:</strong> 19390283</p>
<h1 id="οδηγίες-εγκατάστασης-και-ρύθμισης">Οδηγίες Εγκατάστασης και Ρύθμισης</h1>
<p>Με τα shell scripts <a href="http://up.sh">up.sh</a> και <a href="http://down.sh">down.sh</a> αυτοματοποιείται η διαδικασία αυτόματης εκτέλεσης των υπηρεσιών και τερματισμού λειτουργίας τους αντίστοιχα.</p>
<h2 id="up.sh"><a href="http://up.sh">up.sh</a></h2>
<pre><code>#!/bin/bash


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
</code></pre>
<ul>
<li>
<p><strong>NETWORK:</strong>  Το όνομα του δικτύου Docker που θα δημιουργηθεί.</p>
</li>
<li>
<p><strong>WORDPRESS:</strong> Το filepath που βρίσκονται τα docker-compose αρχεία για την εκτέλεση της υπηρεσίας Wordpress</p>
</li>
<li>
<p><strong>MYSQL:</strong> Το filepath που βρίσκονται τα docker-compose αρχεία για την εκτέλεση της υπηρεσίας MySQL</p>
</li>
<li>
<p><strong>PHPMYADMIN:</strong> Η σχετική διαδρομή προς τον κατάλογο εγκατάστασης του phpMyAdmin Docker.</p>
</li>
<li>
<p><strong>COMPOSE_FILE:</strong> Το όνομα του κύριου αρχείου Docker Compose που δημιουργεί το image της κάθε υπηρεσίας και ρυθμίζει το δίκτυο.</p>
</li>
<li>
<p><strong>COMPOSE_FILE_OVERRIDE:</strong> Το όνομα του αρχείου override Docker Compose που περιλαμβάνει όλα τα configs της κάθε υπηρεσίας.</p>
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
<p>Για να εγκαταστήσετε και να ρυθμίσετε αυτό το project, ακολουθήστε τα παρακάτω βήματα:</p>
<ol>
<li>
<p>Κλωνοποιήστε το αποθετήριο πατώντας την εντολή</p>
<pre><code>git clone https://github.com/Cloud-Computing-and-Services/Virtual-Lab.git
</code></pre>
</li>
<li>
<p>Μεταβείτε στον κατάλογο του project πατώντας την εντολή</p>
<pre><code>cd Virtual-Lab
</code></pre>
</li>
<li>
<p>Μεταβείτε στον κατάλογο <strong>install</strong>, όπου βρίσκονται τα bash scripts που αυτοματοποιούν την εκκίνηση και τον τερματισμό του project</p>
<pre><code> cd install
</code></pre>
</li>
<li>
<p>Εκκινήστε το project εκτελώντας το bash script πατώντας την εντολή</p>
<pre><code>./up.sh
</code></pre>
</li>
<li>
<p>Ανοίξ’τε τον browser σας και επισκεφθείτε τις υπηρεσίες στους ακόλουθους συνδέσμους</p>
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
<p>Χρησιμοποιήστε το phpMyAdmin για να διαχειριστείτε τη βάση δεδομένων MySQL και να ρυθμίσετε τις παραμέτρους της βάσης δεδομένων για το WordPress.</p>
<p>Για να σταματήσετε την λειτουργία των υπηρεσίων ακολουθείτε τα εξής:</p>
<ol>
<li>
<p>Μεταβείτε στον κατάλογο <strong>install</strong>, όπου βρίσκονται τα bash scripts που αυτοματοποιούν την εκκίνηση και τον τερματισμό του project</p>
<pre><code>cd install
</code></pre>
</li>
<li>
<p>Τερματίστε το project εκτελώντας το bash script πατώντας την εντολή</p>
<pre><code>./down.sh
</code></pre>
</li>
</ol>
<p>Συνοψίζοντας, με τα παραπάνω shell scripts μπορούμε να δημιουργήσουμε ή να αφαιρέσουμε τα containers των 3 υπηρεσιών της εφαρμογής. Στην αφαίρεση των containers συμπεριλαμβάνεται και η αφαίρεση του δικτύου που επικοινωνούν τα containers. Τα data volumes παραμένουν όπως είναι.</p>

