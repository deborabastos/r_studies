library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)
library(summarytools)

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
  geom_point(mapping = aes(color = species, shape = species)) +
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
# bill_length_mm: a number denoting bill length (millimeters)

# 3
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species, shape = species)
) +
  geom_point() +
  geom_smooth(method = "lm")


# 4
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_point()


ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_boxplot(aes(color = species))


ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_violin(aes(color = species))

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_jitter(aes(color = species)) +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm)
) +
  geom_violin(aes(color = species)) +
  geom_jitter(aes(color = species))


# 5
ggplot(data = penguins) +
  geom_point()
# falta especificar x e y

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()


# 6
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(na.rm = TRUE)
# na.rm: If FALSE, the default, missing values are removed with a warning.
# If TRUE, missing values are silently removed.

# 7
penguins |>
  ggplot(mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(na.rm = TRUE) +
  labs(
    title = "Data come from the palmerpenguins package.",
    x = "Bill length (mm)",
    y = "Bill depth (mm)"
  )

# 8
penguins |>
  ggplot(mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g
  )) +
  geom_point(mapping = aes(color = bill_depth_mm), na.rm = TRUE) +
  geom_smooth()

# bill_depth_mm aesthetic should be color mapped in the
# geom_point() function level. It should not be done at the global level,
# because then it will even be an aesthetic for geom_smooth resulting in multiple
# smoother lines fitted for each level of bill_depth_mm , and possible result in
# an error because bill_depth_mm is not a categorical variable or a factor variable
# with certain distinct categories or levels.

penguins |>
  ggplot(mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g,
    color = bill_depth_mm
  )) +
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

ggplot(penguins, aes(x = species)) +
  geom_bar()

# reorder the bars based on their frequencies
ggplot(penguins, aes(x = fct_infreq(species))) +
  geom_bar()

# numerical variable
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 20)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 2000)

ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

############################### 1.4 Exercises ###############################
# 1
penguins |>
  ggplot(aes(y = species)) +
  geom_bar()

penguins |>
  ggplot(aes(y = fct_infreq(species))) +
  geom_bar()

# 2
penguins |>
  ggplot(aes(x = species)) +
  geom_bar(color = "red")


penguins |>
  ggplot(aes(x = species)) +
  geom_bar(fill = "red")

# 3
# o bins define o número de barras do histograma

# 4
diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram()

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.05)

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.10)

diamonds |>
  ggplot(aes(x = carat)) +
  geom_histogram(binwidth = 0.5)

###############################################################################

######################## 1.4 VISUALIZING RELALTIONSHIPS #######################

ggplot(penguins, aes(x = species, y = body_mass_g)) +
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) +
  geom_density(linewidth = 0.75)

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density()

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) +
  geom_density(alpha = 0.5)

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))


ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island)) +
  facet_wrap(~island)

############################### 1.4 Exercises ###############################
# 1
mpg
# categorical: manufacturer, model, trans, drv, fl, class
# numrical: displ, year, cyl, cty, hwy

# 2
mpg |>
  ggplot(aes(x = hwy, y = displ)) +
  geom_point()

mpg |>
  ggplot(aes(x = hwy, y = displ, color = cty)) +
  geom_point()

mpg |>
  ggplot(aes(x = hwy, y = displ, size = cty)) +
  geom_point()

mpg |>
  ggplot(aes(x = hwy, y = displ, color = cty, size = cty)) +
  geom_point()

# A continuous variable cannot be mapped to the shape aesthetic.
mpg |>
  ggplot(aes(x = hwy, y = displ, shape = cty)) +
  geom_point()

mpg |>
  ggplot(aes(x = hwy, y = displ, shape = drv)) +
  geom_point()

# 3
mpg |>
  ggplot(aes(x = hwy, y = displ, linewidth = drv)) +
  geom_point()

# 4
mpg |>
  ggplot(aes(
    x = hwy,
    y = cty,
    size = class,
    color = class,
    shape = class
  )) +
  geom_point(alpha = 0.5)


# 5
penguins |>
  ggplot(aes(
    x = bill_depth_mm, y = bill_length_mm
  )) +
  geom_point() +
  geom_smooth(
    se = FALSE,
    method = "lm"
  )

penguins |>
  ggplot(aes(
    x = bill_depth_mm, y = bill_length_mm, color = species
  )) +
  geom_point() +
  geom_smooth(
    se = FALSE,
    method = "lm"
  )

penguins |>
  ggplot(aes(
    x = bill_depth_mm, y = bill_length_mm, color = species
  )) +
  geom_point() +
  geom_smooth(
    se = FALSE,
    method = "lm"
  ) +
  facet_wrap(~species)


# 6
ggplot(
  data = penguins,
  mapping = aes(
    x = bill_length_mm, y = bill_depth_mm,
    color = species, shape = species
  )
) +
  geom_point()

# 7
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")


###############################################################################

############################ 1.5 SAVING YOUR PLOTS ###########################

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point()
ggsave(filename = "penguin-plot.png")


ggplot(mpg, aes(x = class)) +
  geom_bar()
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave("mpg.jpeg")
