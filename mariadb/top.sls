base:
  '*':
    - mariadb_10
    - galera
    - backup
  'arbitrator':
    - galera_arbitrator
  'master':
    - galera_master
  'slave*':
    - galera_slave
