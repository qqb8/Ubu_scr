#!/bin/bash
n=0
tail -25 stat.log | awk '{if ($2 > 1) exit(2)}'
n1=$?
tail -37 stat.log | awk '{if ($5/$6*100 > 60) exit(3)}'
n2=$?
tail -60 stat.log | awk '{if ($7/$8*100 > 60) exit(4)}'
n3=$?
sum=$(($n1+$n2+$n3))
if [[ $sum -eq 2 ]]; then
  echo "loadavg1 > 1 в течение последних 2 минут"
  (exit 2)
elif [[ $sum -eq 3 ]]; then
  echo "memfree/memtotal > 60% в течение последних 3 минут"
  (exit 3)
elif [[ $sum -eq 4 ]]; then
  echo "diskfree/disktotal > 60% в течение последних 5 минут"
  (exit 4)
elif [[ $sum -eq 5 ]]; then
  echo "loadavg1 > 1 в течение последних 2 минут" 
  echo "memfree/memtotal > 60% в течение последних 3 минут"
  (exit 5)
elif [[ $sum -eq 6 ]]; then
  echo "loadavg1 > 1 в течение последних 2 минут"
  echo "diskfree/disktotal > 60% в течение последних 5 минут"
  (exit 6)
elif [[ $sum -eq 7 ]]; then
  echo "memfree/memtotal > 60% в течение последних 3 минут"
  echo "diskfree/disktotal > 60% в течение последних 5 минут"
  (exit 7)
elif [[ $sum -eq 9 ]]; then
  echo "loadavg1 > 1 в течение последних 2 минут"
  echo "memfree/memtotal > 60% в течение последних 3 минут"
  echo "diskfree/disktotal > 60% в течение последних 5 минут"
  (exit 9)
else
  (exit 0)
fi
