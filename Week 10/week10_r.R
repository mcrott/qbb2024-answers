library(ggplot2)
library(tidyverse)
data = read.csv(file = "week10_output.csv")
ggplot(data,aes(x=Gene,y = nascentRNA))+
  geom_violin() +
  theme_minimal() +
  labs(title = "Nascent RNA Mean Signal by Gene Knockdown",x="Gene",y="Nascent RNA Mean Signal")
ggsave("NascentRNA.png")
ggplot(data,aes(x=Gene,y = PCNA))+
  geom_violin() +
  theme_minimal() +
  labs(title = "PCNA Mean Signal by Gene Knockdown",x="Gene",y="PCNA Mean Signal")
ggsave("PCNA.png")
ggplot(data,aes(x=Gene,y = ratio))+
  geom_violin() +
  theme_minimal() +
  labs(title = "Ratio of Nascent RNA and PCNA\nMean Signal by Gene Knockdown",x="Gene",y="log2( RNA Mea Signal/\nPCNA Mean signal)")
ggsave("Ratio.png")
