# Load required packages
library(tidyverse)      # Data manipulation and visualization
library(ggtext)         # Text formatting in ggplot2
library(tidytext)       # Text mining tools
library(here)           # File path management
library(circlize)       # Circular visualization
library(schrute)        # The Office dataset

# Set base path for output files
base_path <- here("faceted-chord-diagram")

# Clean and standardize character names in the dataset
theoffice <- theoffice %>% 
  mutate(
    character = str_remove_all(character, "[\":]"),      # Remove quotes and colons
    character = str_remove_all(character, "\\\""),       # Remove escaped quotes
    character = case_match(
      character,
      "(Pam's mom) Heleen" ~ "Pam's mom",
      "AJ" ~ "A.J.",
      "abe" ~ "Gabe",
      .default = character
    )) 

# Get top 10 characters by number of lines
top_character_names <- theoffice %>% 
  count(character, sort = TRUE) %>% 
  slice_max(order_by = n, n = 10) %>% 
  arrange(-n) %>% 
  pull(character)

# Create dataset of character mentions
theoffice_mentions <- 
  theoffice %>% 
  filter(character %in% top_character_names) %>%         # Keep only top 10 characters
  unnest_tokens(word, text, token = "words", to_lower = FALSE) %>%  # Split text into words
  filter(word %in% top_character_names) %>%             # Keep only mentions of top characters
  # Convert characters to ordered factors
  mutate(
    character = factor(character, levels = top_character_names),
    character_mentioned = factor(word, levels = top_character_names)) %>% 
  select(index, season, episode, character, character_mentioned)

# Aggregate mentions and create complete matrix
theoffice_mentions_agg <- theoffice_mentions %>% 
  group_by(character, character_mentioned) %>% 
  summarize(
    total_mentions = n(),                               # Count total mentions
    mentions_lines = n_distinct(index),                 # Count unique lines with mentions
    .groups = "drop"
  ) %>% 
  # Ensure all character combinations exist (including zeros)
  complete(character, character_mentioned, fill = list(total_mentions = 0, mentions_lines = 0)) %>% 
  arrange(character, character_mentioned)



# ---- drawin a chord
# Create a square matrix from mentions data, with character names as row and column names
mat <- matrix(theoffice_mentions_agg$total_mentions, ncol = length(top_character_names))
rownames(mat) <- top_character_names
colnames(mat) <- top_character_names

# Define color palette for characters and background
pal_office <- 
  c("#FBA93A", "#cc2d36", "#93BFE5", "#D8ACD8", "#f0813c", "#F0F4EC", "#2AA3A6",
    "#4BD9EF", "#4bad6d", "#5D77AA")
bg_color <- colorspace::darken("#435774", 0.2)


# Create and save the chord diagram
ragg::agg_png(here(base_path, "17-network-the-office-mentions.png"),
              res = 500, width = 8, height = 8, units = "in", bg = bg_color)
par(
  family = "Outfit", cex = 2, col = "white", # font family, size, color
  bg = bg_color, 
  mai = rep(0.5, 4) # plot margin in inches
) 
chordDiagram(mat, transparency = 0.3, 
             grid.col = pal_office[1:10], # assign colors to each character
             link.border = "white", link.lwd = 0.2, # add thin white borders to connections
             annotationTrack = c("name", "grid"), # show only name and grid tracks (excluding axis)
             annotationTrackHeight = mm_h(c(3, 5)),
)
title(
  main = "Who speaks about whom?",
  sub = "top 10 characters in The Office\nSource: {schrute} R package. Visualisation: Ansgar Wolsing",
  col.main = "white", cex.main = 1.3)
invisible(dev.off())

# Display the saved plot in R Markdown
knitr::include_graphics("https://github.com/holtzy/R-graph-gallery/blob/master/character-interaction-analysis/17-network-the-office-mentions.png?raw=true")


