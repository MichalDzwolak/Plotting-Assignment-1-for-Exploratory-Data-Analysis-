library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")

gruping <- NEI %>% group_by(year) %>% summarise(Sum=sum(Emissions))

plot(gruping$year, gruping$Sum/1000, type = 'l', ylab = 'PM2.5 emission (in K)', xlab = 'Year', main = 'Emissions from PM2.5 decrease (tons), US (1999 - 2008, all sources)')

dev.copy(png, "Finalplot1.png") 

dev.off()