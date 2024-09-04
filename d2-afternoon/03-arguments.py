#!/usr/bin/env python3
import sys 

print(sys.argv)
num_arg = len(sys.argv)
print(num_arg)


print("Number of arguments:  " + str(num_arg))


i=0

for my_arg in sys.argv:
    print(str(i) + "th argument is " + sys.argv[i])
    i += 1