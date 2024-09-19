#!/usr/bin/env python3

import sys




f = open(sys.argv[1])

#Index 0 = Chromosome, 3 = gene start, 4= gene stop, 13 = gene name
fields = [0,3,4,13]


for i in f:
    storage_list = []
    for j in fields:
        storage_list.append(i.split()[int(j)].strip(' "" ').strip(';').strip(' " '))
    print("\t".join(storage_list))



