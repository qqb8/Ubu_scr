#!/bin/bash
for((i=1;i<=100;i+=1))
do
  let a=$i%3
  if [[ $a -eq 0 ]]; then
    echo $i
  fi
done
