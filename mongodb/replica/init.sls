/etc/mongod.conf:
    file.managed:
        - source:
            - 'salt://conf/replica.yaml'

launch_mongo:
    cmd.run:
      - name: systemctl start mongod
