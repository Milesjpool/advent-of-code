cat input.txt | sed -re 's/[^0-9]*([0-9])(.*([0-9]))?[^0-9]*/\1\1\3/' | sed -re 's/.?(..)/\1/' | paste -sd+ - | awk '{print $1"\n"}' | bc
