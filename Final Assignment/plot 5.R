library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

gruping <- inner_join(NEI, SCC, by='SCC')

gruping <- gruping %>% select(fips, Short.Name, EI.Sector, Emissions, year) %>% 
  filter(grepl("Vehicles",EI.Sector),grepl("Motorcycles",Short.Name),fips=='24510') %>% group_by(year) %>% summarise(Emissions=sum(Emissions))


pl <- ggplot(gruping, aes(x=year, y=Emissions)) + geom_line(size = 1) + xlab('Year') + ylab('PM2.5 emission') + ggtitle('Emissions from motor vehicle (tons), Baltimore City (1999 - 2008)')

print(pl)

dev.copy(png, "Finalplot5.png") 

dev.off()