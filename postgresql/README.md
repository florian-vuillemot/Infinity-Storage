## How to run

### Master

Update the master conf file (pg_hba.conf.master) by update the `IP_address_of_slave` with your slave ip.

Go in the file `postgresql.conf.master` and update `IP_address_of_THIS_host`.

### Slave

Update the master conf file (pg_hba.conf.slave) by update the `IP_address_of_master` with your master ip.

Go in the file `postgresql.conf.slave` and update `IP_address_of_THIS_host`.

### Sync Master and Slave data

Go in file `conf/backup_on_slave.sh` and update `slave_IP_address`.

Ressources:
  - https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-on-postgresql-on-an-ubuntu-12-04-vps
