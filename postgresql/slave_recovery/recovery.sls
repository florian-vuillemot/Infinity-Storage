include:
  - server.installed

/var/lib/postgresql/10/main/recovery.conf:
  file.managed:
    - source:
      - 'salt://conf/recovery.conf'

restart_slave:
  cmd.run:
    - name: systemctl start postgresql