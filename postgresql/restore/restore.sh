#!/bin/sh

BACKUP_FILE=/home/postgres/backup/`ls /home/postgres/backup/ -ltr | tr ' ' '\n' | tail -n1`
echo $BACKUP_FILE
su postgres -c "psql -f $BACKUP_FILE postgres"
