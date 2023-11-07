#!/bin/bash
#
echo "Started..."
#Started...
#
# special variable $# is the number of arguments
if [ $# -lt 5 ] ; then
    echo 'Call ./<script> <db name> <db user> <db schema> <path to make file> <path to GTFS file>'
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
WORK_DIR="$5"
echo "WORK_DIR: $WORK_DIR"
#
make -C $MAKE_PATH -f Makefile HOST=localhost PORT=5432 USER=$DB_USER DB=$DB_NAME SCHEMA=$DB_SCHEMA GTFS=${WORK_DIR} load
#
echo "Done."
#done.
