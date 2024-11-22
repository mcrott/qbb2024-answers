import numpy as np
import imageio
from pathlib import Path
import pandas as pd

df = pd.DataFrame(columns=['Gene', 'nascentRNA', 'PCNA',"ratio"])

#folder names

def find_labels(mask):
    # Set initial label
    l = 0
    # Create array to hold labels
    labels = np.zeros(mask.shape, np.int32)
    # Create list to keep track of label associations
    equivalence = [0]
    # Check upper-left corner
    if mask[0, 0]:
        l += 1
        equivalence.append(l)
        labels[0, 0] = l
    # For each non-zero column in row 0, check back pixel label
    for y in range(1, mask.shape[1]):
        if mask[0, y]:
            if mask[0, y - 1]:
                # If back pixel has a label, use same label
                labels[0, y] = equivalence[labels[0, y - 1]]
            else:
                # Add new label
                l += 1
                equivalence.append(l)
                labels[0, y] = l
    # For each non-zero row
    for x in range(1, mask.shape[0]):
        # Check left-most column, up  and up-right pixels
        if mask[x, 0]:
            if mask[x - 1, 0]:
                # If up pixel has label, use that label
                labels[x, 0] = equivalence[labels[x - 1, 0]]
            elif mask[x - 1, 1]:
                # If up-right pixel has label, use that label
                labels[x, 0] = equivalence[labels[x - 1, 1]]
            else:
                # Add new label
                l += 1
                equivalence.append(l)
                labels[x, 0] = l
        # For each non-zero column except last in nonzero rows, check up, up-right, up-right, up-left, left pixels
        for y in range(1, mask.shape[1] - 1):
            if mask[x, y]:
                if mask[x - 1, y]:
                    # If up pixel has label, use that label
                    labels[x, y] = equivalence[labels[x - 1, y]]
                elif mask[x - 1, y + 1]:
                    # If not up but up-right pixel has label, need to update equivalence table
                    if mask[x - 1, y - 1]:
                        # If up-left pixel has label, relabel up-right equivalence, up-left equivalence, and self with smallest label
                        labels[x, y] = min(equivalence[labels[x - 1, y - 1]], equivalence[labels[x - 1, y + 1]])
                        equivalence[labels[x - 1, y - 1]] = labels[x, y]
                        equivalence[labels[x - 1, y + 1]] = labels[x, y]
                    elif mask[x, y - 1]:
                        # If left pixel has label, relabel up-right equivalence, left equivalence, and self with smallest label
                        labels[x, y] = min(equivalence[labels[x, y - 1]], equivalence[labels[x - 1, y + 1]])
                        equivalence[labels[x, y - 1]] = labels[x, y]
                        equivalence[labels[x - 1, y + 1]] = labels[x, y]
                    else:
                        # If neither up-left or left pixels are labeled, use up-right equivalence label
                        labels[x, y] = equivalence[labels[x - 1, y + 1]]
                elif mask[x - 1, y - 1]:
                    # If not up, or up-right pixels have labels but up-left does, use that equivalence label
                    labels[x, y] = equivalence[labels[x - 1, y - 1]]
                elif mask[x, y - 1]:
                    # If not up, up-right, or up-left pixels have labels but left does, use that equivalence label
                    labels[x, y] = equivalence[labels[x, y - 1]]
                else:
                    # Otherwise, add new label
                    l += 1
                    equivalence.append(l)
                    labels[x, y] = l
        # Check last pixel in row
        if mask[x, -1]:
            if mask[x - 1, -1]:
                # if up pixel is labeled use that equivalence label 
                labels[x, -1] = equivalence[labels[x - 1, -1]]
            elif mask[x - 1, -2]:
                # if not up but up-left pixel is labeled use that equivalence label 
                labels[x, -1] = equivalence[labels[x - 1, -2]]
            elif mask[x, -2]:
                # if not up or up-left but left pixel is labeled use that equivalence label 
                labels[x, -1] = equivalence[labels[x, -2]]
            else:
                # Otherwise, add new label
                l += 1
                equivalence.append(l)
                labels[x, -1] = l
    equivalence = np.array(equivalence)
    # Go backwards through all labels
    for i in range(1, len(equivalence))[::-1]:
        # Convert labels to the lowest value in the set associated with a single object
        labels[np.where(labels == i)] = equivalence[i]
    # Get set of unique labels
    ulabels = np.unique(labels)
    for i, j in enumerate(ulabels):
        # Relabel so labels span 1 to # of labels
        labels[np.where(labels == j)] = i
    return labels
