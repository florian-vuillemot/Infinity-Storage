
## Configure SaltStack

In your roster file (/etc/salt/roster), create a master hostname with the machines information.

Ex:
```
master-postgres:
  host: 192.168.1.42    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
  
slave-postgres:
  host: 192.168.1.21    # The IP addr or DNS hostname
  user: foo             # Remote executions will be executed as user foo
  passwd: bar           # The password to use for login, if omitted, keys are used
  sudo: True            # Whether to sudo to root, not enabled by default
  tty: True             # TTY for allow sudo access
```

## How to run

Before run, you have to update the config file of master and slave (`config` folder).

### Master

Update the master conf file (pg_hba.conf.master) by update the `IP_address_of_slave` with your slave ip.

Go in the file `postgresql.conf.master` and update `IP_address_of_THIS_host`.

### Slave

Update the master conf file (pg_hba.conf.slave) by update the `IP_address_of_master` with your master ip.

Go in the file `postgresql.conf.slave` and update `IP_address_of_THIS_host`.

### Sync Master and Slave data

Go in file `conf/backup_to_slave.sh` and update `slave_IP_address`.

Go in file `conf/recovery.conf` and update the `master_IP_address` and the password.

## Run the installation

When your configuration is ok you can install postgres on the master and the slave by running `salt-ssh -i {your machine} state.highstate` on each machines.

Now, you have to create the backup from the master to the slave, for do that run: `salt-ssh -i master state.apply backup_to_slave`. **Warning:** You have to configure your SSH key between host. Moreoever you have set a password for the user postgres. In case of problem, run manually the `.sh` script.

Then run the slave recovery with: `salt-ssh -i slave state.apply slave_recovery`.

Ressources:
  - https://www.digitalocean.com/community/tutorials/how-to-set-up-master-slave-replication-on-postgresql-on-an-ubuntu-12-04-vps
