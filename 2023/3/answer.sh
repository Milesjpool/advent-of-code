#!/bin/bash

F=input.txt

total=0

rows=`awk 'END{print NR}' $F`
for row in `seq 1 $rows`; do
  line=`sed "${row}q;d" $F`
  tmp=`echo -n $line | sed -re 's/././g'`

  [[ $row == 1 ]] && line_u="$tmp" || line_u=`sed "$(($row-1))q;d" $F`
  [[ $row == $rows ]] && line_d="$tmp" || line_d=`sed "$(($row+1))q;d" $F`

  cols=${#line}
  number_in_progress=0
  commit_number=0
  FINDS=" :"
  for col in `seq 1 $cols`; do
    char="${line:$((col-1)):1}"

    char_u="${line_u:$((col-1)):1}"
    char_d="${line_d:$((col-1)):1}"

    echo -n "$char"

    if [[ "$char" =~ ^[0-9]$ ]]; then
      number_in_progress=$(($number_in_progress*10))
      number_in_progress=$(($number_in_progress+$char))
      if [[ "$char_u" =~ ^[^.0-9]$ ]] || [[ "$char_d" =~ ^[^.0-9]$ ]]; then
          commit_number=1
      fi
    fi

    if [[ "$char" =~ ^\.$ ]] || [ $col == $cols ]; then
      if [[ "$char_u" =~ ^[^.0-9]$ ]] || [[ "$char_d" =~ ^[^.0-9]$ ]]; then
            commit_number=1
      fi

      if [ $commit_number == 1 ]; then
         if [ $number_in_progress -gt 0 ]; then FINDS="$FINDS:$number_in_progress"; fi
         if [ $number_in_progress -gt 1000 ]; then echo [============WARN!!!! committing $number_in_progress]; fi

         total=$(($total+$number_in_progress))
      fi

      if [[ ! "$char_u" =~ ^[^.0-9]$ ]] && [[ ! "$char_d" =~ ^[^.0-9]$ ]]; then
            commit_number=0
      fi
      number_in_progress=0
    fi

    if [[ "$char" =~ ^[^.0-9]$ ]]; then
      if [ $number_in_progress -gt 0 ]; then FINDS="$FINDS:$number_in_progress"; fi
      if [ $number_in_progress -gt 1000 ]; then echo [==========WARN!!!! committing $number_in_progress]; fi

      total=$(($total+$number_in_progress))
      commit_number=1
      number_in_progress=0
    fi

  done
  echo # $FINDS
done

echo $total