def filter_by_size(labels, minsize, maxsize):
    # Find label sizes
    sizes = np.bincount(labels.ravel())
    # Iterate through labels, skipping background
    for i in range(1, sizes.shape[0]):
        # If the number of pixels falls outsize the cutoff range, relabel as background
        if sizes[i] < minsize or sizes[i] > maxsize:
            # Find all pixels for label
            where = np.where(labels == i)
            labels[where] = 0
    # Get set of unique labels
    ulabels = np.unique(labels)
    for i, j in enumerate(ulabels):
        # Relabel so labels span 1 to # of labels
        labels[np.where(labels == j)] = i
    return labels
folder_path = Path("/Users/cmdb/qbb2024-answers/Week 10/images")
images_dict = {}
fields = "_DAPI","_nascentRNA","_PCNA"
def load_img(image):
    img = imageio.v3.imread(image).astype(np.uint16)
    return img
def dapi_mask(dapi):
    mask_mean = np.average(dapi)
    mask_true = dapi >= mask_mean
    label_array = find_labels(mask_true)
    copy_label = np.copy(label_array)
    copy_array = filter_by_size(copy_label,100,1000000)
    sizes = np.bincount(copy_array[copy_array > 0].ravel())
    size_mean = np.mean(sizes)
    size_std = np.std(sizes)
    final_array = filter_by_size(copy_array,size_mean - size_std, size_mean + size_std)
    #this is the array of labels
    return final_array
def image_analysis(dapi_mask,final_array):
    num_nuclei = np.amax(dapi_mask) + 1
    output_array = []
    for i in range(1,num_nuclei):
        where = np.where(dapi_mask==i)
        output_array.append(np.average(final_array[where]))
    return np.array(output_array)  
#store images in a dict
for i in folder_path.iterdir():
    if i.name == ".DS_Store":
        continue
    for j in i.iterdir():
        if "field1" in j.name:
            title = f"{i.name}_field1"
            if "_c" in j.name:
                continue
            if title in images_dict.keys():
                images_dict[title].append(load_img(j))
            else:
                images_dict[title] = []
                images_dict[title].append(load_img(j))
        if "field0" in j.name:
            title = f"{i.name}_field0"
            if "_c" in j.name:
                continue
            if title in images_dict.keys():
                images_dict[title].append(load_img(j))
            else:
                images_dict[title] = []
                images_dict[title].append(load_img(j))
#image_dict = dapi-rna-pcna
for i in images_dict.keys():
    data_dict = {}
    gene = []
    dapi_pointer = dapi_mask(images_dict[i][0])
    pcna = image_analysis(dapi_pointer,images_dict[i][2])
    nascent = image_analysis(dapi_pointer,images_dict[i][1])
    nascent[~np.isnan(nascent)]/pcna[~np.isnan(pcna)]
    for j in range(0,len(nascent)):
        gene.append(i.split("_")[0])
    data_dict['Gene'] = gene
    data_dict['nascentRNA'] = nascent
    data_dict['PCNA'] = pcna
    data_dict['ratio'] = np.log2(nascent[~np.isnan(nascent)]/pcna[~np.isnan(pcna)])
    new_df = pd.DataFrame(data_dict)
    df = pd.concat([df, new_df], ignore_index=True)

df.to_csv('week10_output.csv', index=False)


