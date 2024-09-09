library(tidyverse)



#subset dataset
iris_setosa <- iris %>%
  filter(Species == 'setosa')

ggplot(data=iris_setosa, mapping = aes(x= Sepal.Width, y= Sepal.Length))+
  geom_point()

m1 <- lm(data = iris_setosa,
   formula = Sepal.Length ~ 1 + Sepal.Width)


summary(m1)
