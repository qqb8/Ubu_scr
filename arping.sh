#!/bin/bash

# [PREFIX].[SUBNET].[HOST] [INTERFACE]"
# ex.: 192.168.1.23 enp0s8"

IP="${1:-NOT_SET}"
INTERFACE="$2"

PREFIX=$(echo "$IP" | awk -F "." '{print $1"."$2}')
SUBNET=$(echo "$IP" | awk -F "." '{print $3}')
HOST=$(echo "$IP" | awk -F "." '{print $4}')

trap 'echo "Ping exit (Ctrl+C)"; exit 1' 2

username=$(id -nu)

if [ "$username" != "root" ]; then
  echo "Must be root to run \"$(basename "$0")\"."
  exit 1
else 
  [[ "$IP" = "NOT_SET" ]] && { echo "\$PREFIX.\$SUBNET.\$HOST must be passed as first positional argument"; exit 1; }
  if [[ -z "$INTERFACE" ]]; then
      echo "\$INTERFACE must be passed as second positional argument"
      exit 1
  fi
# exist $SUBNET & $HOST
  if [[ -n "$SUBNET" ]] && [[ -n "$HOST" ]]; then
    if [[ "${PREFIX}.${SUBNET}.${HOST}" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
      echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
      arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
    else
      echo "Wrong address mask"
      exit 1
    fi
# exist $SUBNET
  elif [[ -n "$SUBNET" ]]; then
    if [[ "${PREFIX}.${SUBNET}" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
      for HOST in {1..255}
        do
          echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
          arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
      done
    else
      echo "Wrong address mask"
      exit 1
    fi
# only $PREFIX
  else
    if [[ "${PREFIX}" =~ ^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$ ]]; then
      for SUBNET in {1..255}
        do
          for HOST in {1..255}
            do
              echo "[*] IP : ${PREFIX}.${SUBNET}.${HOST}"
              arping -c 3 -i "$INTERFACE" "${PREFIX}.${SUBNET}.${HOST}" 2> /dev/null
          done
      done
    else
      echo "Wrong address mask"
      exit 1
    fi
  fi
fi
