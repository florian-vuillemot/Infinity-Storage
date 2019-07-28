#!/bin/sh

BACKUP_FILE=/home/mongodb/backup/`ls /home/mongodb/backup/ -ltr | tr ' ' '\n' | tail -n1`
echo $BACKUP_FILE
mongorestore --drop $BACKUP_FILE 
