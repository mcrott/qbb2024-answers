import sys
import numpy as np
import pandas as pd


path1 = sys.argv[1]
path2 = sys.argv[3]
path3 = sys.argv[2]

#Q1
df1 = pd.read_csv(path1, sep= "\t",header=None)
df1.set_index(0, inplace=True)
rel_samp = df1.to_dict()[2]
#Q2
df2 = pd.read_csv(path3, sep="\t")
tissue_samples = {}
for i in df2["SMTSD"].unique():
    bool_mask_by_SMTSD = df2['SMTSD'] == i
    tissue_samples[i] = list(df2['SAMPID'][bool_mask_by_SMTSD])

#Q3-5
df3 = pd.read_csv(path2, sep='\t',skiprows = [0,1])
tissue_columns = {}
for tissue, samples in tissue_samples.items():
    indexes = df3.columns.get_indexer(samples)
    bool_mask = indexes != -1
    tissue_columns[tissue] = indexes[indexes != -1]


# for tissue,samples in tissue_columns.items():
#     print(f"{tissue} has a total of {len(samples)} hits")

"""
Skeletal muscles have the highest total number of hits at 803, while Cell- Leukemia Cell Line has the least number with 0
Muscle - Skeletal has a total of 803 hits
Cells - Leukemia cell line (CML) has a total of 0 hits
"""

#Q6

output_dataframe = pd.DataFrame(columns = ["Gene ID",'Tissue Type', 'Expression Values'])
expression_dict = {}

for key,value in rel_samp.items():
    if key in df3["Name"].values:
        df3_row_index = df3[df3['Name'] == key].index[0]
        expression_vals = list(df3.iloc[df3_row_index][tissue_columns[value]])
        row_to_add = {'Gene ID':key, "Tissue Type": value, "Expression Values": expression_vals}
        #establishes gene ID as a key with columns as a value
        output_dataframe = pd.concat([output_dataframe, pd.DataFrame(row_to_add)], ignore_index = True)
        # need to pull the expression values from dataframe3
#Q7
output_dataframe.to_csv('output_file.tsv', sep= "\t", index= False)
