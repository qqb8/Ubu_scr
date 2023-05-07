#!/bin/bash
echo "Input address"
read addr
echo "Input port"
read port
timeout 2 nc -z $addr $port;
a=$?
if [[ a -eq 0 ]]; then
  echo "Available source"
  logger "source" $addr":"$port "is available"
elif [[ a -ge 1 ]]; then
  echo "Unavailable source"
  logger "source" $addr":"$port "is unavailable"
fi
