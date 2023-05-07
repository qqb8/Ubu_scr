#!/bin/bash
echo "Input path to directory:"
read dir
for file in $dir/*.*; do
  if [ -f "$file" ]; then
    echo -n $file\ && stat -c %F $file 
  fi
done
