---


---

<p><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/255px-Flag_of_Greece.svg.png" alt="enter image description here"></p>
<h2 id="τμήμα-μηχανικών-πληροφορικής-και-υπολογιστών">Τμήμα Μηχανικών Πληροφορικής και Υπολογιστών</h2>
<h3 id="εργαστήριο-υπολογιστικής-νέφους-και-υπηρεσιών">Εργαστήριο Υπολογιστικής Νέφους και Υπηρεσιών</h3>
<h3 id="δημιουργία-εικονικού-εργαστηρίου">Δημιουργία Εικονικού Εργαστηρίου</h3>
<hr>
<h3 id="μέλη-ομάδας">Μέλη Ομάδας</h3>
<ul>
<li>Αθανασίου Βασίλειος Ευάγγελος | ice19390005</li>
<li>Θεοχάρης Γεώργιος | 19390283</li>
</ul>
<hr>
<h3 id="εισαγωγή">Εισαγωγή</h3>
<p>Αυτό το project δημιουργήθηκε για το εργαστήριο υπολογιστικής νέφους και προσφέρει ένα εικονικό εργαστηριακό περιβάλλον χρησιμοποιώντας Docker. Σκοπός του είναι να διευκολύνει την ανάπτυξη και τη διαχείριση διαφόρων εφαρμογών παρέχοντας πολλές λειτουργίες και υπηρεσίες. Το παρόν README αρχείο περιγράφει συνοπτικά το project, τα χαρακτηριστικά του και τις υπηρεσίες που χρησιμοποιούνται.</p>
<hr>
<h3 id="χαρακτηριστικά">Χαρακτηριστικά</h3>
<p>Το Docker project διαθέτει τα εξής χαρακτηριστικά:</p>
<ul>
<li><strong>Απομονωμένα Δίκτυα</strong>: Κάθε εικονικό εργαστήριο δημιουργεί το δικό του δίκτυο, επιτρέποντας ασφαλή επικοινωνία μεταξύ των containers.</li>
<li><strong>Διατήρηση Δεδομένων</strong>: Παρέχει δυνατότητα αποθήκευσης για διαρκή διαχείριση δεδομένων, εξασφαλίζοντας τη διατήρηση των δεδομένων ακόμη και αν τα containers επανεκκινηθούν ή σταματήσουν.</li>
<li><strong>Αυτόματη Εκκίνηση και Τερματισμός Υπηρεσιών</strong>: Χρήση shell scripts για αυτόματη εκτέλεση και τερματισμό υπηρεσιών χωρίς χειροκίνητη παρέμβαση.</li>
<li><strong>Απομόνωση Υπηρεσιών</strong>: Κάθε υπηρεσία εκτελείται σε ξεχωριστό container. Το WordPress είναι η κύρια εφαρμογή, ενώ η MySQL διαχειρίζεται τη βάση δεδομένων. Το phpMyAdmin προσφέρει γραφική διεπαφή για τη διαχείριση της βάσης δεδομένων MySQL.</li>
<li><strong>Διαχείριση Πόρων</strong>: Διαμόρφωση πόρων για τη βέλτιστη κατανομή τους και αποτροπή προβλημάτων μνήμης. Τα αρχεία Docker Compose καθορίζουν τα όρια πόρων για όλα τα containers.</li>
</ul>
<hr>
<h3 id="χρησιμοποιούμενες-υπηρεσίες">Χρησιμοποιούμενες Υπηρεσίες</h3>
<p>Το Docker project χρησιμοποιεί τις εξής υπηρεσίες:</p>
<ul>
<li><strong>WordPress</strong>: Ένα δημοφιλές σύστημα διαχείρισης περιεχομένου για τη δημιουργία και διαχείριση ιστοσελίδων.</li>
<li><strong>MySQL</strong>: Ένα γνωστό σύστημα διαχείρισης σχεσιακών βάσεων δεδομένων ανοιχτού κώδικα.</li>
<li><strong>phpMyAdmin</strong>: Μια γραφική διεπαφή για τη διαχείριση βάσεων δεδομένων MySQL, απλοποιώντας τη διαχείριση της βάσης δεδομένων.</li>
</ul>
<hr>
<h3 id="λεπτομερής-περιγραφή-των-υπηρεσιών">Λεπτομερής Περιγραφή των Υπηρεσιών</h3>
<h4 id="wordpress-container">WordPress Container</h4>
<p>Το WordPress container είναι η κύρια σελίδα για το project, επιτρέποντας τη δημιουργία και διαχείριση ιστοσελίδων.</p>
<p><strong>Διαμόρφωση</strong></p>
<p>Για να υλοποιήσουμε το container WordPress, χρησιμοποιούμε δύο αρχεία Docker Compose: <code>docker-compose.yaml</code> και <code>docker-compose.override.yaml</code>.</p>
<p><strong>docker-compose.override.yaml</strong></p>
<pre><code>version: '3.8'

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
<li><strong>container_name</strong>: Καθορίζουμε το όνομα του container του WordPress ως “wordpress”.</li>
<li><strong>ports</strong>: Αντιστοιχίζουμε το port 8080 του κεντρικού υπολογιστή στη θύρα 80 του container, επιτρέποντας την πρόσβαση στο WordPress μέσω του <a href="http://localhost:8080">http://localhost:8080</a>.</li>
<li><strong>restart</strong>: Εξασφαλίζουμε ότι το container κάνει επαννεκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.</li>
<li><strong>volumes</strong>: Δημιουργούμε ένα volume με το όνομα “/wp_data” και τον κάνουμε mount στον κατάλογο “/var/www/html” του container. Αυτό επιτρέπει στα αρχεία WordPress να αποθηκεύονται εκτός του container, διατηρώντας τα δεδομένα ακόμα και αν το container έχει σταματήσει ή αφαιρεθεί.</li>
<li><strong>environment</strong>: Με τα environment variables καθορίζουμε τη σύνδεση του WordPress με το container MySQL.</li>
<li><strong>deploy</strong>: Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.</li>
<li><strong>network</strong>: Συνδέουμε το container του WordPress με το δίκτυο “wordpressNetwork”.</li>
</ul>
<p><strong>docker-compose.yaml</strong></p>
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
<li>Ορίζουμε την υπηρεσία WordPress χρησιμοποιώντας το WordPress Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.</li>
<li>Με το <strong>“networks”</strong> συνδέουμε το container του WordPress με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.</li>
</ul>
<p>Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του WordPress, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.</p>
<hr>
<h4 id="mysql-container">MySQL Container</h4>
<p>Το MySQL container φιλοξενεί τη βάση δεδομένων που χρησιμοποιείται από το WordPress.</p>
<p><strong>Διαμόρφωση</strong></p>
<p>Για να υλοποιήσουμε το container MySQL, χρησιμοποιούμε δύο αρχεία Docker Compose: <code>docker-compose.yaml</code> και <code>docker-compose.override.yaml</code>.<br>
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
<li><strong>container_name</strong>: Καθορίζουμε το όνομα του container του MySQL ως “mysql”.</li>
<li><strong>ports</strong>: Αντιστοιχίζουμε το port 3306 του κεντρικού υπολογιστή στη θύρα 3306 του container, επιτρέποντας την πρόσβαση στη βάση δεδομένων μέσω του MySQL client.</li>
<li><strong>restart</strong>: Εξασφαλίζουμε ότι το container κάνει επανεκκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.</li>
<li><strong>volumes</strong>: Δημιουργούμε ένα volume με το όνομα “/db_data” και τον κάνουμε mount στον κατάλογο “/var/lib/mysql” του container. Αυτό επιτρέπει τα δεδομένα της βάσης να αποθηκεύονται εκτός του container, διατηρώντας τα δεδομένα ακόμα και αν το container έχει σταματήσει ή αφαιρεθεί.</li>
<li><strong>environment</strong>: Με τα environment variables καθορίζουμε τις παραμέτρους της βάσης δεδομένων.</li>
<li><strong>deploy</strong>: Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.</li>
<li><strong>network</strong>: Συνδέουμε το container του MySQL με το δίκτυο “vlab_network”.</li>
</ul>
<p><strong>docker-compose.yaml</strong></p>
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
<li>Ορίζουμε την υπηρεσία MySQL χρησιμοποιώντας το MySQL Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.</li>
<li>Με το <strong>“networks”</strong> συνδέουμε το container του MySQL με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.</li>
</ul>
<p>Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του MySQL, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.</p>
<hr>
<h4 id="phpmyadmin-container">phpMyAdmin Container</h4>
<p>Το phpMyAdmin container παρέχει γραφικό περιβάλλον για τη διαχείριση της βάσης δεδομένων MySQL.</p>
<p><strong>Διαμόρφωση</strong></p>
<p>Για να υλοποιήσουμε το container phpMyAdmin, χρησιμοποιούμε δύο αρχεία Docker Compose: <code>docker-compose.yaml</code> και <code>docker-compose.override.yaml</code>.<br>
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
<li><strong>container_name</strong>: Καθορίζουμε το όνομα του container του phpMyAdmin ως “phpmyadmin”.</li>
<li><strong>ports</strong>: Αντιστοιχίζουμε το port 8081 του κεντρικού υπολογιστή στη θύρα 80 του container, επιτρέποντας την πρόσβαση στο phpMyAdmin μέσω του <a href="http://localhost:8081">http://localhost:8081</a>.</li>
<li><strong>restart</strong>: Εξασφαλίζουμε ότι το container κάνει επανεκκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.</li>
<li><strong>environment</strong>: Με τα environment variables καθορίζουμε τις παραμέτρους σύνδεσης με το MySQL container.</li>
<li><strong>deploy</strong>: Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.</li>
<li><strong>network</strong>: Συνδέουμε το container του phpMyAdmin με το δίκτυο “vlab_network”.</li>
</ul>
<p><strong>docker-compose.yaml</strong></p>
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
<li>Ορίζουμε την υπηρεσία phpMyAdmin χρησιμοποιώντας το phpMyAdmin Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.</li>
<li>Με το <strong>“networks”</strong> συνδέουμε το container του phpMyAdmin με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.</li>
</ul>
<p>Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του phpMyAdmin, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.</p>

