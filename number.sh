#!/bin/bash
echo "Input 1st number"
read n1 
echo "Input 2nd number"
read n2
if [[ $n1 -lt $n2 ]]; then
    let a=$n2-$n1
    echo $a
elif [[ $n1 -gt $n2 ]]; then
    let a=$n1-$n2
    echo $a
elif [[ $n1 == $n2 ]]; then
    let a=$n1**2
    echo $a
fi
