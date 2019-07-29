postgresql_installed:
  pkg.installed:
    - pkgs:
      - postgresql
      - postgresql-contrib
    - refresh: True

