cat temp.txt | sed -re 's/(zer1?o)/0\10/g' -re 's/(o[02]?n8?e)/1\11/g' -re 's/(t8?w1?o)/2\12/g' -re 's/(t8?hre8?e)/3\13/g' -re 's/(four)/4\14/g' -re 's/(fiv8?e)/5\15/g' -re 's/(six)/6\16/g' -re 's/(seve9?n)/7\17/g' -re 's/(e[1359]?igh[23]?t)/8\18/g' -re 's/(n7?in8?e)/9\19/g' | sed -re 's/[^0-9]*([0-9])(.*([0-9]))?[^0-9]*/\1\1\3/' | sed -re 's/.?(..)/\1/' | paste -sd+ - | awk '{print $1"\n"}' | bc
