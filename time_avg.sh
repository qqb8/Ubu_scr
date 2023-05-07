#!/bin/bash
while true; do
  date && cat /proc/loadavg
  echo ---
  sleep 5
done
