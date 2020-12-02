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
    lower = int(m.group(1))
    upper = int(m.group(2))

    count = word.count(char)

    if (count >= lower) and (count <= upper):
        num_correct+=1

print(num_correct)

