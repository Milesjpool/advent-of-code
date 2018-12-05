#!//bin/bash

INPUT=$1

TOTAL=0
APPEND=true;
ARRAY=(0)

while true; do
  echo reading;
  while read line; do
    TOTAL=$(($TOTAL$line));
    if [[ " ${ARRAY[@]} " =~ " ${TOTAL} " ]]; then
      echo $TOTAL;
      exit 0;
    fi
    if $APPEND; then
      ARRAY+=($TOTAL)
    fi
  done < $INPUT
  APPEND=false;
done
