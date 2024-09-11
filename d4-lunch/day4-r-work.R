library(tidyverse)
library(broom)

dnm <- read_csv(file= "C:/Users/test/School/Quant Bio/qbb2024-answers/d4-lunch/aau1043_dnm.csv")
ages <-read_csv(file = "C:/Users/test/School/Quant Bio/qbb2024-answers/d4-lunch/aau1043_parental_age.csv")

dnm_summary <- dnm %>%
  group_by(Proband_id) %>%
  summarize(n_paternal_dnm = sum(Phase_combined == 'father', na.rm = TRUE),
            n_material_dnm = sum(Phase_combined == "mother", na.rm = TRUE))



dnm_by_parential_age <- left_join(dnm_summary, ages, by = "Proband_id")


#maternal
ggplot(data = dnm_by_parential_age,
       mapping = aes(x=n_material_dnm, y=Mother_age)) +
  geom_point()
#father
ggplot(data = dnm_by_parential_age,
        mapping = aes(x=n_paternal_dnm, y=Father_age)) +
  geom_point()

# 2.21
# 2.22
lm(data=dnm_by_parential_age,
   formula = n_material_dnm  ~ Mother_age )
#
#Coefficients:
#  (Intercept)   Mother_age  
#2.5040       0.3776 

lm(data=dnm_by_parential_age,
   formula = n_paternal_dnm ~ Father_age )
#Coefficients:
(#Intercept)   Father_age  
#10.326        1.354  

#it appears that there is less of an effect of age on the amount of dnms on the maternal side. This is due to a slope of 0.3776. While the paternal side
  # has a larger amount of dnms with a slope of 1.354.  paternal has a larger relationship in this case when compared to the maternal.  Id suspect based on
  # these relationships that paternal age influences the amount of DNMs at a greater rate than maternal. 
#
# 2.3
  #b_0 + b_1*age
  # age is 50.5, b_1 is 1.354, b_0 = 10.326
# 78.703 <- 10.326 + 1.354*50.5 

#  
  
#2.5
ggplot(dnm_by_parential_age) +
    geom_histogram(mapping=aes(x=n_material_dnm),fill='blue',alpha = 0.65) +
    geom_histogram(mapping=aes(x=n_paternal_dnm), fill ='green' ,alpha =0.65)

  
  #Step 2.6
  # Now that you’ve visualized this relationship, you want to test whether there is a significant difference between
  # the number of maternally vs. paternally inherited DNMs per proband. 
  # 
  # What would be an appropriate statistical model to test this relationship? Fit this model to the data.
  # I will be using a paired sample t-test. Each output is coming from an individual and not a group, so we will be able to observe
  # the difference between the father and mother pairs
  
lm(data=dnm_summary, formula = n_paternal_dnm ~ n_material_dnm)

# Coefficients:
#   (Intercept)  n_material_dnm  
# 39.134           1.008  

t.test(dnm_summary$n_paternal_dnm, dnm_summary$n_material_dnm, paired = TRUE)

# t = 61.609, df = 395, p-value < 2.2e-16
# alternative hypothesis: true mean difference is not equal to 0
# 95 percent confidence interval:
#   37.98284 40.48685
# sample estimates:
#   mean difference 
# 39.23485 
  
  # After performing your test, answer the following questions:
  #   
  # What statistical test did you choose? Why?
  # Paired t-test. Each sample is coming from an individual and not a group. So for each mother dnm there is a father dnm. 
  # Was your test result statistically significant? Interpret your result as it relates to the number of paternally and maternally inherited DNMs.
  # Yes. It was statistically significant with a p-value of 2.2e-16. This value indicates to us that our data is explained in a manner that
  # the amount of dnms is different between paternal/maternal lineages.
  

