library("tidyverse")
df <- read_tsv( "~/Data/GTEx/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt" )


df <- df %>%
  mutate( SUBJECT= str_extract( SAMPID, "[^-]+-[^-]+" ), .before=1 )

df_n_subjects <- df %>%
  
  #group_by(), summarize(), and arrange()

  group_by( SUBJECT ) %>%   #980 subjects
  summarize( n()) %>%
  arrange(desc(`n()`), .by_group = TRUE)


'''
The number of subjects is 980. With K-562 appearing 217 times. 
'''


df_SMTSD <- df %>%
  group_by(SMTSD) %>%
  summarize( n() ) %>%
  arrange(desc(`n()`), .by_group = TRUE)




"""
There are 55 different types of SMTSDs, with whole blood appearing the most at 3288. 
"""
#GTEX-NPJ8

df_npj8 <- df %>%
  filter(SUBJECT == 'GTEX-NPJ8')%>%
  filter(SMTSD == 'Whole Blood') 




"""
Some are by DNA isolation and some are by RNA isolatio. Along with different assays used
"""



#SMATSSCCR


df_smatssccr <- df %>%
  group_by(SMATSSCR) %>%
  filter( !is.na(SMATSSCR) )%>%
  summarize(n())

"""

3554 have a score of 0

The distribution favors heavily with a score of 1

Histogram


"""



