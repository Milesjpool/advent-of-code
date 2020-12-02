#!//bin/bash

INPUT=$1

TARGET=2020

while read VAL; do
  REM=$((TARGET-VAL))
  if grep -q "^$REM$" $INPUT; then echo $((VAL*REM)) && exit; fi
done < $INPUT

