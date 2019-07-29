create_rep_user:
  cmd.run:
    - name: psql -c "CREATE USER rep REPLICATION LOGIN CONNECTION LIMIT 1 ENCRYPTED PASSWORD 'Epitech42*';"
    - runas: postgres

/etc/postgresql/10/main/postgresql.conf:
  file.managed:
    - source:
      - 'salt://conf/postgresql.conf.master'

/etc/postgresql/10/main/pg_hba.conf:
  file.managed:
    - source:
      - 'salt://conf/pg_hba.conf.master'

restart_postgres_master:
  cmd.run:
    - name: systemctl restart postgresql