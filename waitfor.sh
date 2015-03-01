#!/bin/bash

pid=$1
shift
cmd="$@"

delay=60 # seconds
status=0

while : ; do
    ps -p $pid > /dev/null
    status=$?
    [[ $status == 0 ]] || break
    echo "Process $pid still active. Sleeping for $delay seconds."
    sleep $delay
done

echo "Executing '$cmd' at $(date)."
eval "$cmd"
