![Flag](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/255px-Flag_of_Greece.svg.png)

## [Τμήμα Μηχανικών Πληροφορικής και Υπολογιστών](https://ice.uniwa.gr/)

### [Υπολογιστική Νέφους και Υπηρεσιών](https://ice.uniwa.gr/education/undergraduate/courses/cloud-services/)

### Δημιουργία Εικονικού Εργαστηρίου

---

### Μέλη Ομάδας

- Αθανασίου Βασίλειος Ευάγγελος | ice19390005
- Θεοχάρης Γεώργιος | 19390283

---

### Εισαγωγή

Αυτό το project δημιουργήθηκε για το εργαστήριο υπολογιστικής νέφους και προσφέρει ένα εικονικό εργαστηριακό περιβάλλον χρησιμοποιώντας Docker. Σκοπός του είναι να διευκολύνει την ανάπτυξη και τη διαχείριση διαφόρων εφαρμογών παρέχοντας πολλές λειτουργίες και υπηρεσίες. Το παρόν `README` αρχείο περιγράφει συνοπτικά το project, τα χαρακτηριστικά του και τις υπηρεσίες που χρησιμοποιούνται.

---

### Χαρακτηριστικά

Το Docker project διαθέτει τα εξής χαρακτηριστικά:

- **Απομονωμένα Δίκτυα:**: Κάθε εικονικό εργαστήριο δημιουργεί το δικό του δίκτυο, επιτρέποντας ασφαλή επικοινωνία μεταξύ των containers.
- **Διατήρηση Δεδομένων:**: Παρέχει δυνατότητα αποθήκευσης για διαρκή διαχείριση δεδομένων, εξασφαλίζοντας τη διατήρηση των δεδομένων ακόμη και αν τα containers επανεκκινηθούν ή σταματήσουν.
- **Αυτόματη Εκκίνηση και Τερματισμός Υπηρεσιών:**: Χρήση shell scripts για αυτόματη εκτέλεση και τερματισμό υπηρεσιών χωρίς χειροκίνητη παρέμβαση.
- **Απομόνωση Υπηρεσιών:**: Κάθε υπηρεσία εκτελείται σε ξεχωριστό container. Το WordPress είναι η κύρια εφαρμογή, ενώ η MySQL διαχειρίζεται τη βάση δεδομένων. Το phpMyAdmin προσφέρει γραφική διεπαφή για τη διαχείριση της βάσης δεδομένων MySQL.
- **Διαχείριση Πόρων:**: Διαμόρφωση πόρων για τη βέλτιστη κατανομή τους και αποτροπή προβλημάτων μνήμης. Τα αρχεία Docker Compose καθορίζουν τα όρια πόρων για όλα τα containers.

---

### Χρησιμοποιούμενες Υπηρεσίες

Το Docker project χρησιμοποιεί τις εξής υπηρεσίες:

- **WordPress**: Ένα δημοφιλές σύστημα διαχείρισης περιεχομένου για τη δημιουργία και διαχείριση ιστοσελίδων.
- **MySQL**: Ένα γνωστό σύστημα διαχείρισης σχεσιακών βάσεων δεδομένων ανοιχτού κώδικα.
- **phpMyAdmin**: Μια γραφική διεπαφή για τη διαχείριση βάσεων δεδομένων MySQL, απλοποιώντας τη διαχείριση της βάσης δεδομένων.

---

### Λεπτομερής Περιγραφή των Υπηρεσιών

#### WordPress Container

Το WordPress container είναι η κύρια σελίδα για το project, επιτρέποντας τη δημιουργία και διαχείριση ιστοσελίδων.

**Διαμόρφωση**

Για να υλοποιήσουμε το container WordPress, χρησιμοποιούμε δύο αρχεία Docker Compose:  `docker-compose.yaml` και `docker-compose.override.yaml`.

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
- **container_name:**  Καθορίζουμε το όνομα του container του WordPress ως “wordpress”.
- **ports:** Αντιστοιχίζουμε το port 8080 του κεντρικού υπολογιστή στη θύρα 80 του container, επιτρέποντας την πρόσβαση στο WordPress μέσω του http://localhost:8080.
- **restart:** Εξασφαλίζουμε ότι το container κάνει επαννεκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.
- **volumes:** Δημιουργούμε ένα volume με το όνομα “/wp_data” και τον κάνουμε mount στον κατάλογο “/var/www/html” του container. Αυτό επιτρέπει στα αρχεία WordPress να αποθηκεύονται εκτός του container, διατηρώντας τα δεδομένα ακόμα και αν το container έχει σταματήσει ή αφαιρεθεί.
- **environment:** Με τα environment variables καθορίζουμε τη σύνδεση του WordPress με το container MySQL.
- **deploy:** Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.
- **network:** Συνδέουμε το container του WordPress με το δίκτυο “wordpressNetwork”.

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
- Ορίζουμε την υπηρεσία WordPress χρησιμοποιώντας το WordPress Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.
- Με το **“networks”** συνδέουμε το container του WordPress με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.

Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του WordPress, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.

