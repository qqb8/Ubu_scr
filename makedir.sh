#!/bin/bash
echo "Enter the path to create the directory"
read name
if [[ -d $name ]]; then
echo "This directory have been exist"
else
mkdir /$name
echo "Successfully"
fi;
