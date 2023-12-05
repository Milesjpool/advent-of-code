cat input.txt | grep -v -e "\(1[3-9]\|[2-9][0-9]\) red" | grep -v -e "\(1[4-9]\|[2-9][0-9]\) green" | grep -v -e "\(1[5-9]\|[2-9][0-9]\) blue" | sed -re 's/Game ([0-9]+): .*/\1/' | paste -sd+ - | bc                       
2617
