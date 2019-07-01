base:
  '*':
    - mariadb_10
    - users_and_tables
    - galera
    - backup
    - firewall
  'master*':
    - galera_master
  'slave*':
    - galera_slave
