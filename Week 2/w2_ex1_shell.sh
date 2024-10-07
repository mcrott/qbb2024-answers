#!/bin/bash
for type in exons tx cres
do
    bedtools sort ${type}.bed > ${type}_sorted.bed
    bedtools merge ${type}_sorted.bed > ${type}_chr1.bed
done

bedtools subtract -a tx_chr1.bed -b exons_chr1.bed > introns_chr1.bed
bedtools subtract -a genome_chr1.bed -b exons_chr1.bed introns_chr1.bed cres_chr1.bed > other_chr1.bed
