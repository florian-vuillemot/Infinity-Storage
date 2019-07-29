stop_postgres_slave:
  cmd.run:
    - name: systemctl stop postgresql

/etc/postgresql/10/main/postgresql.conf:
  file.managed:
    - source:
      - 'salt://conf/postgresql.conf.slave'

/etc/postgresql/10/main/pg_hba.conf:
  file.managed:
    - source:
      - 'salt://conf/pg_hba.conf.slave'
