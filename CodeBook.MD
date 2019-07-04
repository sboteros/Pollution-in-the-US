# NEI Database

This data contains all of the PM2.5 emissions data for 1999, 2002, 2005, and
2008. For each year, the table contains number of **tons** of PM2.5 emitted from
a specific type of source for the entire year. The available variables are:
  
+ `fips`: A five-digit number (represented as a string) indicating the U.S.
county
+ `SCC`: The name of the source as indicated by a digit string (see source code
classification table)
+ `Pollutant`: A string indicating the pollutant
+ `Emissions`: Amount of PM2.5 emitted, in tons
+ `type`: The type of source (point, non-point, on-road, or non-road)
+ `year`: The year of emissions recorded

# SCC Database

This data provides a mapping from the SCC digit strings in the Emissions table
to the actual name of the PM2.5 source. The sources are categorized in a few
different ways from more general to more specific. The available variables are:

+ `SCC`
+ `Data.Category`
+ `Short.Name`
+ `EI.Sector`
+ `Option.Group`
+ `Option.Set`
+ `SCC.Level.One`
+ `SCC.Level.Two`
+ `SCC.Level.Three`
+ `SCC.Level.Four`
+ `Map.To`
+ `Last.Inventory.Year`
+ `Created_Date`
+ `Revised_Date`
+ `Usage.Notes`