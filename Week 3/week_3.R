library(tidyverse)

df <- read_csv(file = "~/qbb2024-answers/Week 3/Allele_Frequencies.txt")
dr <- read_csv((file="~/qbb2024-answers/Week 3/depth_reads.txt"))



ggplot(data=df) + 
  geom_histogram(bins=11,mapping=aes(`Allele Frequency`))

ggplot(data=dr) +
  geom_histogram(bins=21,mapping=aes(`Depth Reads`))+
  xlim(0,20)
