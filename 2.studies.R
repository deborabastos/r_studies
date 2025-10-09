library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)
library(summarytools)

# https://r4ds.hadley.nz/data-visualize.html


############################### 2.1 Coding basics ##############################
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)

a 