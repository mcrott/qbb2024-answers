library(tidyverse)

data <- read.delim(file = "~/qbb2024-answers/Week 2/snp_counts.txt")

data <- data %>% mutate(log = log2(Enrichment))

ggplot() +
  geom_line(data= data %>% filter(Feature == 'exons'),mapping=aes(x=MAF,y=log,color="Exons")) +
  geom_line(data= data %>% filter(Feature == 'introns'),mapping=aes(x=MAF,y=log,color='Introns'))+
  geom_line(data= data %>% filter(Feature == 'cres'),mapping=aes(x=MAF,y=log,color="cCREs")) +
  geom_line(data= data %>% filter(Feature == 'other'),mapping=aes(x=MAF,y=log,color='Other')) +
  labs(color="Legend",x="Minor Allele Frequency",y="Log2 of SNP Enrichment",title="SNP Enrichment vs. Minor Allele Frequency") 