#!/usr/bin/env bash

### Question 1.1 ###

#my unix commands | to perform | Q1.1 analysis here
# A written answer to Question 1.1 based on the output of my code above can go here here.
awk '{print}' A01_09.fastq > line_lengths.txt

### Question 1.2 ####

#my unix commands | to perform | Q1.2 analysis here
# A written answer to Question 1.2 based on the output of my code above can go here here.
awk '{if (length($0) == 76) counter+=1} END {print counter}' A01_09.fastq

#question 1.3
# total of 1339096 reads in A01_09.fastq
#however this includes the quality mapping lines, so 1339096/2 = 669548
# depth of coverge = total number of bases read / genome length = (76 * 669548) / 12000000 = 4.24047066667

#Q1.4
for num in 09 11 23 24 27 31 35 39 62 63
do
    du A01_$num.fastq
done

#Q1.5
fastqc A01_09.fastq