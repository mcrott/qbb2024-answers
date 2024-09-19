library(tidyverse)

df_ds <- read_delim(file = "~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt")

glimpse(df_ds)

# test
# test SMGEBTCHT column contains the value "TruSeq.v1"

df_truseq <- df_ds %>%
  filter(SMGEBTCHT == 'TruSeq.v1')

#plot SMTSD as a barplot 

#Q1-3 is above

#Q4
ggplot(data = df_truseq) +
  geom_bar(mapping = aes(x = SMTSD)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  xlab("Tissue Type") +
  ylab("# of Instances")

#Q5
ggplot(data = df_truseq) +
  geom_density(mapping = aes(x=SMRIN)) +
  xlab("RNA Integrity Number") +
  ylab("Density")
  #theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) #

# Yes, It appears that this data is unimodal. There is a heavy distribution towards the
# right hand side of the graph


#Q6
ggplot(data = df_truseq) +
  geom_density(mapping = aes(x=SMRIN,color=SMTS)) +
  xlab("RNA Integrity Number") +
  ylab("Density")

#it appears that most of the tissue is distributed similarly other than blood vessel tissue
#blood vessel tissue seems to have a higher RNA integrity number


# Q7
ggplot(data = df_truseq) +
  geom_violin(mapping = aes(x=SMTS,y = SMGNSDTC,fill=SMTS)) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  xlab("Tissue Type")+
  ylab("Num Genes")

#Do you notice any differences across tissues? Which tissues are outliers? Look over the abstract of this paper for one hypothesis to explain these observations.

#Yes. It appears that Bone Marrow has a wider distribution that leans to a lower amount of genes found
#while Testis has a tighter distribution of more genes found than other tissue types. 

# SMTSISCH ischemic time


#Q8
ggplot(data = df_truseq, mapping = aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(size =0.5, alpha = 0.5) +
  xlab('RNA Integrity Number') +
  ylab("Ischemic Time (min)") +
  facet_wrap(~SMTS) +
  geom_smooth(method = lm)

#What relationships do you notice? Does the relationship depend on tissue?

#Yes. It appears that it depends on tissue. However it looks like Pituitary tissue trends slightly upwards however
# I would need to take a deeper look into that tissue


#Q9
ggplot(data = df_truseq,mapping = aes(x=SMRIN, y=SMTSISCH)) +
  geom_point(mapping = aes(color = SMATSSCR),size =0.5, alpha = 0.5) +
  xlab('RNA Integrity Number') +
  ylab("Ischemic Time (min)") +
  facet_wrap(~SMTS) +
  geom_smooth(method = lm)

#Im not seeing anything very specific due to resolution of the graph. There does seem to be some like brain
# or so that have a higher autolysis score after longer ischemic times


  
