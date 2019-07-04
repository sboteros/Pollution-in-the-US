# PM 2.5 emissions from coal-combustion related sources. Plot 4.
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
  
# 3. Emissions from coal combustion-related sources
  # Across the United States, how have emissions from coal combustion-related
  # sources changed from 1999–2008?
  
  # 3.1. Identify emissions from coal combustion-related sources
  scc <- filter(scc, grepl("coal", Short.Name, ignore.case = TRUE))
  
  # 3.2. Compute total emissions from coal combustion-related sources
  nei <- filter(nei, SCC %in% scc$SCC) %>%
    group_by(year) %>%
    summarise(total = sum(Emissions) / 1000) %>%
    print
  
  # 3.2. Plot total emissions from coal combustion-related sources
  png(here("plot4.png"))
  ggplot(nei, aes(year, total)) + geom_line() +
    labs(title = "Emissions from coal combustion-related sources in the US",
         y = "Total PM2.5 Emissions (thousands of tons)") + theme_bw()
  dev.off()