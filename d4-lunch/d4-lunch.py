#!/usr/bin/env python3

import sys

import numpy

# get gene-tissue file name
filename = sys.argv[1]
# open file
fs = open(filename, mode='r')
# create dict to hold samples for gene-tissue pairs
relevant_samples = {}
# step through file
for line in fs:
    # Split line into fields
    fields = line.rstrip("\n").split("\t")
    # Create key from gene and tissue
    key = (fields[0], fields[2])
    # Initialize dict from key with list to hold samples
    relevant_samples[key] = []
fs.close()


# get metadata file name
filename = sys.argv[2]
# open file
fs = open(filename, mode='r')
# Skip line
fs.readline()
# create dict to hold samples for tissue name
tissue_samples = {}
# step through file
for line in fs:
    # Split line into fields
    fields = line.rstrip("\n").split("\t")
    # Create key from gene and tissue
    key = fields[6]
    value = fields[0]
    # Initialize dict from key with list to hold samples
    tissue_samples.setdefault(key, [])
    tissue_samples[key].append(value)
fs.close()





# get metadata file name
filename = sys.argv[3]
# open file
fs = open(filename, mode='r')
# Skip line(s)
fs.readline()
fs.readline()
#reading in the headers of the input file
header = fs.readline().rstrip("\n").split("\t")
#skipping Name and Description, only want the GTEX ids
header = header[2:]
#establishing dictionary to store header locations
tissue_columns = {}
#iterating through tissue, samples as a key:value pair 
for tissue, samples in tissue_samples.items():
    #creating the dictionary. .setdefault returns the value of a key unless it hasn't been made, then it will be created then returns the created value
    tissue_columns.setdefault(tissue, [])
    #as samples is a list, we are iterating through it with another for loop
    for sample in samples:
        #if sample is within our header, the iteration will be brought into the if statement
        if sample in header:
            #position is storing the index of the header within sample as a numerical value. ie 0 for the first index 
            position = header.index(sample)
            #using the current loop of tissue to access the tissue_columns dictionary with tissue as the key. The value was set to a list with .setdefault in line 64, so here we are appending 
            #the index location stored within position. This is where we will eventually access the expression levels with nested for loops. 
            tissue_columns[tissue].append(position)

#simply iterating through tissue_columns, counting the number of header locations within and printing it out via an f-string. 
for tissue,samples in tissue_columns.items():
    print(f"{tissue} has a total of {len(samples)} hits")


"""

Leukimia cell line has the fewest hits at 0. While Muscle-Skeletal has the most at 803. 





Whole Blood has a total of 755 hits
Brain - Frontal Cortex (BA9) has a total of 209 hits
Adipose - Subcutaneous has a total of 663 hits
Muscle - Skeletal has a total of 803 hits
Artery - Tibial has a total of 663 hits
Artery - Coronary has a total of 240 hits
Heart - Atrial Appendage has a total of 429 hits
Adipose - Visceral (Omentum) has a total of 541 hits
Ovary has a total of 180 hits
Uterus has a total of 142 hits
Vagina has a total of 156 hits
Breast - Mammary Tissue has a total of 459 hits
Skin - Not Sun Exposed (Suprapubic) has a total of 604 hits
Minor Salivary Gland has a total of 162 hits
Brain - Cortex has a total of 255 hits
Adrenal Gland has a total of 258 hits
Thyroid has a total of 653 hits
Lung has a total of 578 hits
Spleen has a total of 241 hits
Pancreas has a total of 328 hits
Esophagus - Muscularis has a total of 515 hits
Esophagus - Mucosa has a total of 555 hits
Esophagus - Gastroesophageal Junction has a total of 375 hits
Stomach has a total of 359 hits
Colon - Sigmoid has a total of 373 hits
Small Intestine - Terminal Ileum has a total of 187 hits
Colon - Transverse has a total of 406 hits
Prostate has a total of 245 hits
Testis has a total of 361 hits
Skin - Sun Exposed (Lower leg) has a total of 701 hits
Nerve - Tibial has a total of 619 hits
Heart - Left Ventricle has a total of 432 hits
Pituitary has a total of 283 hits
Brain - Cerebellum has a total of 241 hits
Cells - Cultured fibroblasts has a total of 504 hits
Artery - Aorta has a total of 432 hits
Cells - EBV-transformed lymphocytes has a total of 174 hits
Brain - Cerebellar Hemisphere has a total of 215 hits
Brain - Caudate (basal ganglia) has a total of 246 hits
Brain - Nucleus accumbens (basal ganglia) has a total of 246 hits
Brain - Putamen (basal ganglia) has a total of 205 hits
Brain - Hypothalamus has a total of 202 hits
Brain - Spinal cord (cervical c-1) has a total of 159 hits
Liver has a total of 226 hits
Brain - Hippocampus has a total of 197 hits
Brain - Anterior cingulate cortex (BA24) has a total of 176 hits
Brain - Substantia nigra has a total of 139 hits
Kidney - Cortex has a total of 85 hits
Brain - Amygdala has a total of 152 hits
Cervix - Ectocervix has a total of 9 hits
Fallopian Tube has a total of 9 hits
Cervix - Endocervix has a total of 10 hits
Bladder has a total of 21 hits
Kidney - Medulla has a total of 4 hits
Cells - Leukemia cell line (CML) has a total of 0 hits

"""
