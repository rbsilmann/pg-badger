#!/bin/bash

# Ler as variaveis para executar os comandos.
source /pg_badger/.variables_badger

# Verificar e remover logs mais antigos que tres dias.
find $PGDATA/log/* -name "*.log" -mtime +3 -exec rm {} \;

# Gerar relatorio com base na pasta log.
pgbadger -o /tmp/"$CLIENT"-"$DATEREPORT".html $PGDATA/log/*

# Enviar relatorio gerado via email.
sendEmail -f $SOURCEMAIL \
	-t $DESTMAIL \
	-s smtp.gmail.com:587 \
	-u "Customer report - PGBadger: $CLIENT" \
	-m "Greetings, follow the report of the day: $DATEREPORT" \
	-a /tmp/"$CLIENT"-"$DATEREPORT".html \
	-xu $SOURCEMAIL \
	-xp $EMAILPASS \
	-o tls=yes
