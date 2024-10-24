#!/bin/bash
### echo -e "MAF\tFeature\tEnrichment" > snp_counts.txt

OUTPUT_FILE="snp_counts.txt"


###dont forget the $ to tell it you are referencing a variable

echo -e "MAF\tFeature\tEnrichment" > ${OUTPUT_FILE}

for mafs in 0.1 0.2 0.3 0.4 0.5
do
    file=chr1_snps_$mafs.bed
    bedtools coverage -a genome_chr1.bed -b $file > coverage_output${mafs}.txt
    snpscnt=$(awk '{s+=$4}END{print s}' coverage_output$mafs.txt)
    length=$(awk '{s+=$6}END{print s}' coverage_output$mafs.txt)
    output=$(bc -l -e "$snpscnt / $length")
    for feature in cres exons introns other
    do
        ffile=${feature}_chr1.bed
        bedtools coverage -a $ffile -b $file > feature_$feature_maf_$mafs.txt
        fsnpscnt=$(awk '{s+=$4}END{print s}' feature_$feature_maf_$mafs.txt)
        flength=$(awk '{s+=$6}END{print s}' feature_$feature_maf_$mafs.txt)
        foutput1=$(bc -l -e "$fsnpscnt / $flength")
        final_output=$(bc -l -e "$foutput1 / $output")
        echo -e "${mafs}\t${feature}\t${final_output}" >> snp_counts.txt
    done






done
# for item in ${list_of_iterables[@]}; do
#     echo "$item"
# done

