base:
  '*':
    - mariadb_10
    - galera
    - backup
    - business_config
  'master*':
    - galera_master
  'slave*':
    - galera_slave
