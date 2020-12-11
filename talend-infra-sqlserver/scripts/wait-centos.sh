#!/bin/sh
HOST=$1
PORT=$2
TIMEOUT=$3
INITIAL_WAIT=$4

if [ -z "$TIMEOUT" ]; then TIMEOUT=15; fi
if [ ! -z "$INITIAL_WAIT" ]; then sleep $INITIAL_WAIT; fi

currentSeconds=0
while true; do
  RESPONSE=$(curl -sLf -m 2 -w "%{http_code}\n" "http://$HOST:$PORT/" -o /dev/null)
  if [ "$RESPONSE" -ne "000" ]; then echo "Host $HOST returned $RESPONSE"; exit 0; fi
  currentSeconds=$((currentSeconds + 1))
  if [ $currentSeconds -gt $TIMEOUT ]; then echo "Host $HOST timedout"; exit 0; fi
  sleep 1; echo "Waiting on host: $HOST. Seconds: $currentSeconds"
done