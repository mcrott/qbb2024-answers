library(tidyverse)

df <- read_csv(file = "~/qbb2024-answers/Week 3/Allele_Frequencies.txt")
dr <- read_csv((file="~/qbb2024-answers/Week 3/depth_reads.txt"))



ggplot(data=df) + 
  geom_histogram(bins=11,mapping=aes(`Allele Frequency`))+
  ylab('N Count') +
  ggtitle("Histogram of Allele Frequencies")


##Question 3.1: Interpret this figure in two or three sentences in your own words. Does it look as expected? Why or why not? Bonus: what is the name of this distribution?

##This is a normal distribution
#Alle
ggplot(data = dr, aes(x = `Depth Reads`)) +
  geom_histogram(bins = 21) +
  xlim(0, 20) +
  xlab("Length of Depth Reads") +
  ylab("N Reads") +
  ggtitle("Histogram of the Length of Depth Reads")

