library("dplyr")
library("ggplot2")
library("forcats")
library("plotly")

use_of_force_data <- read.csv("//Users//nicknugraha//PODUW//powerNAP//Use_Of_Force.csv")

use_of_force_data <- use_of_force_data[-c(13899:14095), ]

years <- use_of_force_data %>% 
  summarise(year = substr(Occured_date_time, 7, 10))

use_of_force_data["Occured_date_time"] <- years

num_reports_per_year <- use_of_force_data %>% 
  group_by(Occured_date_time) %>% 
  summarise(n = n())

reports_over_time <- ggplot(num_reports_per_year) +
  geom_col(mapping = aes(x = Occured_date_time, y = n, text = paste0("Year: ", Occured_date_time, "\nNumber of Reports: ", n))) +
  labs(title = "Number of Reports Over Time", x = "Year", y = "Number of Reports")

interactive_time_chart <- ggplotly(reports_over_time, tooltip = "text")

interactive_time_chart
