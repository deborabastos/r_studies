library(tidyverse)
library(palmerpenguins)
library(ggthemes)
library(httpgd)
library(summarytools)
library(nycflights13)

# https://r4ds.hadley.nz/data-visualize.html
# https://dplyr.tidyverse.org/articles/programming.html


############################### 2.1 Coding basics ##############################
my_bar_plot <- ggplot(mpg, aes(x = class)) +
  geom_bar()
my_scatter_plot <- ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)

############################## 3 DATA TRANSFORMATION ###########################
#################################### 3.2 ROWS ##################################
# filter()
# arrange()
# distinct()


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
# sort = TRUE arranges them in descending order of the number of occurrences

############################### 3.2 Exercises ###############################
# 1
flights |>
  filter(arr_delay >= 120) |>
  View()

flights |>
  filter(dest == "IAH" | dest == "HOU") |>
  View()

flights |>
  filter(carrier %in% c("UA", "AA", "DL")) |>
  View()

flights |>
  filter(month %in% 7:9) |>
  View()

flights |>
  filter(dep_delay >= 60 & arr_delay <= 30) |>
  View()

flights |>
  filter(arr_delay > 120 & dep_delay <= 0) |>
  View()

# 2
flights |>
  arrange(desc(dep_delay)) |>
  View()

flights |>
  arrange(dep_time) |>
  View()

# 3
# velocidade = (distância / tempo)

flights |>
  mutate(speed = (distance / air_time)) |>
  arrange(desc(distance / air_time)) |>
  View()

# Ou pode estar falando do voo mais curto
flights |>
  arrange(air_time) |>
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
# system.time measures how much time it takes to run the code inside it
system.time(flights |>
  arrange(distance) |>
  filter(air_time < 60))

system.time(
  flights |>
    filter(air_time < 60) |>
    arrange(distance)
)

################################## 3.3 COLUMNS ################################
# mutate()
# select()
# rename()
# relocate()

flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60
  ) |>
  View()


# The . indicates that .before is an argument to the function, not the name of a third new variable we are creating
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  ) |>
  View()

# .keep argument control which variables are kept - all, used, unused, none
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  ) |>
  View()

flights |>
  select(year, month, day)

flights |>
  select(year:day) 

flights |> 
  select(!year:day)

flights |> 
  select(where(is.character))

flights |> 
  select(starts_with("d"))

flights |> 
  select(ends_with("delay"))

flights |>
  select(contains("arr"))

# You can rename variables as you select() them by using =
flights |> 
  select(tail_num = tailnum)

# If you want to keep all the existing variables and just want to rename a few, you can use rename()
flights |>
  rename(tail_num = tailnum)

#By default relocate() moves variables to the front:
flights |> 
  relocate(time_hour, air_time)

flights |>
  relocate(year:dep_time, .after = time_hour)

flights |> 
  relocate(starts_with("arr"), .before = dep_time)

############################### 3.3 Exercises ###############################
# 1
flights |>
  select(dep_time, sched_dep_time, dep_delay) |>
  View()

# 2
flights |>
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |>
  select(4, 6, 7, 9)

flights |>
  select(4:9, -5, -8)

flights |>
  select(starts_with("dep") | starts_with("arr"))

variables <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
select(flights, all_of(variables))

select(flights, any_of(variables))

select(flights, !!variables)


select(flights, matches("^(dep|arr)_(time|delay)$"))


# 3
flights |>
  select(year, year, sched_dep_time, year, dep_delay) |>
  View()
# The select() call ignores the duplication.
# This behavior is useful because it means that we can use select() with everything() in order to easily change the order of columns without having to specify the names of all the columns.


# 4
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
select(flights, any_of(variables))

#all_of() will raise an error if one of the variable names is not present, while any_of() will ignore it.

# 5
flights |> select(contains("TIME"))
# The default behavior for contains() is to ignore case. 

flights |>
  select(contains("TIME", ignore.case = FALSE))

# 6
flights |>
  select(air_time_min = air_time, everything())

# 7
flights |> 
  select(tailnum) |> 
  arrange(arr_delay)

flights |> 
  select(tailnum, everything()) |> 
  arrange(arr_delay)


################################## 3.4 PIPE ################################

flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

################################## 3.5 GROUPS ################################
