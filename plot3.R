# Total PM 2.5 in Baltimore City, by type. Plot 3
# Exploratory data analysis course.
# Data science specialization.
# Santiago Botero Sierra
# sboteros@unal.edu.co
# Date: 2019/087/04
# Encoding: UTF-8

# 1. Global settings
  Sys.setlocale(locale = "en_US.utf8")
  
  # 1.2. Packages
  paquetes <- c("dplyr", "lubridate", "tidyr", "ggplot2", "here")
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
  
# 3. Total emmissions in Baltimore City, by type
  # Of the four types of sources indicated by the `type` (point, nonpoint,
  # onroad, nonroad) variable, which of these four sources have seen decreases
  # in emissions from 1999–2008 for **Baltimore City**? Which have seen
  # increases in emissions from 1999–2008? Use the **ggplot2** plotting system
  # to make a plot answer this question.
  
  # 3.1. Compute total emissions in Baltimore City, by type 
  nei <- group_by(nei, year, fips, type) %>%
    summarise(total = sum(Emissions)) %>%
    filter(fips == "24510") %>%
    print
  
  # 3.2. Plot total emissions in Baltimore City, by type 
  png(here("plot3.png"))
  with(nei, plot(year, total, type = "b", 
                 main = "Total Emissions in Baltimor City",
                 xlab = "Year",  ylab = "Total PM2.5 emissions (ton)"))
  dev.off()