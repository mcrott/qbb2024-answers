## Q1.1

They are 76 bases long. The output of awk print length was 
1
76
34
76
+ many more
I outputed part of the A01 to a text.txt file to determine what lines were relevant. 
## Q1.2
total of 1339096 reads in A01_09.fastq
#however this includes the quality mapping lines, so 1339096/2 = 669548

## Q1.3
depth of coverge = total number of bases read / genome length = (76 * 669548) / 12000000 = 4.24047066667
## Q1.4
224512  A01_27.fastq has the smallest file size at 224mb. 


## Q1.5

What is the median base quality along the read? 
- 37
How does this translate to the probability that a given base is an error? 
- My assumption is that a lower median base quality would indicate that a given base is an error. 
Do you observe much variation in quality with respect to the position in the read?
- yeah.  It seems that 12-66 have a higher score than the outside 10-12 bases. 


## Q2.1
Yeast have 16 chromosomes and 1 for the mitochrondian chromosome according to the sacCer3.fa.ann file
## Question 2.2: How many total read alignments are recorded in the SAM file?
 669567 09.sam as an output for wc -l.  There are 20 header lines, so 669547 reads 
## Question 2.3: How many of the alignments are to loci on chromosome III?
18195 

## Question 2.4: Does the depth of coverage appear to match that which you estimated in Step 1.3? Why or why not?
- Yes and no. There are some areas where the depth of coverage exceeds what I expected but also some where it does not. 
## Question 2.5: Set your window to chrI:113113-113343 (paste that string in the search bar and click enter). How many SNPs do you observe in this window? Are there any SNPs about which you are uncertain? Explain your answer.
- 15 snps.  Yes. There are only 3 snps that are consistent(in >80% of the reads) while the other 12 appear once in certain reads. 
## Question 2.6: Set your window to chrIV:825548-825931. What is the position of the SNP in this window? Does this SNP fall within a gene?
- 825,834 = position
- No. This snp does not fall within a gene. Its flanked by SCC2 and SAS4 on its left and right respectively. 
## Question 3.1
- This is a normal distribution. Considering allele frequency seems to be centered at around 0.5, I would assume that this is based on random selection. While alleles that are more detrimental to the organisms survival would slowly thin out to a lower allele frequency and the better towards a higher frequency. 