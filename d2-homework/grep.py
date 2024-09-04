#!/usr/bin/env python3

import sys

f = open(sys.argv[1])

for i in f:
    good_line = i.split()
    if sys.argv[2] in good_line:
        print(i.replace("\n",""))



f.close()