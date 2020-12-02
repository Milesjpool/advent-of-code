#!/usr/bin/python
import sys
import re

inputs = open(sys.argv[1], 'r')

pattern = re.compile(r"^(\d+)-(\d+) (\w): (\w*)$")

num_correct = 0

Lines = inputs.readlines()
for line in Lines:
    m = pattern.match(line)

    word = m.group(4)
    char = m.group(3)
    pos1 = int(m.group(1))-1
    pos2 = int(m.group(2))-1

    if ((word[pos1] == char) != (word[pos2] == char)):
        num_correct+=1

print(num_correct)

