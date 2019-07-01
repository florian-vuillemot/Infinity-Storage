# MariaDB master/master replication

## What is master/master replication and when use it

Master/master it's a way to obtain a cluster of database with the same content.

This allows a higher disponibility of a cluster without down time in case of database failure.

Moreover, this allows a good load balancing with read and write operations on each database.

This configuration is not perfect and creates a lot of limitations.

The MariaDB master/master cluster is create thanks to the tools Galera: https://mariadb.com/kb/en/library/what-is-mariadb-galera-cluster/

Please read this articles before using a master/master replication on MariaDB in production: 
* Uses case: https://mariadb.com/kb/en/library/galera-use-cases/
* Limitation: https://mariadb.com/kb/en/library/mariadb-galera-cluster-known-limitations/ 

![Schema of master/master replication](https://mariadb.com/kb/en/library/what-is-mariadb-galera-cluster/+image/galera_small)


## Workflow

We are using SaltStack for installing and configuring MariaDB Galera Cluster for the master/master replication.

1. Install MariaDB server on the machine
2. Install MariaDB Galera Cluster tool
3. Install MariaDB Backup tool with cron job for backup database

After that, there are 2 cases:
* It's the first machine that you create
* There is already a Galera Cluster running

The only difference for the user is in the hostname configuration for SaltStack. In the first case, you have to specify in the hostname that it is you master machine. The script automatically launches the Galera Cluster if the machine is considered as the master.

## Before starting

You need SaltStack ssh install on your machine: https://docs.saltstack.com/en/getstarted/ssh/system.html
This scripts were tested on Ubuntu 18.04.

1. Clone this repo, and create a symlink like `/srv/salt -> /home/my/Infinity-Storage/mariadb`.
2. Open the file `conf/galera.cnf`, and update the line `wsrep_cluster_address="gcomm://192.168.1.72"` with your ip. You can add multiple ip(s) by adding `,` in-between, like `wsrep_cluster_address="gcomm://192.168.1.72,192.168.1.42"`.
3. Configure your remote connection (show **remote connections** part)

Sometimes we use the term "master" to speak about the machine that creates the Galera Cluster. There aren't references of the cluster replication configuration that stay master/master.

## How to create the Galera Cluster

In your roster file (/etc/salt/roster), create a master hostname with the machine information

Ex:
```
master:
  host: 192.168.1.42    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
```

After that, you can run `salt-ssh -i master state.highstate`. This will install, configure and launch the Galera cluster.

Note: if you want to manage multiple clusters, you can rename the `master` hostname in `master1`, `master2`... The only important point is to start the hostname with `master`.


## How to add a machine to the Galera Cluster (on the fly)

Add in your roster file a hostname (as in the "How to create the Galera Cluster" part) but name this hostname `slaveFooBar`.

Ex:
```
slaveFoo:
  host: 192.168.1.21    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
slaveBar:
  host: 192.168.1.84    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
....
```

The only important point is to start your hostname by `slave`.

After that, run `salt-ssh -i slaveFoo state.highstate`. This installs, configures and adds the machine in the Galera Cluster.

## Remote connections

Administrator connection can only be on the local machine.

For remote connection, you have to update your pillar for create a remote user. This user is limited in action (read the state file `users_and_tables/config.sls`).

Business information are stock in pillar file. By default, those files are in `/srv/pillar` directory.

Create a pillar to file for your mariadb configuration `/srv/pillar/top.sls`:

```
base:
  '*':
    - mariadb
```

Than you pillar configuration `/srv/pillar/mariadb.sls`:
```
users: ['username@ip']
password: {'username@ip': 'password'}
```

Note: If you don't want to allow remote connection just let users empty (`[]`).

## Backup and restore

Backups are automatically created and configured on each machine.

It's done by a cron job that you can configure in the `conf/cronjob` file.

To restore a backup:
1. Create a new Galera Cluster (just with a 'master' machine)
2. Copy the backup file that you want to restore and upload it on the new cluster (in the directory /var/mariadb/backup)
3. Run `salt-ssh -i master restore`

You can also remove other machines from the cluster and after that run the restore operation. But this can create some complications.

This approch is not perfect. The best way is to create a SaltStack state to choose the backup file from and download it on the administrator machine. Then update the actual task to upload this backup on the new cluster and make the change.

## Resources

* Create Galera cluster: https://www.digitalocean.com/community/tutorials/how-to-configure-a-galera-cluster-with-mariadb-10-1-on-ubuntu-16-04-servers
* Backup and restore: https://mariadb.com/kb/en/library/full-backup-and-restore-with-mariabackup/
