
## 1.1
How many 100bp reads are needed to sequence a 1Mbp genome to 3x coverage?


> 3*1Mbp = 3Mbp/100bp-read = 30k reads


## 1.4

5.1% of the genome has not been sequenced

The poisson distribution is overlaid with the coverage distribution/histogram. 

## 1.5

0.0031000000000000003 % of the genome has been sequenced with 0 reads. 
Same with 1.4. The poisson distribution is on top of the coverage distribution. 

## 1.6
0.0006000000000000001 % of the genome has been sequenced with 0 reads. 
Both the poisson and normal distribution fit the data extremely well. Most likely due to greater coverage of the genome with the 30x read. 

## 2.1
Duplicate edges are present, total was 14 uniques

## 2.4
See python script

## 2.5
TTC
 ||
 TCT
  ||
  CTT
   ||
   TTA
    ||
    TAT
     ||
     ATT
      ||
      TTG
       ||
       TGA
        ||
        GAT
         ||
         ATT
          ||
          TTC
           ||
           TCT
            ||
            CTT
             ||
             TTA
              ||
              TAT
               ||
               ATT
                ||
                TTG
                 ||
                 TGA
                  ||
                  GAT
                   ||
                   ATT
                    ||
                    TTC
                     ||
                     TCT
                      ||
                      CTT
                       ||
                       TTA
                        ||
                        TAT

COUNT: 
ATT-5
TTC-3
TCT-3
CTT-3
TTA-3
TAT-3
TTG-3
TGA-3
GAT-3

TTCTTATTGATTCTTATTGATTGATTCTTAT

## 2.6
Rough question. First you would need sufficient coverage of the genome, ie 30-40x. Secondly, you would need a fantastic algorithm to search for kmers. We only used k=3, but id suspect you would want upwards to k=500 to 1000 for accurate coverage. 

