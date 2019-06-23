include:
    - galera.installed

galera_arbitrator_installed:
    pkg.installed:
        - name: galera-arbitrator-4
        - require:
            - pkg: galera_installed