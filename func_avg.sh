#!/bin/bash
read dir
file_avg () {
echo "Input path to directory:"
i=0
sum=0
size=0
  if [[ -d $1 ]]; then
    for file in $1/*.*; do
      if [ -f "$file" ]; then
        ((i+=1)) && size=$(stat -c %s $file) && sum=$(($sum+$size));
      fi
    done
  echo $sum
  echo $i
  avg=$(($sum/$i))
  echo $avg
  else
    echo "No such directory"
  fi
}

file_avg $dir
