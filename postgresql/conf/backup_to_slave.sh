psql -c "select pg_start_backup('initial_backup');"
rsync -cva --inplace --exclude=*pg_xlog* /var/lib/postgresql/10/main/ slave_IP_address:/var/lib/postgresql/10/main/
psql -c "select pg_stop_backup();"
