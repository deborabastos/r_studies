library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)
library(summarytools)
library(nycflights13)

# https://r4ds.hadley.nz/data-visualize.html


############################### 2.1 Coding basics ##############################
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)

############################## 3 DATA TRANSFORMATION ###########################
glimpse(flights)

flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )


flights |>
  filter(dep_delay > 120)

# Flights that departed on January 1
flights |>
  filter(month == 1 & day == 1)

# Flights that departed in January or February
flights |>
  filter(month == 1 | month == 2)

# A shorter way to select flights that departed in January or February
flights |>
  filter(month %in% c(1, 2))


flights |>
  arrange(year, month, day, dep_time)


flights |>
  arrange(desc(dep_delay))

# Remove duplicate rows, if any
flights |>
  distinct()

# Find all unique origin and destination pairs
flights |>
  distinct(origin, dest)

flights |>
  distinct(origin, dest, .keep_all = TRUE)

flights |>
  count(origin, dest, sort = TRUE)

############################### 3.2 Exercises ###############################
# 1
flights |>
  filter(arr_delay >= 120) |>
  View()

flights |>
  filter(dest == "IAH" | dest == "HOU") |>
  View()

flights |>
  filter(carrier %in% c("AA", "UA", "DL")) |>
  View()

flights |>
  filter(month %in% c(7, 8, 9)) |>
  View()

flights |>
  filter(arr_delay > 120 & dep_delay <= 0) |>
  View()

flights |>
  filter(dep_delay >= 60 & arr_delay <= 30) |>
  View()

# 2
flights |>
  arrange(desc(dep_delay)) |>
  View()

flights |>
  arrange(dep_time) |>
  View()

# 3
flights |>
  arrange(desc(distance / air_time)) |>
  View()

# 4
flights |>
  distinct(year, month, day) |>
  count()

# 5
flights |>
  arrange(desc(distance)) |>
  select(origin, dest, distance, air_time, carrier) |>
  distinct(origin, dest, .keep_all = TRUE) |>
  View()

flights |>
  arrange(distance) |>
  select(origin, dest, distance, air_time, carrier) |>
  distinct(origin, dest, .keep_all = TRUE) |>
  View()

# 6
system.time(flights |>
  arrange(distance) |>
  filter(air_time < 60))

system.time(
  flights |>
    filter(air_time < 60) |>
    arrange(distance)
)
