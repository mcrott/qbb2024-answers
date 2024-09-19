#!/usr/bin/env python3

import sys
f = open(sys.argv[2])
#input 1,2,3 etc


fields = sys.argv[1].split(',')

final_list = []


for i in f:
    storage_list = []
    for j in fields:
        storage_list.append(i.split()[int(j)])
    print("\t".join(storage_list))
