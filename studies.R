library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)

# https://r4ds.hadley.nz/data-visualize.html

# Print a preview of the data frame contents
penguins

# To see all variables and the first few observations of each variable
glimpse(penguins)

ggplot(
	data = penguins,
	mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
	geom_point(mapping = aes(color = species))
