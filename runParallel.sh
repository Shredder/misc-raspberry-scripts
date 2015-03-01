#!/bin/bash

showHelp() {
    cmd=`basename $0`
    cat <<EOT
$cmd -- Run in parallel

Usage: $cmd [-c CMD] [-h] [-j N] [-n] dirs

Options:
    -c: command to run (default: 'pwd')
    -h: show help
    -j N: number of concurrent jobs (default: 1)
    -n: don't cd into job directory
EOT
}


cmd='pwd'
nJobs=1
nocd='true'

OPTIND=1
while getopts "c:hj:n" opt; do
    case "$opt" in
        c) cmd="$OPTARG"
           ;;
        h) showHelp
           exit 0
           ;;
        j) nJobs="$OPTARG"
           ;;
        n) nocd='false'
           ;;
    esac
done
shift $((OPTIND-1))

[[ "$1" == "--" ]] && shift

if [[ -z "$@" ]]; then
    showHelp
    exit 0
fi

read -d '' script <<EOT
t1=\$(date)
echo "Starting job JOB at \$t1."
t1=\$(date +%s)
($nocd && cd JOB; $cmd)
t2=\$(date +%s)
m=\$(bc -l <<< "scale=1; (\$t2 - \$t1) / 60")
t2=\$(date)
echo "Job JOB finished at \$t2 (\$m minutes)."
EOT

for i in "$@"; do
    echo $i
done | xargs -P"$nJobs" -n1 -I JOB bash -c "$script"
