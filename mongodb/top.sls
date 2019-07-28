base:
  '*':
    - server
    - backup
    - replica
    'master*':
      - users_and_tables
