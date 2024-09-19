library(tidyverse)
  samp_starts <- readr::read_tsv("Quant Bio Lab/sample_coverage.tsv")
    samp_starts10x <- readr::read_tsv("Quant Bio Lab/sample_cov_10x.tsv")
  samp_starts30x <- readr::read_tsv("Quant Bio Lab/sample_cov_30x.tsv")






myls <- seq(nrow(samp_starts))
myls10x <- seq(nrow(samp_starts10x))
myls30x <- seq(nrow(samp_starts30x))


data_normal <- dnorm(myls, mean=3, sd=sqrt(3))*1000000
data_normal_10x <- dnorm(myls10x, mean=10, sd=sqrt(10))*1000000
data_normal_30x <- dnorm(myls30x, mean=30, sd=sqrt(30))*1000000
samp_starts$gaussian <- data_normal
samp_starts10x$gaussian <- data_normal_10x
samp_starts30x$gaussian <- data_normal_30x


ggplot(data = samp_starts) +
  geom_smooth(mapping = aes(x = cnts, y = coverage, color = "Genome Coverage")) +
  geom_smooth(mapping = aes(x = cnts, y = pmf, color = "Probability Mass Function")) +
  geom_smooth(mapping = aes(x = cnts, y = pdf, color = "Probability Density Function")) +
  geom_smooth(mapping = aes(x= cnts, y = gaussian, color = "Gaussian Distribution"))+
  scale_color_manual(name = "Legend", values = c("Genome Coverage" = "blue", "Probability Mass Function" = "red", "Probability Density Function" = "green","Gaussian Distribution" = 'orange')) +
  labs(x='N Hits',y='Total Hits') +
  ggtitle("Genome 3x Coverage Statistics")

ggplot(data = samp_starts10x) +
  geom_smooth(mapping = aes(x = cnts, y = coverage, color = "Genome Coverage")) +
  geom_smooth(mapping = aes(x = cnts, y = pmf, color = "Probability Mass Function")) +
  geom_smooth(mapping = aes(x = cnts, y = pdf, color = "Probability Density Function")) +
  geom_smooth(mapping = aes(x= cnts, y = gaussian, color = "Gaussian Distribution"))+
  scale_color_manual(name = "Legend", values = c("Genome Coverage" = "blue", "Probability Mass Function" = "red", "Probability Density Function" = "green","Gaussian Distribution" = 'orange')) +
  labs(x='N Hits',y='Total Hits') +
  ggtitle("Genome 10x Coverage Statistics")

ggplot(data = samp_starts30x) +
  geom_smooth(mapping = aes(x = cnts, y = coverage, color = "Genome Coverage")) +
  geom_smooth(mapping = aes(x = cnts, y = pmf, color = "Probability Mass Function")) +
  geom_smooth(mapping = aes(x = cnts, y = pdf, color = "Probability Density Function")) +
  geom_smooth(mapping = aes(x= cnts, y = gaussian, color = "Gaussian Distribution"))+
  scale_color_manual(name = "Legend", values = c("Genome Coverage" = "blue", "Probability Mass Function" = "red", "Probability Density Function" = "green","Gaussian Distribution" = 'orange')) +
  labs(x='N Hits',y='Total Hits') +
  ggtitle("Genome 30x Coverage Statistics")