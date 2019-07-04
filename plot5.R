# PM 2.5 emissions from motor vehicle sources in Baltimore City. Plot 5.
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
  
# 3. Emissions from motor vehicle sources in Baltimor City
  # How have emissions from motor vehicle sources changed from 1999–2008 in
  # **Baltimore City**?
  
  # 3.1. Identify emissions from vehicle sources
  scc <- filter(scc, grepl("vehicle", Short.Name, ignore.case = TRUE))
  
  # 3.2. Compute emissions from vehicle sources in Baltimore City
  nei <- filter(nei, (SCC %in% scc$SCC) & (fips == "24510")) %>%
    group_by(year) %>%
    summarise(total = sum(Emissions)) %>%
    print
  
  # 3.2. Plot emissions from vehicle sources in Baltimore City
  png(here("plot5.png"))
  ggplot(nei, aes(year, total)) + geom_line() +
    labs(title = "Emissions from vehicle sources in Baltimore City",
         y = "Total PM2.5 Emissions (tons)") + theme_bw()
  dev.off()