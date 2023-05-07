#!/bin/bash
echo "Please, input filename with extension (like 'name.ext')"
read name
case "$name" in
  (*.jpg|*.gif|*.png)
  echo "Image file"
  ;;
  *.mp3|*.wav)
  echo "Media file"
  ;;
  *.txt|*.doc)
  echo "Text file"
  ;;
  *)
  echo "Unknown type file"
  ;;
esac

