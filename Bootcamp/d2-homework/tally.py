#!/usr/bin/env python3

# Compare to grep -v "#" | cut -f 1 | uniq -c
# ... spot and fix the three bugs in this code

import sys

my_file = open( sys.argv[1] )

chr = ""
count = 1

for my_line in my_file:
    if "#" in my_line:
        continue
    fields = my_line.split("\t")
    if fields[0] != chr:
        if chr != "":
            print( count, chr )
        chr = fields[0]
        count = 1
        continue
    count = count + 1

print(count, chr)

my_file.close()