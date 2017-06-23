library(dplyr)
library(sqldf)

upload <- read.csv.sql("household_power_consumption.txt" ,sep=";",sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ")

upload$Date <- as.Date(upload$Date, "%d/%m/%Y") 

datato <- upload %>% select(Date, Global_active_power) %>% filter(Date ==as.Date('2007-02-01') | Date == as.Date('2007-02-02'))

with(datato, hist(as.numeric(Global_active_power), main = "Global Active Power", col = "red",xlab = "Global Active Power(kilowatts)", xlim = c(0,6))) 

dev.copy(png, "plot1.png", width = 480, height = 480) 

dev.off()
