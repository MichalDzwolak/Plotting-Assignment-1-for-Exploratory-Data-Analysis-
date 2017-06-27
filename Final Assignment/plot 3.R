library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")

gruping <- NEI %>% select(fips, year, Emissions, type) %>% filter(fips=='24510')

gruping <- gruping %>% group_by(year, type) %>% summarise(Emissions=sum(Emissions))

pl <- ggplot(gruping, aes(x=year, y=Emissions)) + geom_line(aes(color=type), size = 1) + xlab('Year') + ylab('PM2.5 emission ') + ggtitle('Emissions from PM2.5 (tons), Baltimore City (1999 - 2008)')

print(pl)

dev.copy(png, "Finalplot3.png") 

dev.off()