---

#### MySQL Container

Το MySQL container φιλοξενεί τη βάση δεδομένων που χρησιμοποιείται από το WordPress.

**Διαμόρφωση**

Για να υλοποιήσουμε το container MySQL, χρησιμοποιούμε δύο αρχεία Docker Compose:  `docker-compose.yaml` και `docker-compose.override.yaml`.

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
- **container_name:** Καθορίζουμε το όνομα του container του MySQL ως “mysql”.
- **ports:** Αντιστοιχίζουμε το port 3306 του κεντρικού υπολογιστή στη θύρα 3306 του container, επιτρέποντας την πρόσβαση στη βάση δεδομένων μέσω του MySQL client.
- **restart:** Εξασφαλίζουμε ότι το container κάνει επανεκκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.
- **volumes:** Δημιουργούμε ένα volume με το όνομα “/db_data” και τον κάνουμε mount στον κατάλογο “/var/lib/mysql” του container. Αυτό επιτρέπει τα δεδομένα της βάσης να αποθηκεύονται εκτός του container, διατηρώντας τα δεδομένα ακόμα και αν το container έχει σταματήσει ή αφαιρεθεί.
- **environment:** Με τα environment variables καθορίζουμε τις παραμέτρους της βάσης δεδομένων.
- **deploy:** Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.
- **network:** Συνδέουμε το container του MySQL με το δίκτυο “vlab_network”.

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
- Ορίζουμε την υπηρεσία MySQL χρησιμοποιώντας το MySQL Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.
- Με το **“networks”** συνδέουμε το container του MySQL με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.

Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του MySQL, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.

---

#### phpMyAdmin Container

Το phpMyAdmin container παρέχει γραφικό περιβάλλον για τη διαχείριση της βάσης δεδομένων MySQL.

**Διαμόρφωση**

Για να υλοποιήσουμε το container phpMyAdmin, χρησιμοποιούμε δύο αρχεία Docker Compose: `docker-compose.yaml` και `docker-compose.override.yaml`.

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
- **container_name:** Καθορίζουμε το όνομα του container του phpMyAdmin ως “phpmyadmin”.
- **ports:** Αντιστοιχίζουμε το port 8081 του κεντρικού υπολογιστή στη θύρα 80 του container, επιτρέποντας την πρόσβαση στο phpMyAdmin μέσω του http://localhost:8081.
- **restart:** Εξασφαλίζουμε ότι το container κάνει επανεκκίνηση αυτόματα εάν σταματήσει ή αντιμετωπίσει κάποιο σφάλμα.
- **environment:** Με τα environment variables καθορίζουμε τις παραμέτρους σύνδεσης με το MySQL container.
- **deploy:** Ορίζουμε τα όρια πόρων για το container, συμπεριλαμβανομένων των περιορισμών της CPU και της μνήμης.
- **network:** Συνδέουμε το container του phpMyAdmin με το δίκτυο “vlab_network”.

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
- Ορίζουμε την υπηρεσία phpMyAdmin χρησιμοποιώντας το phpMyAdmin Docker Image, που γίνεται pull από το Docker Hub με το πιο πρόσφατο tag, αν το image δεν υπάρχει ήδη στον υπολογιστή.
- Με το **“networks”** συνδέουμε το container του phpMyAdmin με το δίκτυο “vlab_network”. Oρίζουμε το όνομα δικτύου ξεχωριστά στην ενότητα networks, προσδιορίζοντας το όνομά του ως “vlab_network” και το driver ως “bridge”.

Μαζί, αυτά τα αρχεία Docker Compose διαμορφώνουν και αναπτύσσουν το container του phpMyAdmin, διασφαλίζοντας ότι είναι συνδεδεμένο στο καθορισμένο δίκτυο και έχει πρόσβαση στους απαραίτητους πόρους και volumes.