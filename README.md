# pgbadger

>Description:
>Observability project with PGBadger.

>Requirements:
>* Operational system: tested on CentOS
>* PostgreSQL version: tested on PostgreSQL 12
>* Packages: pgbadger and sendemail

>Step by step:
>1. sudo yum -y install pgbadger sendemail
>2. sudo mkdir /pg_badger
>3. Put the files '.variables_badger', 'agent-pgbadger.sh' and 'alter_system.sql' on directory /pg_badger
>4. Edit '.variables_badger' with your informations
>5. source /pg_badger/.variables_badger && psql -U $PGUSER -p $PGPORT -f /pg_badger/alter_system.sql
>6. Restart your PostgreSQL Server
