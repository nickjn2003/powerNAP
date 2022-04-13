library("dplyr")
library("ggplot2")
library("forcats")
library("plotly")

use_of_force_data <- read.csv("//Users//nicknugraha//PODUW//powerNAP//Use_Of_Force.csv")

use_of_force_data <- use_of_force_data[-c(13899:14095), ]

num_reports_by_race <- use_of_force_data %>% 
  group_by(Subject_Race) %>% 
  summarise(n = n())

reports_by_race <- ggplot(num_reports_by_race) +
  geom_col(mapping = aes(x = n, y = fct_reorder(Subject_Race, n), fill = fct_rev(fct_reorder(Subject_Race, n)), text = paste0("Number of Incidents: ", n, "\nRace: ", Subject_Race))) +
  labs(title = "Number of Incidents by Race", x = "Number of Incidents", y = "Race", fill = "Race") +
  theme(axis.text.y = element_blank(), 
        axis.title.y = element_blank(), 
        axis.ticks.y = element_blank())

interactive_chart <- ggplotly(reports_by_race, tooltip = "text")

interactive_chart
