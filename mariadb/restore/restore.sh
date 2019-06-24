#!/bin/sh

BACKUP_FILE=/var/mariadb/backup/`ls /var/mariadb/backup/ -ltr | tr ' ' '\n' | tail -n1`
echo $BACKUP_FILE > /tmp/test
mariabackup --prepare --target-dir=$BACKUP_FILE
mariabackup --copy-back --target-dir=$BACKUP_FILE
chown -R mysql:mysql $BACKUP_FILE
