library(tidyverse)

top_songs <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "rank",
    values_drop_na = TRUE
  ) |>
  mutate(
    week = readr::parse_number(week),
    rank = as.numeric(rank)
  ) |>
  filter(artist %in% head(unique(artist), 8))

write_rds(top_songs, file = "clean_data.rds")
