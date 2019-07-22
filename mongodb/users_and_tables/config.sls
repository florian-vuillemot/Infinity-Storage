include:
    - server.installed

python3-pymongo:
    pkg.installed

/home/hydrate.py:
    file.managed:
        - source:
            - 'salt://conf/hydrate_users_and_tables.py'
        - mode: 644

hydrate_database:
  cmd.run:
    - name: /usr/bin/python3 /home/hydrate.py
    - require:
      - file: /home/hydrate.py
