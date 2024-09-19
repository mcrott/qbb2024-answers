library("tidyverse")
library(palmerpenguins)
library(ggthemes)


penguins[, c("species",'island')]


ggplot(data = penguins,
       ) + 
  geom_point(mapping = aes(x = flipper_length_mm, 
                           y = body_mass_g, 
                           color = species, 
                           shape = species)) +
  scale_color_colorblind() +
  geom_smooth(mapping = aes(x = flipper_length_mm, 
                             y = body_mass_g), 
              method = lm) +
  xlab("Flipper Length (mm)") +
  ylab("Body Mass (g)") +
  ggtitle("Relationship between body mass and flipper length")
ggsave(filename = "/Users/cmdb/qbb2024-answers/d1-afternoon/crotteau_day1_afternoon_plot.pdf")


ggplot(data = penguins %>% filter(!is.na(sex)), 
       mapping = aes(x=factor(year),
                     y=body_mass_g,
                     color=sex)) +
  geom_density()

