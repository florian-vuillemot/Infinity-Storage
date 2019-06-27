base:
  '*':
    - mariadb_10
    - galera
    - backup
  'master*':
    - galera_master
  'slave*':
    - galera_slave
