/home/postgres/backup:
    file.directory:
        - user: root
        - makedirs: True

/etc/cron.d/full_postgres_backup:
    file.managed:
        - source:
            - 'salt://conf/cronjob'
        - mode: 644

/usr/bin/full_backup:
    file.managed:
        - source:
            - 'salt://conf/full_backup'
        - mode: 755

launch_full_backup_cronjob:
    cmd.run:
        - name: crontab /etc/cron.d/full_postgres_backup
