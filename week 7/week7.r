library(DESeq2)
library(broom)
library(tidyverse)
 
locs <- read_delim("/Users/cmdb/qbb2024-answers/week 7/gene_locations.txt")
metadata <- read_delim("/Users/cmdb/qbb2024-answers/week 7/gtex_metadata_downsample.txt")
blood <- read_delim("/Users/cmdb/qbb2024-answers/week 7/gtex_whole_blood_counts_downsample.txt")

blood <- column_to_rownames(blood, var = "GENE_NAME")
metadata <- column_to_rownames(metadata, var = "SUBJECT_ID")

data <- DESeqDataSetFromMatrix(countData = blood,
                               colData = metadata,
                               design = ~ SEX + DTHHRDY + AGE)
#plotPCA(broadLogdata,intgroup=c("rep","tissue"), returnData=TRUE)

vsd <- vst(data)

plotPCA(vsd,intgroup="AGE") +
  geom_point(size=3) +
  labs(title = "PCA Analysis of Expression by Age") +
  scale_color_continuous(labels = c('20-29',"30-39","40-49","50-59","60-69","70-79"))
plotPCA(vsd,intgroup="SEX") +
  geom_point(size=3) +
  labs(title = "PCA Analysis of Expression by Sex") +
  scale_color_discrete(labels = c("Female","Male"))
plotPCA(vsd,intgroup="DTHHRDY") +
  geom_point(size=3) +
  labs(title = "PCA Analysis of Expression by Cause of Death") +
  scale_color_discrete(labels = c("Natural", "On Ventilator"))

## 1.1.3
#cause of death explains most of the variance at 48% as its clustered together in the bottom
#right corner of the graph. Age seems to be slightly grouped together as well where younger patients
# are also in the right hand corner

vsd_df <- assay(vsd) %>%
  t() %>%
  as_tibble()

vsd_df <- bind_cols(metadata, vsd_df)

#2.1.1
m1 <- lm(formula = WASH7P ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
# no, there does not appaer to show any significant evidence of a sex determined basis
# for cause of death, pvalue is 0.279


#2.1.2
m2 <- lm(formula = SLC25A47 ~ DTHHRDY + AGE + SEX, data = vsd_df) %>%
  summary() %>%
  tidy()
#yes here it appears that there is some significance with sLC25A47 as its pval is 0.0257

data <- DESeq(data)

sexRES <- results(data, name = "SEX_male_vs_female") %>%
  as_tibble(rownames = "GENE_NAME")

sexRES <- sexRES %>%
  filter(!is.na(padj))

sexRES <- sexRES %>%
  filter(padj < 0.1)


#2.3.2
# 262 genes


by_locs = left_join(locs,resSEX,by="GENE_NAME") %>% arrange(padj)
#seems like sex chromosomes are our top hits. This makes sense as we are looking at differential expression between genes
# Male genes appear to be more greatly expressed and at the top of the list. 
wash7de = by_locs %>% filter(GENE_NAME == "WASH7")
slc = by_locs %>% filter(GENE_NAME == "SLC25A47") 
#this tracks as wash7de wasn't found to be significant.  SLC was, so we have a hit

deathRES <- results(data, name = 'DTHHRDY_ventilator_case_vs_fast_death_of_natural_causes') %>%
  as_tibble(rownames = "GENE_NAME")


deathRES <- deathRES %>%
  filter(!is.na(padj))

deathRES <- deathRES %>%
  filter(padj < 0.1)

#2.4.1
#16069 genes

#2.4.2
# I would take this as expected. With the large variance at 48% and the grouping from the PCA analysis,
# it feels appropriate to look at our differentially expressed genes as the foci point for our interest in cause of death
ggplot(data=sexRES, aes(x=log2FoldChange, y = -log10(padj))) +
  geom_point(aes(color=(abs(log2FoldChange) > 1 & -log10(padj) >1))) +
  geom_text(data = sexRES %>% filter(abs(log2FoldChange) > 2 & -log10(padj) > 10),
            aes(x = log2FoldChange, y = -log10(padj) + 5, label = GENE_NAME), size = 2) +
  labs(title="Differential Expression by Sex") +
  labs(y= "-log10(padj)", x = "log2(Fold Change)") +
  theme(legend.position = 'none')
  

