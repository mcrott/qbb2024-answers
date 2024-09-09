library(tidyverse)
library(palmerpenguins)
library(broom)

head(penguins)
glimpse(penguins)


lm(data = penguins,
   formula = bill_length_mm ~ 1 + bill_depth_mm + species) %>%
  summary()



lm(data = penguins,
   formula = bill_depth_mm ~ 1  + bill_length_mm) %>%
  summary()

ggplot(data = penguins,
       mapping = aes(x=bill_depth_mm,
                     y=bill_length_mm,
                     color = species)) +
  geom_point() +
  stat_smooth(method = 'lm')









27.6224 + 0.5317*17.5 + 9.9709*0 + 10.4890*1 + 2.8938*1

new_penguin = tibble( 
  species = 'Gentoo',
  bill_depth_mm = 17.5,
  sex = 'male',
  )

predict(full_model, newdata = new_penguin)