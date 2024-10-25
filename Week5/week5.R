# install new packages
BiocManager::install("DESeq2")
BiocManager::install("vsn")
install.packages("ggfortify")
install.packages("hexbin")

# Load libraries we'll need
library(DESeq2)
library(vsn)
library(matrixStats)
library(readr)
library(dplyr)
library(tibble)
library(hexbin)
library(ggfortify)

# Load tab-separated salmon file
salmon = readr::read_tsv('~/qbb2024-answers/Week5/salmon.merged.gene_counts.tsv')

salmon = column_to_rownames(salmon,var="gene_name")
salmon = dplyr::select(salmon,-gene_id)
salmon = dplyr::mutate_if(salmon,is.numeric,as.integer)
salmon = salmon[rowSums(salmon) > 100,]

# Pull out wide region samples
wide = salmon %>% select("A1_Rep1":"P2-4_Rep3")

# Create metasalmon tibble with tissues and replicate numbers based on sample names
wide_metasalmon = tibble(tissue=as.factor(c("A1", "A1", "A1","A2-3", "A2-3", "A2-3","Cu", "Cu", "Cu","LFC-Fe", "LFC-Fe", "Fe","LFC-Fe","Fe","Fe",
                                            "P1","P1","P1",
                                            "P2-4","P2-4","P2-4")),
                         replicate=as.factor(c("Replicate1", "Replicate2", "Replicate3","Replicate1", "Replicate2", "Replicate3","Replicate1", "Replicate2", "Replicate3","Replicate1", "Replicate2", "Replicate1",
                                               "Replicate3", "Replicate2", "Replicate3",
                                               "Replicate1", "Replicate2", "Replicate3",
                                               "Replicate1", "Replicate2", "Replicate3")))
# Create a DESeq salmon object
widesalmon = DESeqDataSetFromMatrix(countData=as.matrix(wide), colData=wide_metasalmon, design=~tissue)

vst_salmon = vst((widesalmon))
# Plot variance by average
meanSdPlot(assay(vst_salmon))

# Create PCA salmon
widePcasalmon = plotPCA(vst_salmon,intgroup=c("rep","tissue"), returnData=TRUE)

# Plot PCA salmon
ggplot(widePcasalmon, aes(PC1, PC2, color=tissue, shape=rep)) +
  geom_point(size=5)

# Convert into a matrix
wideVstsalmon = as.matrix(assay(vst_salmon))

# Find replicate means
combo = wideVstsalmon[,seq(1, 9, 3)]
combo = combo + wideVstsalmon[,seq(2, 9, 3)]
combo = combo + wideVstsalmon[,seq(3, 9, 3)]
combo = combo / 3

# Use replicate means to filter low variance genes out
filt = rowSds(combo) > 1
wideVstsalmon = wideVstsalmon[filt,]

# Plot expression values with hierarchical clustering
heatmap(wideVstsalmon, Colv=NA)

# Perform new hierarchical clustering with different clustering method
distance = dist(wideVstsalmon)
Z = hclust(distance, method='ave')

# Plot expression values with new hierarchical clustering
heatmap(wideVstsalmon, Colv=NA, Rowv=as.dendrogram(Z))

# Set seed so this clustering is reproducible
set.seed(42)

# Cluster genes using k-means clustering
k=kmeans(wideVstsalmon, centers=12)$cluster

# Find ordering of samples to put them into their clusters
ordering = order(k)

# Reorder genes
k = k[ordering]

# Plot heatmap of expressions and clusters
heatmap(wideVstsalmon[ordering,],Rowv=NA,Colv=NA,RowSideColors = RColorBrewer::brewer.pal(12,"Paired")[k])

# Save heatmap
png("heatmap.jpg")
heatmap(wideVstsalmon[ordering,],Rowv=NA,Colv=NA,RowSideColors = RColorBrewer::brewer.pal(12,"Paired")[k])
dev.off()

# Pull out gene names from a specific cluster
genes = rownames(wideVstsalmon[k == 9,])

# Same gene names to a text file
write.table(genes, "cluster_genes.txt", sep="\n", quote=FALSE, row.names=FALSE, col.names=FALSE)
