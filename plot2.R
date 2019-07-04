# Total PM 2.5 in Baltimore City. Plot 2.
# Exploratory data analysis course.
# Data science specialization.
# Santiago Botero Sierra
# sboteros@unal.edu.co
# Date: 2019/087/04
# Encoding: UTF-8

# 1. Global settings
  paquetes <- c("dplyr", "ggplot2", "here")
  for (i in paquetes) {
    if (!require(i, character.only = TRUE)) {
      install.packages(i)
    }
    library(i, character.only = TRUE)
  }
  rm(list = c("paquetes", "i"))
  
# 2. Downloading and loading data
  # 2.1. Creating data directory
  if (!dir.exists(here("data"))) { dir.create(here("data")) }
  
  # 2.2. Downloading and unziping data
  if (!file.exists(here("data", "nei_data.zip"))) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  here("data", "nei_data.zip"))
    unzip(here("data", "nei_data.zip"), exdir = here("data"))
  }
  
  # 2.3. Reading data
  nei <- readRDS(here("data", "summarySCC_PM25.rds")) %>% 
    tbl_df %>% print
  scc <- readRDS(here("data", "Source_Classification_Code.rds")) %>% 
    tbl_df %>% print
  
# 3. Total emmissions in Baltimore City
  # Have total emissions from PM2.5 decreased in the **Baltimore City**,
  # Maryland (`fips=="24510"`) from 1999 to 2008? Use the **base** plotting
  # system to make a plot answering this question.
  
  # 3.1. Compute total emissions in Baltimore City
  nei <- group_by(nei, year, fips) %>%
    summarise(total = sum(Emissions)) %>%
    filter(fips == "24510") %>%
    print
  
  # 3.2. Plot total emissions in Baltimore City
  png(here("plot2.png"))
  with(nei, plot(year, total, type = "b", 
                 main = "Total Emissions in Baltimor City",
                 xlab = "Year",  ylab = "Total PM2.5 emissions (ton)"))
  dev.off()