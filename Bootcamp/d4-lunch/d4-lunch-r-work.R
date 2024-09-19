library(tidyverse)
library(dplyr)

data1 <- read.delim("C:/Users/test/School/Quant Bio/qbb2024-answers/d4-lunch/output_file.tsv")
data1 <-data1 %>% mutate(Tissue_Gene=paste0(Tissue.Type, " ", Gene.ID))
data1 <- data1 %>% mutate(Expression_Log2 = log2(Expression.Values + 1))

ggplot(data=data1) +
      geom_violin(mapping = aes(x=Gene.ID, y =Expression_Log2)) +
  coord_flip()
