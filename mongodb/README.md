# MongoDB master/replication replication

## What is master/slave replication and when use it

Master/slave it's a way to obtain a cluster of database with the same content.

This allows a higher disponibility of a cluster without down time in case of database failure.

The MongoDB master/slave cluster provide in the MongoDB stack. You don't need to install another tool.

![Schema of master/slave replication](https://docs.mongodb.com/manual/_images/replica-set-read-write-operations-primary.bakedsvg.svg)


## Workflow

We are using SaltStack for installing and configuring the MongoDB Cluster for the master/slave replication.

1. Install MongoDB server on the machine
2. Install and configure a backup on the machine
3. Configure the machine for the replication
4. Create user, role and table if (and only if is the first machine create)

**Note:** The first MongoDB machine create is call `master`. Because is the only machine with the user, role and table hydratation.

## Before starting

You need SaltStack ssh install on your machine: https://docs.saltstack.com/en/getstarted/ssh/system.html
This scripts were tested on Ubuntu 18.04.

1. Clone this repo, and create a symlink like `/srv/salt -> /home/my/Infinity-Storage/mongodb`.
2. Open the file `conf/replica.conf`, and update the line `bindIp: localhost` with yours ips. You can add multiple ip(s) by adding `,` in-between, like `bindIp: localhost,192.168.1.42`.

## How to create the MongoDB Cluster

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

After that, you can run `salt-ssh -i master state.highstate`. This will install, configure and launch the MongoDB cluster.

Note: if you want to manage multiple clusters, you can rename the `master` hostname in `master1`, `master2`... The only important point is to start the hostname with `master`.


## How to add a machine to the MongoDB Cluster (on the fly)

Add in your roster file a hostname (as in the "How to create the MongoDB Cluster" part) but name this hostname `slaveFooBar`.

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

After that, run `salt-ssh -i slaveFoo state.highstate`. This installs, configures and adds the machine in the MongoDB Cluster.

## Remote connections

Administrator connection can only be on the local machine.

For remote connection, you have to update the file `conf/replica.conf` by providing the ip on `bindIp` variable (show `Before starting` part).

## Backup and restore

Backups are automatically created and configured on each machine.

It's done by a cron job that you can configure in the `conf/cronjob` file.

To restore a backup:
1. Create a new MongoDB Cluster (just with a 'master' machine)
2. Copy the backup file that you want to restore and upload it on the new cluster (in the directory /home/mongodb/backup/)
3. Run `salt-ssh -i master restore`

You can also remove other machines from the cluster and after that run the restore operation. But this can create some complications.

This approch is not perfect. The best way is to create a SaltStack state to choose the backup file from and download it on the administrator machine. Then update the actual task to upload this backup on the new cluster and make the change.

## Resource

* Deploy a replicat set: https://docs.mongodb.com/manual/tutorial/deploy-replica-set/ (provide link for create MongoDB database)
