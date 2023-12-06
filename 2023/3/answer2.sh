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
  FINDS=" :"

  getNum(){
    l="$1"
    p="$2"
    r=0
    while [[ "${l:$((p-1)):1}" =~ ^[0-9]$ ]]; do
      p=$((p-1))
    done

    c="${l:$p:1}"
    while [[ "$c" =~ ^[0-9]$ ]]; do
      r=$(($r*10))
      r=$(($r+$c))

      p=$((p+1))
      c="${l:$p:1}"
    done

    echo "$r"
  }


  for col in `seq 0 $((cols-1))`; do
    char="${line:$col:1}"
    gears=0
    matches=""

    char_ul="${line_u:$((col-1)):1}"
    char_u="${line_u:$col:1}"
    char_ur="${line_u:$((col+1)):1}"
    char_l="${line:$((col-1)):1}"
    char_r="${line:$((col+1)):1}"
    char_dl="${line_d:$((col-1)):1}"
    char_d="${line_d:$col:1}"
    char_dr="${line_d:$((col+1)):1}"

    echo -n "$char"

    if [[ "$char" =~ ^\*$ ]]; then
      if [[ "$char_l" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line $((col-1)))"
      fi

      if [[ "$char_r" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line $((col+1)))"
      fi

      if [[ "$char_ul" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_u $((col-1)))"
        if [[ "$char_u" =~ ^[0-9]$ ]]; then
          char_u="."
          if [[ "$char_ur" =~ ^[0-9]$ ]]; then
            char_ur="."
          fi
        fi
      fi
      if [[ "$char_u" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_u $((col)))"
        if [[ "$char_ur" =~ ^[0-9]$ ]]; then
          char_ur="."
        fi
      fi
      if [[ "$char_ur" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_u $((col+1)))"
      fi
      if [[ "$char_dl" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_d $((col-1)))"
        if [[ "$char_d" =~ ^[0-9]$ ]]; then
          char_d="."
          if [[ "$char_dr" =~ ^[0-9]$ ]]; then
            char_dr="."
          fi
        fi
      fi
      if [[ "$char_d" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_d $((col)))"
        if [[ "$char_dr" =~ ^[0-9]$ ]]; then
          char_dr="."
        fi
      fi
      if [[ "$char_dr" =~ ^[0-9]$ ]]; then
        gears=$((gears+1))
        matches="$matches*$(getNum $line_d $((col+1)))"
      fi

      FINDS="$FINDS:$matches"

      if [ $gears == 2 ]; then
        ratio="$(echo "${matches:1}" | bc)"
        total=$(($total+$ratio))
      fi
    fi
  done
  echo $FINDS
done

echo $total
