library(ggplot2)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

gruping <- inner_join(NEI, SCC, by='SCC')

gruping <- gruping %>% select(fips, Short.Name, EI.Sector, Emissions, year) %>% 
  filter(grepl("Vehicles",EI.Sector),grepl("Motorcycles",Short.Name),fips=='24510'|fips=='06037') %>% 
  group_by(year, fips) %>% summarise(Emissions=sum(Emissions))

pl <- ggplot(gruping, aes(x=year, y=Emissions)) + geom_line(aes(color=fips), size = 1) + xlab('Year') + 
  
  ylab('PM2.5 emission') + ggtitle('Emissions from motor vehicle (tons), (1999 - 2008)') + 
  
  scale_color_hue(name = 'Cities', breaks=c('24510','06037'),labels=c("Baltimore","Los Angeles"))


print(pl)

dev.copy(png, "Finalplot6.png") 

dev.off()