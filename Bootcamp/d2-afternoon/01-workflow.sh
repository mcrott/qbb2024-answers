#!/bin/bash

#unix stores command line arguments in $0 and $1
echo "0th: " $0
echo "1st: " $1 

cut -f 1 $1 > column.txt
sort column.txt | uniq -c 