#!/usr/bin/env python3

# Compare to grep -v "#" | cut -f 1 | uniq -c
# ... spot and fix the three bugs in this code

import sys

my_file = open( sys.argv[1] )

chr = ""
count = 0
count_dict = {}
for my_line in my_file:
    #skipping lines in column 0 that contains #. this is confirmed to work
    if "#" in my_line:
        continue
    #splitting the line by a tab delimiter
    fields = my_line.split("\t")
    #if the first item in my list after splitting by a delimiter is not empty, then continue
    if fields[0] != chr:
        if fields[0] not in count_dict.keys():
            count_dict[fields[0]] = 1
            continue
        count_dict[fields[0]] += 1
        #if we make it here, we should move character to 
        #print( count, chr )
        #chr = fields[0]
        #count = 0


for i in count_dict.keys():
    print(str(count_dict[i]) + " " + i)

#print(count_dict)

my_file.close()