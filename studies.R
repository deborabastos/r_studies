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
	geom_point(mapping = aes(color = species,  shape = species)) +
  geom_smooth(method = "lm") +
	labs(
		title = "Body mass and flipper length",
		subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
		x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
	) +
	scale_color_colorblind()

########## Exercises ##########
# 1
num_rows <- nrow(penguins)
num_col <- ncol(penguins)

print(paste("O dataframe tem", num_rows, "linhas e", num_col, "colunas."))

# 2
?penguins
#bill_length_mm: a number denoting bill length (millimeters)

# 3
ggplot(data = penguins, 
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point()


# 4
ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_point()

ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_col()


# 5
ggplot(data = penguins) + 
  geom_point()

# 6
ggplot(data = penguins, 
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point(na.rm = TRUE)
#na.rm: If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.


# 7 
ggplot(data = penguins, 
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point(na.rm = TRUE) +
	labs(title = "Data come from the palmerpenguins package.",
			x = "Bill length (mm)",
			y = "Bill depth (mm)")

# 8
penguins
ggplot(data = penguins, 
			mapping = aes(x = flipper_length_mm, y = body_mass_g, color = bill_depth_mm)) +
	geom_point(na.rm = TRUE) +
	geom_smooth()

# 9
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)


ggplot(
  data = penguins,
	mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = island)) +
  geom_smooth(se = FALSE)

# 10
