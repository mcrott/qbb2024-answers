#!/usr/bin/env bash
#starting on 2.2. 

#for my_sample in 09 11 23 24 27 31 35 39 62 63
#do
#    bwa mem -t 4 -r "@RG\tID:Sample1\tSM:$my_sample" sacCer3.fa A01_$my_sample.fastq  > ${my_sample}.sam
#    samtools sort -@ 4 -O bam -o ${my_sample}.bam ${my_sample}.sam
#    samtools index ${my_sample}.bam
#done

#finding line nums 
wc -l 09.sam
#find num chrIIIs 
grep -w chrIII 09.sam | wc -l




