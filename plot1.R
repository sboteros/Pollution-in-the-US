# Total PM 2.5 in the United States. Plot 1.
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
  
# 3. Total emmissions
  # Have total emissions from PM2.5 decreased in the United States from 1999 to
  # 2008? Using the **base** plotting system, make a plot showing the total
  # PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and
  # 2008.
  
  # 3.1. Compute total emissions
  nei <- group_by(nei, year) %>%
    summarise(total = sum(Emissions)) %>%
    mutate(total = total / 1000000) %>%
    print
  
  # 3.2. Plot total emissions
  png(here("plot1.png"))
  with(nei, plot(year, total, type = "b", main = "Total Emissions in the US",
                 xlab = "Year", 
                 ylab = "Total PM2.5 emissions (millions of tons)"))
  dev.off()