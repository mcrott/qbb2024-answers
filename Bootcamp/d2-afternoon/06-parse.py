#!/usr/bin/env python3
import sys
f = open(sys.argv[1])

for i in f:
    if "##" in i:
        continue
    fields = i.split("\t")
    print(fields)
    if "gene" == fields[2]:
        print(fields)

f.close()