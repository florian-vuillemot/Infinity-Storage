/home/prometheus/server:
  file.directory:
    makedirs: True

extract_prometheus:
  archive.extracted:
    - name: /home/prometheus/server
    - source: salt://conf/prometheus-0.15.1.linux-amd64.tar.gz
    - if_missing: /home/prometheus/server/prometheus


