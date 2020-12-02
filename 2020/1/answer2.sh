#!//bin/bash

INPUT=$1

TARGET=2020

while read VAL; do
  TARGET2=$((TARGET-VAL))
  while read VAL2; do
    REM=$((TARGET2-VAL2))
    if grep -q "^$REM$" $INPUT; then echo $((VAL*VAL2*REM)) && exit; fi
  done < $INPUT
done < $INPUT

