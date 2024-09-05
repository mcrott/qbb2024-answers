library("tidyverse")


#Q1-3
df <- read_tsv( "~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt" )
df <- df %>%
  mutate( SUBJECT= str_extract( SAMPID, "[^-]+-[^-]+" ), .before=1 )





#Q4
df_n_subjects <- df %>%
  
  #group_by(), summarize(), and arrange()

  group_by( SUBJECT ) %>%   #980 subjects
  summarize( n()) %>%
  arrange(desc(`n()`), .by_group = TRUE)

'''
The number of subjects is 980. With K-562 appearing 217 times nad GTEX-NPJ8
apppearing 72 times. 	

GTEX-1JMI6 and GTEX-1PAR6 have the least number at 1. 
'''

#Q5
df_SMTSD <- df %>%
  group_by(SMTSD) %>%
  summarize( n() ) %>%
  arrange(desc(`n()`), .by_group = TRUE)

#Whole blood and muscle skeletal have the most samples.  This is probably because blood and skeletal
# tissue are the most abundant in the body
#Kidney and Fallopian tube tissue are the least, as kidneys are pretty small and you exclude
# a large mount of the population when selecting for just fallopian tube. The sample 
#could have been predominantely male. 


#Q6

#GTEX-NPJ8

df_npj8 <- df %>%
  filter(SUBJECT == 'GTEX-NPJ8')%>%
  filter(SMTSD == 'Whole Blood') 
#6A
"""
Some are by DNA isolation and some are by RNA isolation. Along with different assays used
"""
#6B
#it appears that whole blood connective tissue has the most samples, ie it is the only sample tissue
# for GTEX-NPJ8. See #6A for answer regarding difference between samples




#SMATSSCCR

#Q7
df_smatssccr <- df %>%
  filter( !is.na(SMATSSCR)) %>%
  group_by( SUBJECT )%>%
  summarize(mean(SMATSSCR))

"""

15  have a mean score of 0

The distribution appears to be skewed to the left

I would use a density plot or violin plot using ggplot. 



"""



