library(ggplot2)
library(zellkonverter)
library(scuttle)
library(scater)
library(scran)

set.seed(42)


# Download the Gut “10x, RAW, H5AD” data using a web browser (should be 612 MB)
# Create a g object named gut by loading v2_fca_biohub_gut_10x_raw.h5ad using readH5AD() from zellkonverter
gut <- readH5AD("v2_fca_biohub_gut_10x_raw.h5ad")

#Change the assay name from X to counts using assayNames(gut) <- "counts"
assayNames(gut) <- 'counts'
# Normalize counts using gut <- logNormCounts(gut)
gut <- logNormCounts(gut)

# Question 1: Inspect the gut SingleCellExperiment object (0.5 pt)
# How many genes are quantitated (should be >10,000)?
     #13407 genes
#   How many cells are in the dataset?
    #11788
#   What dimension reduction datasets are present?
    #reducedDimNames(gut)
    #"X_pca"  "X_tsne" "X_umap"
#   Inspect cell metadata (0.5 pt)

# Question 2: Inspect the available cell metadata (0.5 pt)
# How many columns are there in colData(gut)?
    #39 total 
#   Which three column names reported by colnames() seem most interesting? Briefly explain why.

    #broad annotation seems interesting as it gives the cell type, can be good to look at genes by cell type
    #percent_mito -> this is an important metric for filtering out low quality reads, this would be important to filter out bad reads
    #log_n_genes -> can look at how many genes were identified and can be paired with percent mito to identify slow quality reads

# Plot cells according to X_umap using plotReducedDim() and colouring by broad_annotation
plotReducedDim(gut,dimred = "X_umap",color_by= "broad_annotation") +
  labs(title="Umap of Broad Annotation in Gut scRNA-seq",color="Cell Type")
# 
# 2. Explore data
# Explore gene-level statistics (1 pt)
# Sum the expression of each gene across all cells
# Create a vector named genecounts by using rowSums() on the counts matrix returned by assay(gut)
genecounts <- rowSums(assay(gut))
# Question 3: Explore the genecounts distribution (1 pt)
# 
# What is the mean and median genecount according to summary()? What might you conclude from these numbers?
    #mean(genecounts) -> [1] 3184.687
    #median(genecounts) -> [1] 254
# I can conclude that the average gene count is around 3184 reads however the median is 254 reads. This indicates that there there is a heavy skew of gene counts 

#   What are the three genes with the highest expression after using sort()? What do they share in common?
genecounts <- sort(genecounts,decreasing =TRUE)
#lncRNA:Hsromega at 601414
#pre-rRNA:CR45845 at 470729
#lncRNA:roX1  at 291965
# they are all RNA! #1 and #3 are lncRNA and are most likely involved in a regulatory role within the gut

#   Explore cell-level statistics (1 pt)
# Question 4a: Explore the total expression in each cell across all genes (0.5 pt)
# Create a vector named cellcounts using colSums(
cellcounts <- colSums(assay(gut))
# Create a histogram of cellcounts using hist()
hist(cellcounts)
# What is the mean number of counts per cell?
    #mean(cellcounts) -> [1] 3622.082
#   How would you interpret the cells with much higher total counts (>10,000)?
    #They are highly abundant cells, most likely part of the epithelial layer within the gut
#   Question 4b: Explore the number of genes detected in each cell (0.5 pt)
# Create a vector named celldetected using colSums() but this time on assay(gut)>0
celldetected <- colSums(assay(gut)>0)
# Create a histogram of celldetected using hist()
hist(celldetected)
# What is the mean number of genes detected per cell?
    #mean(celldetected) ->[1] 1059.392
#   What fraction of the total number of genes does this represent?
    #1059.392/13407 ->  7.901783%
#   Explore mitochondrial reads (1 pt)
# Sum the expression of all mitochondrial genes across each cell
# 
# Create a vector named mito of mitochondrial gene names using grep() to search rownames(gut) for the pattern ^mt: and setting value to TRUE
mito <- grep("^mt:",rownames(gut),value=TRUE)
# Create a DataFrame named df using perCellQCMetrics() specifying that subsets=list(Mito=mito)
df <- perCellQCMetrics(gut, subsets=list(Mito=mito))
# Confirm that the mean sum and detected match your previous calculations by converting df to a data.frame using as.data.frame() and then running summary()
df <- as.data.frame(df)
summary(df)
# Add metrics to cell metadata using colnames(colData(gut)) <- cbind( colData(gut), df )
colData(gut) <- cbind(colData(gut), df )
# Question 5: Visualize percent of reads from mitochondria (1 pt)
plotColData(gut,x="broad_annotation",y="subsets_Mito_percent") +
  theme( axis.text.x=element_text( angle=90 ) ) +
  labs(x="Cell Type",y="% of Mitochondrial Gene Expression",title='Percentage of Mitochondrial Gene Expresion by Cell Type')
