#!/usr/bin/env python
import numpy as np 
import pandas as pd
from scipy import stats

random_seed = 758223784
np.random.seed(random_seed)


genome_size = 1000000
#1.2-1.3
#storing read locations
chrom = np.zeros(genome_size, int)
start_pos = []
#random sample positions within the 1 mbp genome
#30000 is the number of reads for 3x coverage of a 1mbp genome
for i in range(30000):
    #generate uniform distribution then identify the genome start location
    start = np.random.randint(0,999900)
    start_pos.append(start)
    end = start + 100
    chrom[start:end] += 1

#identifying max hits
max_cov = max(chrom)
poisson = list(range(0,max_cov+1))
#creating histogram of hits for easier visualization in R
chrom1 = np.histogram(chrom,bins=max(chrom)+1)

#pmf and pdf
pmf = stats.poisson.pmf(poisson,mu=3)
pdf = stats.norm.pdf(poisson,loc=np.mean(3), scale=np.sqrt(np.mean(3)))

#scaling
pmf = pmf*genome_size
pdf = pdf*genome_size

denom = sum(chrom1[0])

print(f"Percent of the genome with 0 reads at 3x coverage is {100*(chrom1[0][0]/denom)}")




#dataframe creation
df = pd.DataFrame(poisson,columns=['cnts'])
df['coverage'] = chrom1[0]
df["pmf"] = pmf
df['pdf'] = pdf


df.to_csv('sample_coverage.tsv',sep="\t",index=False)
"""
1.5
"""

chrom1_5 = np.zeros(genome_size,int)
for i in range(100000):
    start = np.random.randint(0,999900)
    end = start + 100
    chrom1_5[start:end] += 1

max_cov2 = max(chrom1_5)
poislist = list(range(max_cov2 +1))

pmf1_5 = stats.poisson.pmf(poislist,mu=10)*genome_size
pdf1_5 = stats.norm.pdf(poislist,loc=10,scale=np.sqrt(10))*genome_size
chrom2 = np.histogram(chrom1_5,bins=max(chrom1_5)+1)

df1 = pd.DataFrame(data={
    "cnts": poislist,
    "coverage": chrom2[0],
    "pmf": pmf1_5,
    "pdf": pdf1_5
}, columns=["cnts",'coverage','pmf','pdf'])
print(f"Percent of the genome with 0 reads at 10x coverage is {(chrom2[0][0]/sum(chrom2[0]))*100}")

df1.to_csv('sample_cov_10x.tsv',sep="\t",index=False)



"""
1.6
"""

chrom30 = np.zeros(genome_size,int)
for i in range(300000):
    start = np.random.randint(0,999900)
    end = start + 100
    chrom30[start:end] += 1

max_cov3 = max(chrom30)
poislist2 = list(range(max_cov3 +1))

pmf30 = stats.poisson.pmf(poislist2,mu=30)*genome_size
pdf30 = stats.norm.pdf(poislist2,loc=30,scale=np.sqrt(30))*genome_size
chrom3 = np.histogram(chrom30,bins=max(chrom30)+1)



df2 = pd.DataFrame(data={
    "cnts": poislist2,
    "coverage": chrom3[0],
    "pmf": pmf30,
    "pdf": pdf30
}, columns=["cnts",'coverage','pmf','pdf'])
print(f"Percent of the genome with 0 reads at 30x coverage is {(chrom3[0][0]/sum(chrom3[0]))*100}")

df2.to_csv('sample_cov_30x.tsv',sep="\t",index=False)


"""
"""

"""
"""

"""
"""

"""
"""

"""
"""

"""
"""

"""
"""

"""
"""
"""
"""
