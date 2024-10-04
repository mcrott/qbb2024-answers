import pandas as pd
f = open('/Users/cmdb/qbb2024-answers/Week 3/biallelic.vcf')
count =0
for line in f:
    if line.startswith("##") == True:
        count+=1
df = pd.read_csv('/Users/cmdb/qbb2024-answers/Week 3/biallelic.vcf', sep="\t", skiprows=range(0,count))
output = open('Allele_Frequencies.txt','w')
output.write("Allele Frequency\n")
dr = open('depth_reads.txt','w')
dr.write("Depth Reads\n")
for i in range(0,len(df['INFO'])):
    for j in range(0,len(df.iloc[i][9:])):
                dr.write(df.iloc[i][9:][j].split(":")[2] + "\n")
    output.write(df['INFO'][i].split(';')[3].split("=")[1] + "\n")
output.close()
f.close()
dr.close()
