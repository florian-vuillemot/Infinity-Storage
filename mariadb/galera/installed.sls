include:
    - mariadb_10.installed

galera_installed:
    pkg.installed:
        - name: mariadb-server
        - refresh: True
        - require:
            - pkgrepo: mariadb_repo
