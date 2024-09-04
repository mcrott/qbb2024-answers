### Answer 0.5
- `wc -l hg38-gene-metadata-feature.tsv`
- There are 61633 lines

### Answer 1
- ``` 19618 protein_coding```

- ```cut -f  7 hg38-gene-metadata-feature.tsv | sort | uniq -c```

- there are 19618 protein coding genes

- I would like to know more about snoRNAs. Chemical modifications of RNA is an interesting field and is implicated in stability as well as processing. 

- ```There are  931 snoRNA ```


### Answer 2
```grep "ENSG00000168036" hg38-gene-metadata-go.tsv | sort -k3 > ENSG00000168036.txt ```

```ls -l```
> `total 2009568`

```
{
    -rw-r--r--  1 cmdb  staff      16370 Sep  4 11:33 ENSG00000168036.txt`
    -rw-r--r--  1 cmdb  staff  990755061 Sep  4 09:57 gencode.v46.basic.annotation.gtf
    -rw-r--r--  1 cmdb  staff   11579651 Sep  4 11:03 genes.gtf
    -rwxr-xr-x  1 cmdb  staff    7027940 Sep  4 10:13 hg38-gene-metadata-feature.tsv
    -rwxr-xr-x  1 cmdb  staff   16103185 Sep  4 10:13 hg38-gene-metadata-go.tsv
    -rwxr-xr-x  1 cmdb  staff    2359091 Sep  4 10:13 hg38-gene-metadata-homologs.tsv
    -rw-r--r--  1 cmdb  staff        131 Sep  4 10:20 lengths.txt
    -rw-r--r--  1 cmdb  staff        137 Sep  4 10:29 sorted-lengths.txt
    (base) cmdb@QuantBio -23 d2-morning % wc ENSG00000168036.txt
     273    1546   16370 ENSG00000168036.txt
    (base) cmdb@QuantBio -23 d2-morning %
}
```

- ENSG00000168036 has the most hits at 273.  It appears that this gene is associated with the cytoskeleton/differentiation. 


### Answer 3

-  `grep IG_._gene genes.gtf | wc `
   output:    214    4300   39340

-  `grep "IG\_.*\_pseudogene" genes.gtf | wc`
    output: 199    4048   38565

- Grep pseudogene would not work because there are multiple types of pseudogene. Grep would take any ****_pseudogene available and output it. It simply isn't a narrow enough search when dealig with IG 


``` 
cut -f1 gene-tab.txt | > gene-chromo.txt
cut -f4 gene-tab.txt | > gene-start.txt
cut -f5 gene-tab.txt | > gene-stop.txt
cut -f14 gene-tab.txt | > gene-name.txt
paste -d" " gene-chromo.txt gene-start.txt gene-stop.txt gene-name.txt > gene-final.bed
```
