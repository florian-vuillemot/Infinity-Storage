stop_mariadb:
  cmd.run:
    - name: systemctl stop mysql

remove_mysql_data:
  file.absent:
    - name: /var/lib/mysql

run_restore:
  cmd.script:
    - source: salt://restore/restore.sh

start_mariadb:
  cmd.run:
    - name: systemctl start mysql