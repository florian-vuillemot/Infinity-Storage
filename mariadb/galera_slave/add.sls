mysql_stop_slave:
    cmd.run:
        - name: systemctl stop mysql

/etc/mysql/conf.d/galera.cnf:
    file.managed:
        - source:
            - 'salt://conf/galera.cnf'

mysql_start_slave:
    cmd.run:
        - name: systemctl start mysql
