#!/bin/bash
#
echo "Started..."
#Started...
#
# special variable $# is the number of arguments
if [ $# -lt 4 ] ; then
    echo 'Call ./<script> <db name> <db user> <db schema> <make file path>'
    exit 1
fi
#
DB_NAME="$1"
echo "DB_NAME: $DB_NAME"
DB_USER="$2"
echo "DB_USER: $DB_USER"
DB_SCHEMA="$3"
echo "DB_SCHEMA: ${DB_SCHEMA}"
MAKE_PATH="$4"
echo "MAKE_PATH: ${MAKE_PATH}"
#
psql -h localhost -p 5432 -U $DB_USER -f ${MAKE_PATH}/sql/drop-schema.sql -d $DB_NAME -v schema=$DB_SCHEMA
#
make -C $MAKE_PATH -f Makefile HOST=localhost PORT=5432 USER=$DB_USER DB=$DB_NAME SCHEMA=$DB_SCHEMA init
#
echo "Done."
#done.