# Plot the subsets_Mito_percent on the y-axis against the broad_annotation on the x-axis rotating the x-axis labels using theme( axis.text.x=element_text( angle=90 ) ) and submit this plot

# Which cell types may have a higher percentage of mitochondrial reads? Why might this be the case?
#it looks like the enteroendocrine cell has a higher percentage. Id assume that
# its because those cells are associated with hormone production, that perhaps energy needs
# are greatly increased in these cells so more atp production is needed



# 3. Identify marker genes
# Analyze epithelial cells (3 pt)
# Question 6a: Subset cells annotated as “epithelial cell” (1 pt)
# Create an vector named coi that indicates cells of interest where TRUE and FALSE are determined by colData(gut)$broad_annotation == "epithelial cell"
coi <- colData(gut)$broad_annotation == "epithelial cell"
# Create a new SingleCellExperiment object named epi by subsetting gut with [,coi]
epi <- (gut[,coi])
# Plot epi according to X_umap and colour by annotation and submit this plot
plotReducedDim(epi,dimred = "X_umap", color_by = "broad_annotation") +
  labs(title="Umap of epithilial Cells",color="Cell Type")
# Identify marker genes in the anterior midgut
# 
# Create a list named marker.info that contains the pairwise comparisons between all annotation categories using scoreMarkers( epi, colData(epi)$annotation 
marker.info <- scoreMarkers( epi, colData(epi)$annotation)
# Identify the top marker genes in the anterior midgut according to mean.AUC using the following code

chosen <- marker.info[["enterocyte of anterior adult midgut epithelium"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])
# Question 6b: Evaluate top marker genes (2 pt)
# 
# What are the six top marker genes in the anterior midgut? Based on their functions at flybase.org, what macromolecule does this region of the gut appear to specialize in metabolizing?
sort(head(ordered[,1:4]),decreasing = TRUE)
# Men-b, betaTry,Mal-A1, Nhe2, Mal-A6, vnd
#   Plot the expression of the top marker gene across cell types using plotExpression() and specifying the gene name as the feature and annotation as the x-axis and submit this plot
library(scales)
plotExpression(epi,features = 'Men-b',x="annotation") +
  scale_x_discrete(labels = wrap_format(15)) +
  labs(x="Epithial Cells",y="Expression",title="Expression of Epithilial Cells")

# Analyze somatic precursor cells (3 pt)
# Repeat the analysis for somatic precursor cells
# Subset cells with the broad annotation somatic precursor cell
# Identify marker genes for intestinal stem cell

som <- colData(gut)$broad_annotation == "somatic precursor cell"
somatic <- gut[,som]
plotReducedDim(somatic,dimred='X_umap',color_by = "broad_annotation")

# Question 7: Evaluate top marker genes (3 pt)
# 
# Create a vector goi that contains the names of the top six genes of interest by rownames(ordered)[1:6]
# Plot the expression of the top six marker genes across cell types using plotExpression() and specifying the goi vector as the features and submit this plot
# Which two cell types have more similar expression based on these markers?
  #enteroblast and intestinal stem cell have the most similar expression
#   Which marker looks most specific for intestinal stem cells?
  # DI looks to be the most specific for intestinal stem cells
# 
marker.info <- scoreMarkers( somatic, colData(somatic)$annotation)
chosen <- marker.info[["intestinal stem cell"]]
ordered <- chosen[order(chosen$mean.AUC, decreasing=TRUE),]
head(ordered[,1:4])
sort(head(ordered[,1:4]),decreasing = TRUE)

goi = rownames(ordered)[1:6]

#top six marker genes in somatic precursor cells
#Tet, hdc, kek5, zfh2, N, dl

plotExpression(somatic, features=goi,x='annotation') +
  scale_x_discrete(labels = wrap_format(15)) +
  labs(x='Somatic Cell Type',title='Expression Fold Change of Somatic Precursor Cells')



