postgresql_installed:
  pkg.installed:
    - pkgs:
      - postgresql
      - postgresql-contrib
      - postgresql-client
    - refresh: True

