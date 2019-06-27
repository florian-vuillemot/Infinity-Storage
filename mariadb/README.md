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


## Workflow

We are using SaltStack for install and configure MariaDB Galera Cluster for the master/master replication.

1. Install MariaDB server on the machine
2. Install MariaDB Galera Cluster tool
3. Install MariaDB Backup tool with cron job for backup database

After that, there are 2 cases:
* It's the first machine that you create
* There are already a Galera Cluster up

The only difference for user is in the hostname configuration for SaltStack. In the first case, you have to specify in the hostname that is you master machine. The script automatically launch the Galera Cluster if the machine is considere as the master.

## How to create a master machine

## How to create a slave machine

## Resources

* Create Galera cluster: https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mariadb-10-1-on-ubuntu-16-04-servers
