/home/node_exporter:
  file.directory:
    - makedirs: True

extract_prometheus:
  archive.extracted:
    - name: /home/node_exporter
    - source: salt://conf/node_exporter-0.11.0.linux-amd64.tar.gz
    - if_missing: /home/node_exporter/node_exporter
    - enforce_toplevel: False

/usr/bin/node_exporter:
  file.symlink:
    - target: /home/node_exporter/node_exporter

/etc/systemd/system/node_exporter.service:
  file.managed:
    - source:
      - 'salt://conf/node_exporter.service'

launch_node_exporter:
  cmd.run:
    - name: systemctl start node_exporter