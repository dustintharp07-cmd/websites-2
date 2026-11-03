library(tidyverse)

top_songs <- read_rds("clean_data.rds")

artists <- top_songs |>
  distinct(artist) |>
  pull(artist)

artist_palette <- c(
  "#332288", "#88CCEE", "#44AA99", "#117733",
  "#999933", "#DDCC77", "#CC6677", "#882255"
)
artist_colors <- stats::setNames(artist_palette[seq_along(artists)], artists)

billboard_plot <- ggplot(top_songs, aes(x = week, y = rank, color = artist, group = track)) +
  geom_line(linewidth = 1.05, alpha = 0.85) +
  geom_point(size = 1.5, alpha = 0.9) +
  scale_x_continuous(
    breaks = scales::breaks_width(10),
    expand = expansion(mult = c(0.01, 0.03))
  ) +
  scale_y_reverse(
    breaks = c(1, seq(10, 100, by = 10)),
    expand = expansion(mult = c(0.02, 0.02))
  ) +
  scale_color_manual(values = artist_colors, breaks = artists) +
  labs(
    x = "Week on chart",
    y = "Billboard Hot 100 rank (1 = highest)",
    title = "A song's journey on the Billboard Hot 100",
    subtitle = "Weekly chart positions for eight artists"
  ) +
  theme_minimal(base_size = 12, base_family = "sans") +
  theme(
    plot.title = element_text(face = "bold", size = 16, color = "#172B4D"),
    plot.subtitle = element_text(size = 10.5, color = "#65758B"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(color = "#EDF1F5", linewidth = 0.35),
    panel.grid.major.y = element_line(color = "#DCE3EA", linewidth = 0.45),
    axis.title = element_text(color = "#425466"),
    axis.text = element_text(color = "#526174"),
    plot.title.position = "plot",
    plot.margin = margin(8, 8, 4, 8),
    legend.position = "none"
  )

ggsave("billboard.png", plot = billboard_plot, width = 10, height = 6, dpi = 300)
