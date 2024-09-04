#!/usr/bin/env python3

import sys


f =  open(sys.argv[1])

i = 0 

for line in f:
    line = line.rstrip("\n")
    print(line)
    i += 1
    if i == 10:
        break



f.close()

