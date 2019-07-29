base:
  '*':
    - server
    - backup
  'master*':
    - master_configuration
  'slave*':
    - slave_configuration
