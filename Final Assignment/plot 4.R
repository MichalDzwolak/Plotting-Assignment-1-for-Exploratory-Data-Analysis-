library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

gruping <- inner_join(NEI, SCC, by='SCC')

gruping <- gruping %>% select(Short.Name, EI.Sector, Emissions, year) %>% 
  filter(grepl("Fuel Comb",EI.Sector),grepl("Coal",Short.Name)) %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

pl <- ggplot(gruping, aes(x=year, y=Emissions)) + geom_line(size = 1) + xlab('Year') + ylab('PM2.5 emission') + ggtitle('Emissions from coal combustion-related sources (tons), U.S (1999 - 2008)')

print(pl)

dev.copy(png, "Finalplot4.png") 

dev.off()