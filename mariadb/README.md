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

## Before starting

You need SaltStack ssh install on your machine: https://docs.saltstack.com/en/getstarted/ssh/system.html
This scripts were test on Ubuntu 18.04.
Clone this repo, and create a symlink like `/srv/salt -> /home/my/Infinity-Storage/mariadb`.
Open the file `conf/galera.cnf`, and update the line `wsrep_cluster_address="gcomm://192.168.1.72"` with your ip. You can add multiple ip by adding `,` between each like `wsrep_cluster_address="gcomm://192.168.1.72,192.168.1.42"`.

## How to create a 'master' MariaDB

In your roster file (/etc/salt/roster), create a master hostname with the machine information

Ex:
`
master:
  host: 192.168.1.42    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user fred
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
`

After that, you can run `salt-ssh -i master state.highstate`. This will installed, configure and launch the Galera cluster.

Note: if you want to manage multiple cluster, you can rename the `master` hostname in `master1`, `master2`... The only important point is to start the hostname with `master`.


## How to create a slave machine

Add in your roster file a hostname (as for create a master) but name this hostname `slaveFooBar`.


Ex:
`
slaveFoo:
  host: 192.168.1.21    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user fred
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
slaveBar:
  host: 192.168.1.84    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user fred
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
....
`

The only important point is to start your hostname by `slave`.
After that run `salt-ssh -i slaveFoo state.highstate`. This install, configure and add the machine in the Galera Cluster.


## Backup and restore

Backup are automatic and on each machine. It's configure during the installation. It's done by a cronjob that you can configure in the `conf/cronjob` file.
For restore a backup:
1. Create a new Galera Cluster (just with a 'master' machine)
2. Copy the backup file that you want to restore and upload it on the new cluster (in the directory /var/mariadb/backup)
3. Run `salt-ssh -i master restore`

You can also remove other machine from the cluster and after that run the restore operation. But this can create some complication.

This approch is not perfect. The best way is to create a SaltStack state for choose the backup file and download it on the administrator machine. Then update the actual task for upload this backup on the new cluster and make the change.

## Resources

* Create Galera cluster: https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mariadb-10-1-on-ubuntu-16-04-servers
* Backup and restore: https://mariadb.com/kb/en/library/full-backup-and-restore-with-mariabackup/
