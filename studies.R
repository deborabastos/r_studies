library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)

# https://r4ds.hadley.nz/data-visualize.html


############################### 1.2 FIRST STEPS ###############################
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
############################### 1.2 Exercises ###############################
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
	geom_point() +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)
) +
  geom_point() +
  geom_smooth(method = "lm")


# 4
ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_point()


ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_boxplot(aes(color = species))


ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_violin(aes(color = species))

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)) +
  geom_jitter(aes(color = species)) +
  geom_smooth(method = "lm")

ggplot(data = penguins, 
			mapping = aes(x = species, y = bill_depth_mm)) +
	geom_violin(aes(color = species)) +
	geom_jitter(aes(color = species))


# 5
ggplot(data = penguins) + 
  geom_point()
# falta especificar x e y

ggplot(data = penguins,
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) + 
  geom_point()



# 6
ggplot(data = penguins, 
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point()

ggplot(data = penguins, 
			mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point(na.rm = TRUE)
#na.rm: If FALSE, the default, missing values are removed with a warning. 
# If TRUE, missing values are silently removed.

# 7 
penguins |>
	ggplot(mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
	geom_point(na.rm = TRUE) +
	labs(title = "Data come from the palmerpenguins package.",
			x = "Bill length (mm)",
			y = "Bill depth (mm)")

# 8
penguins |>
	ggplot(mapping = aes(
					x = flipper_length_mm, 
					y = body_mass_g)) +
	geom_point(mapping = aes(color = bill_depth_mm), na.rm = TRUE) +
	geom_smooth()

#bill_depth_mm aesthetic should be color mapped in the 
#geom_point() function level. It should not be done at the global level, 
#because then it will even be an aesthetic for geom_smooth resulting in multiple 
#smoother lines fitted for each level of bill_depth_mm , and possible result in 
#an error because bill_depth_mm is not a categorical variable or a factor variable 
#with certain distinct categories or levels.

penguins |>
	ggplot(mapping = aes(
					x = flipper_length_mm, 
					y = body_mass_g,
					color = bill_depth_mm)) +
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
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )

###############################################################################

############################## 1.3 GGPLOT2 CALLS ##############################
# Pipe
penguins |> 
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

######################## 1.4 VISUALIZING DISTRIBUTIONS ########################


