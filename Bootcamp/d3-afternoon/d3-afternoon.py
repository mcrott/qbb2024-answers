#!/usr/bin/env python3
import sys



#file ='/Users/cmdb/qbb2024-answers/d3-afternoon/GTEx_Analysis_2017-06-05_v8_RNASeQCv1.1.9_gene_median_tpm.gct'

"""
open file
skip 2 lines
split column header by tabs and skip first two entries
create way to hold gene names
create way to hold gene IDS
create way to hold expression values
for each line
    split line
    save field 0 into gene IDs
    save field 1 into gene names
    save 2+ into expression values



"""

'''
#group work Q1

#!/user/bin/env python
import sys
import numpy 

f = open(sys.argv[1], "r'")
f.readline()
f.readline()
line = fs.readline()
fields = line.split("\t")
tissues = fields[2:]
print(tissues)

gene_names = []
gene_ids = []
expression = []

for line in f:
    fields = line.strip("\n").split("\t")
    gene_IDS.append(fields[0])
    gene_names.append(fields[1])
    expression.append(fields[2:])

fs.close()


gene_IDs = numpy.array(gene_IDs)
gene_names = numpy.array(gene_names)
expression = numpy.array(expression,float)
'''

file = sys.argv[1]




print(file)
import numpy as np
import pandas as pd
raw = open(file,'r')

#group work Q1
raw.readline()
raw.readline()

#split the header by tab
work_together_tissue = raw.readline().split("\t")
#remove \n at the end of "Whole Blood"
work_together_tissue[-1] = work_together_tissue[-1].strip()



j = 0
for i in raw:
    
    j += 1
    if j > 10:
        break




#Q1
df = pd.read_csv(file,sep='\t',skiprows=[0,1])
tissue_names = df.columns[2:]
gene_id = df["Name"]
gene_name = df["Description"]
expression_levels = df.iloc[:,2:]


#Q2
tissue_names = np.array(tissue_names)
gene_id = np.array(gene_id)
gene_name = np.array(gene_name)
expression_levels = np.array(expression_levels, float)


"""
np can interpret "1.0023212" as either a string or a float. Or it could be completely wrong and
mark it as a int. The others are all using text based characters or text based with a num, so its an easy datatype
assignment for np. 
"""

#Q3

#was told not to do Q3
#Q4
first_ten_genes_means = np.mean(expression_levels[:10],axis=1)

#print(first_ten_genes_means)
"""
Output: [3.08153704e-03 3.76213244e+00 0.00000000e+00 5.00325926e-03
 0.00000000e+00 2.02259981e-02 3.88654981e-02 4.82672185e-02
 2.59725509e-02 6.00239091e-02]

 
 Yes it matches the output from Q3
"""
print("\n")

#Q5 To get a sense of the spread of data, calculate and compare the median and mean expression value of the entire dataset.
mean_expression_level = np.mean(expression_levels)
median_expression_level = np.median(expression_levels)
# print(f"The mean expression level is across the whole dataset is {mean_expression_level}.")
# print(f"The median expression level across the whole dataset is {median_expression_level}.")

"""
Output: 

The mean expression level is across the whole dataset is 16.557814350910945.
The median expression level across the whole dataset is 0.0271075.
"""
print("\n")
#Q6  In order to work with a more normalized range of expression values, let’s apply a log-transformation to the data and check the mean and median values again.
log_transformation = np.log2(expression_levels + 1)
mean_log_expression_level = np.mean(log_transformation)
median_log_expression_level = np.median(log_transformation)
print(f"The mean log expression level is across the whole dataset is {mean_log_expression_level}.")
print(f"The median log expression level across the whole dataset is {median_log_expression_level}.")

"""
    Now how do the median and mean transformed expression values compare to each other? To the non-transformed values?
    They are alot closer as they are transformed via log.  Median expression levels are also very close although there was
    a drastic shift in mean expression level 
"""

#Q7Now let’s find the expression gap for each gene between their highest and next highest expression level to identify highly tissue specific genes.

sort_expression = np.sort(log_transformation,axis=1)
diff_array = sort_expression[:,-1] - sort_expression[:,-2]

#boolean masking to find genes with a expression > 10


bool_conditions = diff_array > 10
greater_than_10_expression = gene_name[bool_conditions]


print(f"The number of genes is {len(greater_than_10_expression)}")


# The number of genes is 33
