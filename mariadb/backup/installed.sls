include:
    - galera.installed

mariadb_backup_installed:
    pkg.installed:
        - name: mariadb-backup
        - refresh: True
        - require:
            - pkg: galera_installed