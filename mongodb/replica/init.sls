/home/log/mongodb:
    file.directory:
        - makedirs: True
        - user: mongodb
        - group: mongodb
        - mode: 774

/home/mongodb/mongodb-data
  file.directory:
    - user: mongodb
    - group: mongodb
    - mode: 774
    - recurse:
      - user
      - group


/etc/mongod.conf:
    file.managed:
        - source:
            - 'salt://conf/replica.conf'

launch_mongo:
    cmd.run:
      - name: systemctl start mongod
