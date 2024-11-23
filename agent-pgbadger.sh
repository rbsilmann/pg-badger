#!/bin/bash

# Read file with variables
source /pg_badger/.variables_badger

# Remove log files older 3 days
find $PGDATA/log/* -name "*.log" -mtime +3 -exec rm {} \;

# Generate report
pgbadger -o /tmp/"$CUSTOMER"-"$DATEREPORT".html $PGDATA/log/*

# Send report
sendEmail -f $SOURCEMAIL \
	-t $DESTMAIL \
	-s smtp.gmail.com:587 \
	-u "Customer report - PGBadger: $CLIENT" \
	-m "Greetings, follow the report of the day: $DATEREPORT" \
	-a /tmp/"$CUSTOMER"-"$DATEREPORT".html \
	-xu $SOURCEMAIL \
	-xp $EMAILPASS \
	-o tls=yes
