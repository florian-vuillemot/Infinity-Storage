include:
    - mariadb_10.installed

galera_installed:
    pkg.installed:
        - name: galera-4
        - require:
            - pkgrepo: mariadb_repo

rsync_installed:
    pkg.installed:
        - name: rsync
