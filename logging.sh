#!/bin/bash
while true; do
 date_now=$(date +%H:%M:%S)
 avg_now=$(cat /proc/loadavg | awk '{print $1" "$2" "$3}')
 free_now=$(free | sed '2!d' | awk '{print $4" "$2}')
 disk_now=$(df | sed '3!d' | awk '{print $4" "$2}')
 bash -lc "echo -n $date_now\ && echo -n $avg_now\ && echo -n $free_now\ && echo $disk_now" >> stat.log
 sleep 5
done
