library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

gruping <- NEI %>% select(fips, year, Emissions) %>% filter(fips=='24510')

gruping <- gruping %>% group_by(year) %>% summarise(Sum=sum(Emissions))

plot(gruping$year, gruping$Sum, type = 'l', ylab = 'PM2.5 emission', xlab = 'Year', main = 'Emissions from PM2.5 (tons), Baltimore City (1999 - 2008, all sources)')

dev.copy(png, "Finalplot2.png") 

dev.off()