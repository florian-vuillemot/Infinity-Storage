include:
  - server.installed

/home/backup_to_slave.sh:
  file.managed:
    - source:
      - 'salt://conf/backup_to_slave.sh'
    - mode: 644

run_backup:
  cmd.run:
    - name: bash /home/backup_to_slave.sh
    - require:
      - file: /home/backup_to_slave.sh

