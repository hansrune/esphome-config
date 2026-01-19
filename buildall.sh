#!/bin/bash
PROG=$( basename $0 .sh )
TSTAMP=$( date +%s )
ERRORS=""

ESPHOME=$( type -p esphome )
if [ -n "$ESPHOME" ]
then
    echo "$PROG: Using esphome from $ESPHOME"
else
    echo "$PROG: No esphome in $PATH ... "
    exit 2
fi

mkdir -p logs/
for F in *.yaml
do
    [ "$F" = "secrets.yaml" ] && continue
    LOGFILE="logs/${F%.yaml}-${TSTAMP}.log"
    echo "$PROG: ------------------------------------------------------------------------------------------"
    echo "$PROG: Building ${F%.yaml} - logs to $LOGFILE"
    echo "$PROG: ------------------------------------------------------------------------------------------"
    esphome compile "$F" >& "$LOGFILE" || ERRORS="$ERRORS $LOGFILE"
done

if [ -n "$ERRORS" ]
then
    echo "$PROG: Errors in $ERRORS"
else
    echo "$PROG: All builds OK"
fi
