#!//bin/bash

INPUT=$1

TOTAL=0

while read line;
  do TOTAL=$(($TOTAL$line));
done < $INPUT

echo $TOTAL
