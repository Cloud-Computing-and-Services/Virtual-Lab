![Alt text](https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/255px-Flag_of_Greece.svg.png)

# [Τμήμα Μηχανικών Πληροφορικής και Υπολογιστών](https://ice.uniwa.gr/) 

# [Υπολογιστική Νέφους και Υπηρεσίες](https://ice.uniwa.gr/education/undergraduate/courses/cloud-services/)

# Δημιουργία Εικονικού Εργαστηρίου

# Στοιχεία Εργασίας

**Υπεύθυνος Εργαστηρίου:** [Αναγνωστόπουλος Απόστολος](https://ice.uniwa.gr/emd_person/17574/)  
**Ημερομηνία Παράδοσης:** 25/6/2024  
**Προθεσμία Υποβολής:** 25/6/2024

# Στοιχεία Ομάδας

- [ ] **Φοιτητής 1**  
**Όνομα:** Αθανασίου Βασίλειος Ευάγγελος  
**Αριθμός Μητρώου:** 19390005  

- [ ] **Φοιτητής 2**  
**Όνομα:** Θεοχάρης Γεώργιος  
**Αριθμός Μητρώου:** 19390283  

# Οδηγίες Εγκατάστασης και Ρύθμισης

Τα shell scripts [up.sh](install/) και [down.sh](install/) αυτοματοποιούν τη διαδικασία εκτέλεσης και τερματισμού των υπηρεσιών αντίστοιχα.

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

echo "Εκκίνηση MySQL..."
(cd $MYSQL && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Εκκίνηση phpMyAdmin..."
(cd $PHPMYADMIN && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)

echo "Εκκίνηση WordPress..."
(cd $WORDPRESS && docker compose -f $COMPOSE_FILE -f $COMPOSE_FILE_OVERRIDE up -d)
}

up_containers

exit 0
```
- **NETWORK:** Το όνομα του δικτύου Docker που θα δημιουργηθεί.
- **WORDPRESS:** Το filepath που βρίσκονται τα docker-compose αρχεία για την εκτέλεση της υπηρεσίας Wordpress
- **MYSQL:** Το filepath που βρίσκονται τα docker-compose αρχεία για την εκτέλεση της υπηρεσίας MySQL
- **PHPMYADMIN:** Η σχετική διαδρομή προς τον κατάλογο εγκατάστασης του phpMyAdmin Docker.
- **COMPOSE_FILE:** Το όνομα του κύριου αρχείου Docker Compose που δημιουργεί το image της κάθε υπηρεσίας και ρυθμίζει το δίκτυο.
- **COMPOSE_FILE_OVERRIDE:** Το όνομα του αρχείου override Docker Compose που περιλαμβάνει όλα τα configs της κάθε υπηρεσίας.

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
Για να εγκαταστήσετε και να ρυθμίσετε αυτό το project, ακολουθήστε τα παρακάτω βήματα:

1. Κλωνοποιήστε το αποθετήριο πατώντας την εντολή
```
git clone https://github.com/Cloud-Computing-and-Services/Virtual-Lab.git
```
2. Μεταβείτε στον κατάλογο του project πατώντας την εντολή
```
cd Virtual-Lab
```
3. Μεταβείτε στον κατάλογο install, όπου βρίσκονται τα bash scripts που αυτοματοποιούν την εκκίνηση και τον τερματισμό του project
```
cd install
```
4. Εκκινήστε το project εκτελώντας το bash script πατώντας την εντολή
```
./up.sh
```
5. Ανοίξ’τε τον browser σας και επισκεφθείτε τις υπηρεσίες στους ακόλουθους συνδέσμους
- Wordpress
http://localhost:8080

- MySQL
http://localhost:3306

- phpMyAdmin
http://localhost:8081

Χρησιμοποιήστε το phpMyAdmin για να διαχειριστείτε τη βάση δεδομένων MySQL και να ρυθμίσετε τις παραμέτρους της βάσης δεδομένων για το WordPress.

Για να σταματήσετε την λειτουργία των υπηρεσίων ακολουθείτε τα εξής:

1. Μεταβείτε στον κατάλογο `install`, όπου βρίσκονται τα bash scripts που αυτοματοποιούν την εκκίνηση και τον τερματισμό του project
```
cd install
```
2. Τερματίστε το project εκτελώντας το bash script πατώντας την εντολή
```
./down.sh
```
Συνοψίζοντας, με τα παραπάνω shell scripts μπορούμε να δημιουργήσουμε ή να αφαιρέσουμε τα containers των 3 υπηρεσιών της εφαρμογής. Στην αφαίρεση των containers συμπεριλαμβάνεται και η αφαίρεση του δικτύου που επικοινωνούν τα containers. Τα data volumes παραμένουν όπως είναι.
