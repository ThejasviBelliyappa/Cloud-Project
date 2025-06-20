#!/usr/bin/env bash
# wait-for-it.sh from https://github.com/vishnubob/wait-for-it

host="$1"
port="$2"
shift 2
cmd="$@"

echo "Waiting for $host:$port to become available..."

while ! nc -z "$host" "$port"; do
  sleep 1
done

echo "$host:$port is available. Running command: $cmd"
exec $cmd
