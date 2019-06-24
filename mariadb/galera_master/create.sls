mysql_stop_master:
    cmd.run:
        - name: systemctl stop mysql

create_galera_cluster:
    cmd.run:
        - name: galera_new_cluster

/etc/mysql/conf.d/galera.cnf:
    file.managed:
        - source:
            - 'salt://conf/galera.cnf'
