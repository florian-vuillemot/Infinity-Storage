open_mysql_port:
    iptables.append:
        - chain: INPUT
        - jump: ACCEPT
        - dport: 3306
        - protocol: tcp
        - in-interface: enp0s3
        - save: True

