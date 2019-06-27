# MariaDB master/master replication

## What is master/master replication and when use it

Master/master it's a way to obtain a cluster of database with the same content.
This allows a higher disponibility of a cluster without down time in case of database failure.
Moreover, this allows a good load balancing with read and write operations on each database.
This configuration is not perfect and creates a lot of limitations.

Please read this articles before using a master/master replication on MariaDB in production: 
* Uses case: https://mariadb.com/kb/en/library/galera-use-cases/
* Limitation: https://mariadb.com/kb/en/library/mariadb-galera-cluster-known-limitations/ 

![Schema of master/master replication](https://mariadb.com/kb/en/library/what-is-mariadb-galera-cluster/+image/galera_small)

